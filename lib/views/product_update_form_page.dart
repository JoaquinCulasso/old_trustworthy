import 'package:flutter/material.dart';
import 'dart:io';

//firebase
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

//upload image
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:old_trustworthy/models/product.dart';

class ProductUpdateFormPage extends StatefulWidget {
  final Product product;

  const ProductUpdateFormPage({Key key, this.product}) : super(key: key);
  @override
  _ProductUpdateFormPageState createState() => _ProductUpdateFormPageState();
}

class _ProductUpdateFormPageState extends State<ProductUpdateFormPage> {
  File productImage;
  String _name;
  String _price;
  String _unit;
  String _category;

  String url;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar producto"),
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
            child: widget.product.image == null
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
    var _categoryList = [
      'Verdura',
      'Carne',
      'Fiambre',
      'Congelados',
      'Fruta',
      'Higiene personal',
      'Limpieza'
    ];
    var _unitList = ['KG', '100gr', 'Unidad'];
    var _valueCategorySelected = widget.product.category;
    var _valueUnitSelected = widget.product.unit;

    return SingleChildScrollView(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              productImage == null
                  ? Image.network(
                      widget.product.image,
                      height: 300.0,
                      width: 600.0,
                    )
                  : Image.file(
                      productImage,
                      height: 300.0,
                      width: 600.0,
                    ),
              SizedBox(
                height: 15.0,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Nombre producto"),
                initialValue: _name = widget.product.name,
                validator: (name) {
                  return name.isEmpty ? "Nombre producto es requerido" : null;
                },
                onSaved: (name) {
                  return _name = name;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Precio"),
                initialValue: _price = widget.product.price,
                validator: (price) {
                  return price.isEmpty ? "Precio es requerido" : null;
                },
                onSaved: (price) {
                  return _price = price;
                },
              ),
              SizedBox(height: 15.0),
              DropdownButtonFormField(
                value: _valueUnitSelected,
                hint: Text('Selecciona una unidad'),
                items: _unitList
                    .map((String unitSelected) => DropdownMenuItem<String>(
                          child: Text(
                            unitSelected,
                            style: TextStyle(),
                          ),
                          value: unitSelected,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _valueUnitSelected = val;
                  });
                },
                validator: (unit) {
                  return unit == null ? "Unidad es requerido" : null;
                },
                onSaved: (unit) {
                  return _unit = unit;
                },
              ),
              SizedBox(height: 15.0),
              DropdownButtonFormField(
                value: _valueCategorySelected,
                hint: Text('Selecciona una categoria'),
                items: _categoryList
                    .map((String categorySelected) => DropdownMenuItem<String>(
                          child: Text(
                            categorySelected,
                            style: TextStyle(),
                          ),
                          value: categorySelected,
                        ))
                    .toList(),
                onChanged: (val) {
                  setState(() {
                    _category = val;
                  });
                },
                validator: (category) {
                  return category == null ? "Etiqueta es requerido" : null;
                },
                onSaved: (category) {
                  return _category = category;
                },
              ),
              SizedBox(height: 15.0),
              RaisedButton(
                elevation: 10.0,
                child: Text("Actualizar Producto"),
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
      //delete image and update if new image
      if (productImage == null) {
        url = widget.product.image;
        print('current image');
      } else {
        FirebaseStorage.instance
            .ref()
            .child("Vieja_Confiable")
            .getStorage()
            .getReferenceFromUrl(widget.product.image)
            .then((value) => value.delete());

        // Subir imagen a firebase
        final StorageReference postImageRef =
            FirebaseStorage.instance.ref().child("Vieja_Confiable");

        var timeKey = DateTime.now();

        //Actualizo la img en data storage

        final StorageUploadTask uploadTask = postImageRef
            .child(timeKey.toString() + ".jpg")
            .putFile(productImage);

        var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
        url = imageUrl.toString();
        print("Image url: " + url);

        // Guardar el post a firebase database: database realtime

      }
      saveToDatabase(url);
      //vamos a probar guardar los datos a cloud firestore
      // saveToFirestore(url);
      Navigator.pop(context);
      Navigator.of(context).pushReplacementNamed('/productLoading');
      // Regresar a Home
      // Navigator.pop(context);
      // Navigator.push(context, MaterialPageRoute(builder: (context) {
      //   return MyHomePage();
      // }));
    }
  }

  void saveToDatabase(String url) {
    // Guardar un post (image, descripcion, date, time)
    var dbTimeKey = DateTime.now();
    var formatDate = DateFormat('MMM d, yyyy');
    var formatTime = DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    var data = {
      "image": url,
      "name": _name,
      "price": _price,
      "unit": _unit,
      "category": _category,
      "date": date,
      "time": time
    };

    FirebaseDatabase.instance
        .reference()
        .child('Vieja_Confiable')
        .orderByChild('image')
        .equalTo(widget.product.image)
        .onChildAdded
        .listen((event) {
      FirebaseDatabase.instance
          .reference()
          .child('Vieja_Confiable')
          .child(event.snapshot.key)
          .update(data);
    }, onError: (Object o) {
      final DatabaseError error = o;
      print('Error: ${error.code} ${error.message}');
    });
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
// import 'package:old_trustworthy/views/ProductUpdateFormPage.dart';

// class ProductUpdateFormPage extends StatefulWidget {
//   @override
//   _ProductUpdateFormPageState createState() => _ProductUpdateFormPageState();
// }

// class _ProductUpdateFormPageState extends State<ProductUpdateFormPage> {
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
//                                 return ProductUpdateFormPage();
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
