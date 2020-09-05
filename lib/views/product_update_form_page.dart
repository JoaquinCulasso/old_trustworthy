import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:old_trustworthy/models/product.dart';
import 'package:old_trustworthy/providers/database_provider.dart';

class ProductUpdateFormPage extends StatefulWidget {
  final Product product;

  const ProductUpdateFormPage({Key key, this.product}) : super(key: key);
  @override
  _ProductUpdateFormPageState createState() => _ProductUpdateFormPageState();
}

class _ProductUpdateFormPageState extends State<ProductUpdateFormPage> {
  File productImage;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar producto"),
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
              child: widget.product.image == null
                  ? Text("Selecciona una imagen del telefono")
                  : EnableUpload(
                      product: widget.product,
                      productImage: productImage,
                      formKey: formKey,
                    ),
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
}

class EnableUpload extends StatefulWidget {
  final Product product;
  final File productImage;
  final GlobalKey<FormState> formKey;
  EnableUpload({Key key, this.product, this.productImage, this.formKey})
      : super(key: key);

  @override
  _EnableUploadState createState() => _EnableUploadState();
}

class _EnableUploadState extends State<EnableUpload> {
  @override
  Widget build(BuildContext context) {
    String _name;
    String _price;
    String _unit;
    String _category;

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

    return SingleChildScrollView(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: widget.formKey,
          child: Column(
            children: <Widget>[
              widget.productImage == null
                  ? Image.network(
                      widget.product.image,
                      height: 300.0,
                      width: 600.0,
                    )
                  : Image.file(
                      widget.productImage,
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
                value: widget.product.unit,
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
                    _unit = val;
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
                value: widget.product.category,
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
                  return category == null ? "Categoria es requerido" : null;
                },
                onSaved: (category) {
                  return _category = category;
                },
              ),
              SizedBox(height: 15.0),
              RaisedButton(
                  elevation: 10.0,
                  child: Text(
                    "Actualizar Producto",
                    style: TextStyle(fontSize: 25),
                    textAlign: TextAlign.center,
                  ),
                  padding: EdgeInsets.all(12),
                  textColor: Colors.white,
                  color: Color.fromRGBO(47, 87, 44, 1.0),
                  onPressed: () {
                    if (validateAndSave(widget.formKey)) {
                      Provider.of<DatabaseProvider>(context, listen: false)
                          .updateProduct(
                              Product(_name, _price, _category, _unit,
                                  widget.product.image),
                              widget.productImage,
                              context);
                    }
                  }),
            ],
          ),
        ),
      ),
    ));
  }
}

bool validateAndSave(formKey) {
  final form = formKey.currentState;
  if (form.validate()) {
    form.save();
    return true;
  } else {
    return false;
  }
}
