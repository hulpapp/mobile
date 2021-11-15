import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/donations.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/modules/presenter/donations.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/utils/topSnackBar.dart';





class DonationPage extends StatefulWidget {
  const DonationPage({Key key, this.event}) : super(key: key);

  final Event event;



  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  DonationPresenter _donationPresenter = new DonationPresenter();
  var _eventForm = GlobalKey<FormState>();
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _quantityController = TextEditingController();
  TextEditingController _destinationController = TextEditingController();

  Donation _donation = new Donation();
  final String successText = 'Doação cadastrada com sucesso!!';

  Future createNewDonation(Donation donation) async {
    await _donationPresenter.createEvent(donation).then((value) => showSnackBar(successText,context,'success'))
        .then((value) =>   _eventForm.currentState.reset()).catchError((e) {

      showSnackBar(e,context,'error');
    });



  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Doações')),
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
                            child: Text("Cadastro de doações",style: TextStyle(fontSize: 32),),
                          ),
                          Form(
                            key: _eventForm,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _categoryController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Item',
                                  ),
                                  validator: (name) {
                                    if (name == null || name.isEmpty) {
                                      return 'Informe qual item para a doação';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => _donation.category = newValue,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _quantityController,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Quantidade',
                                  ),
                                  validator: (description) {
                                    if (description == null || description.isEmpty) {
                                      return 'Por favor, informe a quantidade do item.';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => _donation.quantity = double.parse(newValue),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _destinationController,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Local de Destino",
                                    hintText: "Local para onde a doação será encaminhada.",
                                  ),
                                  validator: (city) {
                                    if (city == null || city.isEmpty) {
                                      return 'Por favor, informe o local de destino da doação';
                                    }
                                    return null;
                                  },
                                  onSaved: (newValue) => _donation.destination = newValue,
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
                                      _donation.eventId = widget.event.id;
                                      _donation.position = 'Em coleta';
                                      await createNewDonation(_donation);
                                    } else {
                                      print(_eventForm.currentState);
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
                                    _eventForm.currentState?.reset();
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
