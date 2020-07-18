import 'package:flutter/material.dart';
import 'dart:io';

//upload image
import 'package:image_picker/image_picker.dart';

//provider
import 'package:old_trustworthy/providers/database_provider.dart';
import 'package:provider/provider.dart';

class ProductLoadingFormPage extends StatefulWidget {
  @override
  _ProductLoadingFormPageState createState() => _ProductLoadingFormPageState();
}

class _ProductLoadingFormPageState extends State<ProductLoadingFormPage> {
  File productImage;
  String _name;
  String _price;
  String _unit;
  String _category;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final databaseProvider = Provider.of<DatabaseProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Cargar producto"),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) => (SafeArea(
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
                  : enableUpload(databaseProvider, context),
            ),
          ),
        )),
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

  Widget enableUpload(DatabaseProvider databaseProvider, BuildContext context) {
    var _categoryList = [
      'Carnes',
      'Congelados',
      'Frutas',
      'Lacteos fiambres',
      'Verduras',
      'Limpieza',
      'Higiene personal',
      'Almacen',
    ];
    var _unitList = [
      'KG',
      '100gr',
      'Unidad',
    ];

    var _valueCategorySelected;
    var _valueUnitSeleced;

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
                  if (price.isEmpty) {
                    return "precio es requerido";
                  } else if (double.tryParse(price) == null) {
                    return "Solo numeros";
                  } else {
                    return null;
                  }
                },
                onSaved: (price) {
                  return _price = price;
                },
              ),
              SizedBox(height: 15.0),
              DropdownButtonFormField(
                value: _valueUnitSeleced,
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
                    _valueUnitSeleced = val;
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
                    _valueCategorySelected = val;
                  });
                },
                validator: (category) {
                  return category == null ? "Categoria es requerido" : null;
                },
                onSaved: (category) {
                  return _category = category;
                },
              ),
              SizedBox(height: 15.0),
              databaseProvider.databaseState.isLoading
                  ? Center(child: CircularProgressIndicator())
                  : RaisedButton(
                      elevation: 10.0,
                      padding: EdgeInsets.all(12),
                      child: Text(
                        "Agregar Producto",
                        style: TextStyle(fontSize: 25),
                        textAlign: TextAlign.center,
                      ),
                      textColor: Colors.white,
                      color: Color.fromRGBO(47, 87, 44, 1.0),
                      onPressed: () {
                        if (validateAndSave()) {
                          databaseProvider.loadProduct(productImage, _name,
                              _price, _unit, _category, context);
                        }
                      }, //uploadStatusImage,
                    ),
            ],
          ),
        ),
      ),
    ));
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
  // void uploadStatusImage() async {
  //   if (validateAndSave()) {
  //     // Subir imagen a firebase storage
  //     final StorageReference postImageRef =
  //         FirebaseStorage.instance.ref().child("Vieja_Confiable");
  //     var timeKey = DateTime.now();

  //     final StorageUploadTask uploadTask =
  //         postImageRef.child(timeKey.toString() + ".jpg").putFile(productImage);

  //     //recupero la url
  //     var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
  //     url = imageUrl.toString();
  //     print("Image url: " + url);

  //     // Guardar el post a firebase database: database realtime
  //     saveToDatabase(url);

  //     //vamos a probar guardar los datos a cloud firestore
  //     // saveToFirestore(url);

  //     //vuelvo a la vista de administracion
  //     Navigator.pop(context);
  //   }
  // }

  // void saveToDatabase(String url) {
  //   // Save to Firebase Database Realtime (image, name, price, unit, category, date, time)
  //   var dbTimeKey = DateTime.now();
  //   var formatDate = DateFormat('MMM d, yyyy');
  //   var formatTime = DateFormat('EEEE, hh:mm aaa');

  //   String date = formatDate.format(dbTimeKey);
  //   String time = formatTime.format(dbTimeKey);

  //   DatabaseReference ref = FirebaseDatabase.instance.reference();

  //   var data = {
  //     "image": url,
  //     "name": _name,
  //     "price": _price,
  //     "unit": _unit,
  //     "category": _category,
  //     "date": date,
  //     "time": time
  //   };
  //   //push to data
  //   ref.child("Vieja_Confiable").push().set(data);
  // }

  // void saveToFirestore(String url) {
  //   // Guardar un post (image, descripcion, date, time)
  //   var dbTimeKey = DateTime.now();
  //   var formatDate = DateFormat('MMM d, yyyy');
  //   var formatTime = DateFormat('EEEE, hh:mm aaa');

  //   String date = formatDate.format(dbTimeKey);
  //   String time = formatTime.format(dbTimeKey);

  //   //reference to cloud firestore
  //   var ref = Firestore.instance.collection('Products').document();

  //   var data = {
  //     "image": url,
  //     "name": _name,
  //     "price": _price,
  //     "unit": _unit,
  //     "category": _category,
  //     "date": date,
  //     "time": time
  //   };

  //   //save to cloudfirestore
  //   ref.setData(data);
  // }
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
