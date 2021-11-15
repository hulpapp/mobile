import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/signUp.dart';

class Upload extends StatefulWidget {

  SignUp mapInfo = SignUp();

  Upload(this.mapInfo);

  @override
  State<StatefulWidget> createState() {
    return UploadState();
  }
}

class UploadState extends State<Upload> {

  @override
  Widget build(BuildContext context) {

    var name = widget.mapInfo.name;
    var cpf = widget.mapInfo.cpf;
    var rg = widget.mapInfo.identity;
    var email = widget.mapInfo.email;
    var address = widget.mapInfo.street + ", " +
        widget.mapInfo.city + ", " +
        widget.mapInfo.state +  ", " +
        widget.mapInfo.cep;
    var phone = widget.mapInfo.telephone;


    return  Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("Nome: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(name, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text("CPF: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(cpf, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text("RG: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(rg, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text("Email: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(email, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text("Endereço: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(address, style: TextStyle(fontSize: 16)),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: <Widget>[
              Text("Telefone: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(phone, style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}