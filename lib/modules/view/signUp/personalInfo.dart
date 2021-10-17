import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class PersonalInfo extends StatefulWidget {
  @override
  PersonalInfoState createState() => PersonalInfoState();
}

class PersonalInfoState extends State<PersonalInfo> {
  static final personalFormKey = GlobalKey<FormState>();
  static TextEditingController controllerName = new TextEditingController();
  static TextEditingController controllerCPF = new TextEditingController();
  static TextEditingController controllerPassport = new TextEditingController();

  static TextEditingController controllerLastName = new TextEditingController();
  static TextEditingController controllerDateOfBirth = new TextEditingController();
  static TextEditingController controllerMobileNo = new TextEditingController();
  TextEditingController _dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Form(
          autovalidateMode: AutovalidateMode.disabled,
          key: personalFormKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                maxLines: 1,
                controller: controllerName,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                  labelText: 'Nome Completo',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "O nome não pode ser vazio.";
                  }
                  return null;
                },
              ), //nome
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                controller: controllerCPF,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.account_box_sharp ,
                    color: Colors.grey,
                  ),
                  labelText: 'CPF',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  CpfInputFormatter(),
                ],
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "O CPF é obrigatorio.";
                  }
                  return null;
                },
              ), //nome
              SizedBox(height: 20),
              TextFormField(
                maxLines: 1,
                controller: controllerPassport,
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.account_box_sharp ,
                    color: Colors.grey,
                  ),
                  labelText: 'Passaporte',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                validator: (value) {
                  if (value!.trim().isEmpty) {
                    return "O nome não pode ser vazio.";
                  }
                  return null;
                },
              ), //nome
              SizedBox(height: 20),

              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _dateController,
                    decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.calendar_today,
                          color: Colors.grey,
                        ),
                        labelText: 'Data de Nascimento',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        )
                    ),
                    validator: (value) {
                      if (value!.isEmpty)
                        return "Por favor Informe a data de nascimento";
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
            maxLines: 1,
            decoration: InputDecoration(
              prefixIcon: const Icon(
                Icons.phone,
                color: Colors.grey,
              ),
              labelText: 'Telefone',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
            ),
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              TelefoneInputFormatter()
            ],
            validator: (value)  {
              if (value!.trim().isEmpty) {
                return "Por favor informe seu telefone";
              } return null;
            },
            controller: controllerMobileNo,
          ),
            ],
          ),
        ));
  }
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940),
        lastDate: DateTime(2100));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        var date =
            "${picked.toLocal().day}/${picked.toLocal().month}/${picked.toLocal().year}";
        _dateController.text = date;
      });
  }

}