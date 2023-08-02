import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/db.dart';
import 'package:flutter_application_1/provedorClas.dart';
import 'package:url_launcher/url_launcher.dart';

class PorvedorW extends StatefulWidget {
  @override
  _PorvedorWState createState() => _PorvedorWState();
}

class _PorvedorWState extends State<PorvedorW> {
  List<ProvedorClass> provedores = [];

  void initState() {
    caragrProvedores();
    super.initState();
  }

  caragrProvedores() async {
    List<ProvedorClass> aux = await DB.getAllProvedores();
    setState(() {
      provedores = aux;
    });
  }

  void callPhoneNumber(String phoneNumber) async {
    print(phoneNumber);
    String url = 'tel:$phoneNumber';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir la aplicación de llamadas';
    }
  }

  void openMessagesApp(String phoneNumber) async {
    print(phoneNumber);
    final String url = 'sms:$phoneNumber';
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir la aplicación de mensajes.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: provedores.length,
      itemBuilder: (context, index) => Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.contact_page_outlined),
              title: Text(provedores[index].nombre),
              subtitle: Text(
                provedores[index].direccion,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                provedores[index].notas,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    callPhoneNumber(provedores[index].movil);
                  },
                  child: Icon(Icons.phone),
                ),
                ElevatedButton(
                  onPressed: () {
                    openMessagesApp(provedores[index].movil);
                  },
                  child: Icon(Icons.message),
                ),
                 ElevatedButton(
                  onPressed: () {
                    provedores[index].edicion=true;
                    Navigator.pushNamed(context,"/provedor",arguments: provedores[index]);
                  },
                  child: Icon(Icons.edit),
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Alerta"),
                          content: Text(
                              "¿Estás seguro de que desea eliminar el proveodr " +
                                  provedores[index].nombre +
                                  "?"),
                          actions: <Widget>[
                            ElevatedButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop(
                                    false); // Cierra el cuadro de diálogo y devuelve false
                              },
                            ),
                            ElevatedButton(
                              child: Text("Si"),
                              onPressed: () {
                                Navigator.of(context).pop(
                                    true); // Cierra el cuadro de diálogo y devuelve true
                              },
                            ),
                          ],
                        );
                      },
                    ).then((confirmacion) {
                      if (confirmacion ?? false) {
                        setState(() {
                          DB.deleteProvedor(provedores[index]);
                          provedores.removeAt(index);
                        });
                      }
                    });
                  },
                  child: Icon(Icons.delete),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
