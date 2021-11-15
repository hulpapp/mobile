import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/Bene.dart';
import 'package:hulp/modules/entities/donations.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/modules/presenter/donations.dart';
import 'package:hulp/modules/presenter/user.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/utils/topSnackBar.dart';
import 'package:intl/intl.dart';

import 'BeneficiariesList.dart';




class BeneficiaryPage extends StatefulWidget {
  const BeneficiaryPage({Key key, this.event}) : super(key: key);

  final Event event;



  @override
  _beneficiaryPageState createState() => _beneficiaryPageState();
}

class _beneficiaryPageState extends State<BeneficiaryPage> {
  UserPresenter _userPresenter = new UserPresenter();
  var _beneForm = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _documentController = TextEditingController();
  TextEditingController _eventDayController = TextEditingController();

  Beneficiary _beneficiary = new Beneficiary();
  final String successText = 'Beneficiário cadastrada com sucesso!!';

  Future createNewBeneficiary(Beneficiary beneficiary) async {
    await _userPresenter.createNewBeneficiary(beneficiary).then((value) => showSnackBar(successText,context,'success'))
        .then((value) =>  Navigator.pushReplacement(context,            MaterialPageRoute(
        builder: (context) =>
            BeneficiariesDetail()),


    )).catchError((e) {

      showSnackBar(e,context,'error');
    });



  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Beneficiário')),
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(

                child: SideMenu(),
              ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Center(
                    child: Container(
                      width: card(context),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text("Cadastro de beneficiário",style: TextStyle(fontSize: 32),),
                          ),
                          Form(
                            key: _beneForm,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nome',
                                  ),
                                  validator: (name) {
                                    if (name == null || name.isEmpty) {
                                      return 'Informe o nome do beneficiário';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => _beneficiary.name = newValue,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _documentController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Documento Identificador',
                                  ),
                                  validator: (description) {
                                    if (description == null || description.isEmpty) {
                                      return 'Por favor, o documento do beneficiário.';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => _beneficiary.document = newValue,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _eventDayController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Data de Nascimento",
                                    hintText: "Informe a data de nascimento",
                                  ),
                                  onSaved: (newValue) => _beneficiary.birthDate = newValue,
                                  onTap: () async {
                                    DateTime date = DateTime(1900);
                                    FocusScope.of(context).requestFocus(new FocusNode());

                                    date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100));

                                    _eventDayController.text = DateFormat('dd/MM/yyyy').format(date);
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: MaterialButton(
                                  color: Theme.of(context).colorScheme.secondary,
                                  onPressed: () async{
                                    if (_beneForm.currentState?.validate() ?? false) {
                                      _beneForm.currentState?.save();

                                      await createNewBeneficiary(_beneficiary);
                                    } else {
                                      print(_beneForm.currentState);
                                      print('validation failed');
                                    }
                                  },
                                  child: const Text(
                                    'Cadastrar',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    _beneForm.currentState?.reset();
                                  },
                                  // color: Theme.of(context).colorScheme.secondary,
                                  child: Text(
                                    'Apagar',
                                    style: TextStyle(
                                        color: Theme.of(context).colorScheme.secondary),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
