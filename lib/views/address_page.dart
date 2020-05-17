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
      body: Padding(
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
                      color: Colors.green,
                    ),
                    child: MaterialButton(
                      child: Text(
                        'Continuar',
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
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
    );
  }

  // Widget hijo1() {
  //   return Placeholder();
  // }

  // Widget hijo2() {
  //   return Placeholder();
  // }
}
