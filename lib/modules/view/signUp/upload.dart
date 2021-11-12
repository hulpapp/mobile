import 'dart:collection';
import 'package:flutter/material.dart';

class Upload extends StatefulWidget {

  var mapInfo = HashMap<String,String>();

  Upload(this.mapInfo);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UploadState();
  }
}

class UploadState extends State<Upload> {
  @override
  Widget build(BuildContext context) {

    var name = widget.mapInfo["nome"];
    var cpf = widget.mapInfo["cpf"];
    var rg = widget.mapInfo["rg"];
    var email = widget.mapInfo["email"];
    var address = widget.mapInfo["street"] + ", " +
        widget.mapInfo["city"] + ", " +
        widget.mapInfo["state"] +  ", " +
        widget.mapInfo["cep"];
    var phone = widget.mapInfo["phone"];


    // TODO: implement build
    return Container(
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
              Text("Mobile No: ", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text(phone, style: TextStyle(fontSize: 16)),
            ],
          ),
        ],
      ),
    );
  }
}