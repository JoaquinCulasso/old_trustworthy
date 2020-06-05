import 'package:flutter/material.dart';

class MyAddressPage extends StatefulWidget {
  @override
  _MyAddressPageState createState() => _MyAddressPageState();
}

class _MyAddressPageState extends State<MyAddressPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis direcciones'),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vieja_confiable.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: <Widget>[
                Form(
                  child: Column(
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Alias',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Calle',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Número',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Piso / Depto',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Entre calles',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Ciudad',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Barrio',
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Teléfono',
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(47, 87, 44, 1.0),
                        ),
                        child: MaterialButton(
                          child: Text(
                            'Continuar',
                            style:
                                TextStyle(fontSize: 25.0, color: Colors.white),
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget hijo1() {
  //   return Placeholder();
  // }

  // Widget hijo2() {
  //   return Placeholder();
  // }
}
