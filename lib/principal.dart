import 'package:flutter/material.dart';

class Principal extends StatelessWidget {
  const Principal({required Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Principal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/provedorPrincipal");
                      },
                      child: const Center(
                        child: Column(
                          children: [
                            Icon(
                              Icons.person_add_alt_rounded,
                              size: 50,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Provedores')
                          ],
                        ),
                      )),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/inventarioPrincipal");
                      },
                      child: const Column(children: [
                        Icon(Icons.inventory_2_outlined, size: 50),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Inventario"),
                      ])),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/gastos");
                      },
                      child: const Column(
                        children: [
                          Icon(
                            Icons.attach_money_outlined,
                            size: 50,
                          ),
                          Text("Gastos")
                        ],
                      )),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/editarMateriales");
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.edit,
                          size: 50,
                        ),
                        Text("Editar Materiales")
                      ],
                    ),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, "/clientePrincipal");
                    },
                    child: const Column(
                      children: [
                        Icon(
                          Icons.shopping_cart_checkout_rounded,
                          size: 50,
                        ),
                        Text("Clientes")
                      ],
                    ),
                  ),
                )),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                    child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Icon(Icons.ac_unit_sharp),
                  ),
                )),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: Expanded(
                  child: SizedBox(
                height: 150,
                width: 400,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.ac_unit_sharp),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
