import 'package:flutter/material.dart';

class Contact extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddressState();
  }

}

class AddressState extends State<Contact> {

  static final addressFormKey = GlobalKey<FormState>();
  static TextEditingController controllerCEP = new TextEditingController();
  static TextEditingController controllerStreet = new TextEditingController();
  static TextEditingController controllerCity = new TextEditingController();
  static TextEditingController controllerNeighborhood = new TextEditingController();
  static TextEditingController controllerState = new TextEditingController();
  static TextEditingController controllerAddress = new TextEditingController();
  static TextEditingController controllerMobileNo = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: addressFormKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  labelText: 'CEP',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Informe o CEP";
                  } return null;
                },
                controller: controllerCEP,
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  labelText: 'Rua',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Informe a Rua";
                  } return null;
                },
                controller: controllerStreet,
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  labelText: 'Bairro',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Informe o Bairro";
                  } return null;
                },
                controller: controllerNeighborhood,
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  labelText: 'Cidade',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Informe a Cidade";
                  } return null;
                },
                controller: controllerCity,
              ),
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  labelText: 'Estado',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "Informe o Estado";
                  } return null;
                },
                controller: controllerState,
              ),
              SizedBox(height: 20),

            ],
          ),
        )
    );
  }

}