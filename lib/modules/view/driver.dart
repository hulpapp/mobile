import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/Volunteer.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/modules/presenter/user.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/utils/topSnackBar.dart';
import 'package:hulp/modules/presenter/Event.dart';





class DrivePage extends StatefulWidget {
  @override
  _DrivePageState createState() => _DrivePageState();
}


class _DrivePageState extends State<DrivePage> {
  EventPresenter eventPresenter = new EventPresenter();
  var dropdownValue = new Volunteer(name:'selecionar motorista');
  List listV = [new Volunteer(name:'selecionar motorista')];
  final String successText = 'Motorista cadastrado com sucesso!!';
  Volunteer _volunteer = new Volunteer();
  TextEditingController _carController;
  UserPresenter user = new UserPresenter();

  Future createNewEvent(Event event) async {
    await eventPresenter.createEvent(event).then((value) => showSnackBar(successText,context,'success'))
        .then((value) =>   Navigator.pop(context)).catchError((e) {

      showSnackBar(e,context,'error');
    });



  }

  void itemsDropDown(items){
    setState(() {
      listV.addAll(items);
    });


  }
  @override
  void initState() {
    super.initState();
    user.listVolunteer().then((value) => {itemsDropDown(value)});

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Motorista')),
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
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15 ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              border: Border.all(
                                  color: Colors.blue, style: BorderStyle.solid, width: 1),
                            ),

                            child: DropdownButton<String>(
                                elevation: 16,
                                value: dropdownValue.name,

                                style: const TextStyle(color: Colors.deepPurple),
                                onChanged: (newValue) {
                                  setState(() {

                                    var index = listV.indexWhere((element) => element.name == newValue);
                                    dropdownValue = listV[index];
                                    _volunteer = listV[index];

                                  });
                                },underline:Container(),
                                items: listV.map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value.name,
                                    child: Text(value.name),
                                  );
                                }).toList()

                            ),
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            controller: _carController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Veiculo',
                              hintText: 'Informe o veiculo'
                            ),
                            validator: (name) {
                              if (name == null || name.isEmpty) {
                                return 'Por favor, digite um nome para o evento';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                child: const Text('Salvar'),
                                onPressed: () {

                                },
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red ,
                                ) ,
                                child: const Text('Cancelar'),
                                onPressed: () {/* ... */},
                              ),
                              const SizedBox(width: 8),
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
