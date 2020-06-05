import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:old_trustworthy/views/home_page.dart';

class ProductLoadingFormPage extends StatefulWidget {
  @override
  _ProductLoadingFormPageState createState() => _ProductLoadingFormPageState();
}

class _ProductLoadingFormPageState extends State<ProductLoadingFormPage> {
  File productImage;
  String _name;
  String _price;
  String _unit;
  String _label;

  String url; // url de la imagen
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cargar producto"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/vieja_confiable.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            child: productImage == null
                ? Text("Selecciona una imagen del telefono")
                : enableUpload(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        tooltip: "Agregar Imagen",
        child: Icon(Icons.add_a_photo),
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      productImage = tempImage;
    });
  }

  Widget enableUpload() {
    return SingleChildScrollView(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Image.file(
                productImage,
                height: 300.0,
                width: 600.0,
              ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Nombre producto"),
                validator: (name) {
                  return name.isEmpty ? "Nombre producto es requerido" : null;
                },
                onSaved: (name) {
                  return _name = name;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Precio"),
                validator: (price) {
                  return price.isEmpty ? "Precio es requerido" : null;
                },
                onSaved: (price) {
                  return _price = price;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Unidad"),
                validator: (unit) {
                  return unit.isEmpty ? "Unidad es requerido" : null;
                },
                onSaved: (unit) {
                  return _unit = unit;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Etiqueta"),
                validator: (label) {
                  return label.isEmpty ? "Etiqueta es requerido" : null;
                },
                onSaved: (label) {
                  return _label = label;
                },
              ),
              SizedBox(
                height: 15.0,
              ),
              RaisedButton(
                elevation: 10.0,
                child: Text("Agregar Producto"),
                textColor: Colors.white,
                color: Color.fromRGBO(47, 87, 44, 1.0),
                onPressed: uploadStatusImage,
              )
            ],
          ),
        ),
      ),
    ));
  }

  void uploadStatusImage() async {
    if (validateAndSave()) {
      // Subir imagen a firebase storage
      final StorageReference postIamgeRef =
          FirebaseStorage.instance.ref().child("Vieja_Confiable");
      var timeKey = DateTime.now();
      final StorageUploadTask uploadTask =
          postIamgeRef.child(timeKey.toString() + ".jpg").putFile(productImage);
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
      url = imageUrl.toString();
      print("Image url: " + url);

      // Guardar el post a firebase database: database realtime
      saveToDatabase(url);

      // Regresar a Home
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MyHomePage();
      }));
    }
  }

  void saveToDatabase(String url) {
    // Guardar un post (image, descripcion, date, time)
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();
    var data = {
      "image": url,
      "name": _name,
      "price": _price,
      "unit": _unit,
      "label": _label,
      "date": date,
      "time": time
    };

    ref.child("Vieja_Confiable").push().set(data);
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}

// import 'package:flutter/material.dart';
// import 'package:old_trustworthy/views/ProductLoadingFormPage.dart';

// class ProductLoadingFormPage extends StatefulWidget {
//   @override
//   _ProductLoadingFormPageState createState() => _ProductLoadingFormPageState();
// }

// class _ProductLoadingFormPageState extends State<ProductLoadingFormPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Carga de producto'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: ListView(
//           children: <Widget>[
//             Form(
//               child: Column(
//                 children: <Widget>[
//                   TextField(
//                     decoration: InputDecoration(
//                       labelText: 'Nombre producto',
//                     ),
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                       labelText: 'Precio',
//                     ),
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                       labelText: 'Unidad',
//                     ),
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                       labelText: 'Etiqueta',
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.max,
//                     children: <Widget>[
//                       Text(
//                         'Subir Foto',
//                         style: TextStyle(
//                           fontSize: 20.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(
//                           Icons.add_a_photo,
//                         ),
//                         iconSize: 40,
//                         color: Colors.green,
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) {
//                                 return ProductLoadingFormPage();
//                               },
//                             ),
//                           );
//                         },
//                       )
//                     ],
//                   ),
//                   // TextField(
//                   //   decoration: InputDecoration(
//                   //     labelText: 'Imagen',
//                   //   ),
//                   // ),
//                   Container(
//                     margin: EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.green,
//                     ),
//                     child: MaterialButton(
//                       child: Text(
//                         'Continuar',
//                         style: TextStyle(color: Colors.white, fontSize: 25.0),
//                       ),
//                       onPressed: () {},
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
