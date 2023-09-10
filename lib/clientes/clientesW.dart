import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../db.dart';
import 'cargarInventarioCliente.dart';
import 'clientesClass.dart';
import 'clientesInventarioClass.dart';

class ClientesW extends StatefulWidget {
  ClientesW({Key? key}) : super(key: key);

  @override
  _ClientesWState createState() => _ClientesWState();
}

class _ClientesWState extends State<ClientesW> {
  List<ClienteClass> clientes = [];
  List<ClientesInventarioClass> inventarioClinete = [];

  _caragrClientes() async {
    List<ClienteClass> aux = await DB.getALLClientes();
    setState(() {
      clientes = aux;
    });
  }

  _caragarInventarioCliente(int idClienteInventario) async {
    List<ClientesInventarioClass> aux =
        await DB.getALLClientesInventario(idClienteInventario);
    setState(() {
      inventarioClinete = aux;
    });
  }

  void _callPhoneNumber(String phoneNumber) async {
    String url = 'tel:$phoneNumber';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir la aplicación de llamadas';
    }
  }

  void _openMessagesApp(String phoneNumber) async {
    final String url = 'sms:$phoneNumber';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir la aplicación de mensajes.';
    }
  }

  @override
  void initState() {
    _caragrClientes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: clientes.length,
      itemBuilder: (context, index) => InkWell(
        onTap: () {
           Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => cargarInventarioCliente(parametro: clientes[index].idCliente),
              ),
            );
          print('Card clicked');
        },
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'nombre: ${clientes[index].nombre}\n CI: ${clientes[index].ci}',
                ),
                subtitle: Text(
                  "dirección: ${clientes[index].direccion}\n ${clientes[index].notas}",
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.call),
                    onPressed: () {
                      _callPhoneNumber(clientes[index].movil);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.message),
                    onPressed: () {
                      _openMessagesApp(clientes[index].movil);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        "/agregarInventarioAlCliente",
                        arguments: clientes[index],
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      clientes[index].editar = true;
                      Navigator.pushNamed(
                        context,
                        "/crearCliente",
                        arguments: clientes[index],
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Alerta"),
                            content: Text(
                                "¿Estás seguro de que deseas eliminar al cliente ${clientes[index].nombre}?"),
                            actions: <Widget>[
                              ElevatedButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.of(context).pop(false);
                                },
                              ),
                              ElevatedButton(
                                child: Text("Sí"),
                                onPressed: () {
                                  Navigator.of(context).pop(true);
                                },
                              ),
                            ],
                          );
                        },
                      ).then((confirmacion) {
                        if (confirmacion ?? false) {
                          setState(() {
                            DB.deleteCliente(clientes[index]);
                            clientes.removeAt(index);
                          });
                        }
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}