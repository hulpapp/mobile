import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/utils/topSnackBar.dart';
import 'package:intl/intl.dart';
import 'package:hulp/modules/presenter/Event.dart';

import '../side_menu.dart';




class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  EventPresenter eventPresenter = new EventPresenter();
  var _eventForm = GlobalKey<FormState>();
  TextEditingController _namelController = TextEditingController();
  TextEditingController _descriptionlController = TextEditingController();
  TextEditingController _eventDayController = TextEditingController();
  TextEditingController _eventStartHourController = TextEditingController();
  TextEditingController _eventEndHourController = TextEditingController();
  Event _event = new Event();
  final String successText = 'Evento criado com sucesso!!';

  Future createNewEvent(Event event) async {
    await eventPresenter.createEvent(event).then((value) => showSnackBar(successText,context,'success'))
        .then((value) =>    Navigator.pushNamed(
      context,
      '/home/',
    )).catchError((e) {

      showSnackBar(e,context,'error');
    });



  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Evento')),
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
                            child: Text("Cadastro de novo evento",style: TextStyle(fontSize: 32),),
                          ),
                          Form(
                            key: _eventForm,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _namelController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Nome',
                                  ),
                                  validator: (name) {
                                    if (name == null || name.isEmpty) {
                                      return 'Por favor, digite um nome para o evento';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => _event.name = newValue,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _descriptionlController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Descrição',
                                  ),
                                  validator: (description) {
                                    if (description == null || description.isEmpty) {
                                      return 'Por favor, informe a descrição do evento.';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => _event.detail = newValue,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _eventDayController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Data do Evento",
                                    hintText: "Dia em que o Evento Ocorrerá",
                                  ),
                                  onSaved: (newValue) => _event.date = newValue,
                                  onTap: () async {
                                    DateTime? date = DateTime(1900);
                                    FocusScope.of(context).requestFocus(new FocusNode());

                                    date = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100));

                                    _eventDayController.text = DateFormat('dd/MM/yyyy').format(date!);
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _eventStartHourController, // add this line.
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Hora de inicio do evento',
                                  ),
                                  onSaved: (newValue) => _event.startDate = newValue,
                                  onTap: () async {
                                    TimeOfDay time = TimeOfDay.now();
                                    FocusScope.of(context).requestFocus(new FocusNode());

                                    TimeOfDay? picked = await showTimePicker(
                                        context: context, initialTime: time);
                                    if (picked != null && picked != time) {
                                      _eventStartHourController.text =
                                          picked.format(context);
                                      setState(() {
                                        time = picked;
                                      });
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _eventEndHourController, // add this line.
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Hora de inicio do evento',
                                  ),
                                  onSaved: (newValue) => _event.endDate = newValue,
                                  onTap: () async {
                                    TimeOfDay time = TimeOfDay.now();
                                    FocusScope.of(context).requestFocus(new FocusNode());

                                    TimeOfDay? picked = await showTimePicker(
                                        context: context, initialTime: time);
                                    if (picked != null && picked != time) {
                                      _eventEndHourController.text = picked.format(context);
                                      setState(() {
                                        time = picked;
                                      });
                                    }
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
                                    if (_eventForm.currentState?.validate() ?? false) {
                                      _eventForm.currentState?.save();
                                      await createNewEvent(_event);
                                    } else {
                                      print(_eventForm.currentState);
                                      print('validation failed');
                                    }
                                  },
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    _eventForm.currentState?.reset();
                                  },
                                  // color: Theme.of(context).colorScheme.secondary,
                                  child: Text(
                                    'Reset',
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
