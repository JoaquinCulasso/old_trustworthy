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
                  : enableUpload(context),
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

  Widget enableUpload(BuildContext context) {
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
      '750gr',
      '500gr',
      '250gr',
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
              RaisedButton(
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
                    Provider.of<DatabaseProvider>(context, listen: false)
                        .loadProduct(productImage, _name, _price, _unit,
                            _category, context);
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
}
