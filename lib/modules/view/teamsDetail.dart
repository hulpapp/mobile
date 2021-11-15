import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/Volunteer.dart';
import 'package:hulp/modules/entities/teams.dart';
import 'package:hulp/modules/presenter/team.dart';
import 'package:hulp/modules/presenter/user.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:collection/collection.dart';
import 'package:hulp/utils/topSnackBar.dart';

class TeamsDetail extends StatefulWidget {
  const TeamsDetail({Key key, this.event}) : super(key: key);
  final Event event;

  @override
  _TeamsDetailState createState() => _TeamsDetailState();
}

class _TeamsDetailState extends State<TeamsDetail> {
  var dropdownValue = new Volunteer(name:'selecionar responsavel');
  Volunteer _volunteer = new Volunteer();
  Team team = new Team();
  TeamPresenter _teamPresenter = TeamPresenter();
  List<bool> isChecked;
  List listV = [new Volunteer(name:'selecionar responsavel')];
  UserPresenter user = new UserPresenter();
  Future<List<Volunteer>> volunteers;
  final String successText = 'Time criado com sucesso!!';
  TextEditingController nController;

  @override
  void initState() {
    super.initState();
    volunteers = user.listVolunteer();
    volunteers.then((value) => {isChecked = List.generate(value.length, (index) => false),
      itemsDropDown(value)});

  }

  void itemsDropDown(items){
    setState(() {
      listV.addAll(items);
    });

  }


  @override
  Widget build(BuildContext context) {
    int eventId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text('Equipes')),
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
                child: Center(
                  child: Card(
                    child: Container(
                      width: card(context),
                      height: 700,
                      child: ListView(
                        padding: EdgeInsets.all(20),
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 36,
                                    fontWeight: FontWeight.w600),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: 'Cadastrar Equipe ',
                                      style: TextStyle(color: Colors.brown)),
                                ],
                              ),
                            ),
                          ),

                          TextField(
                            controller: nController,
                            onChanged: (value) {
                              team.name = value;
                            },
                            decoration: InputDecoration(
                                label: Text('Nome :'),
                                border: OutlineInputBorder(),
                                hintText: 'nome Equipe'),
                          ),
                          SizedBox(height: 20,),
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
                                    print('newValue');
                                    print(newValue);
                                    
                                    var index = listV.indexWhere((element) => element.name == newValue);
                                    dropdownValue = listV[index];
                                    _volunteer = listV[index];
                                    if(index != 0) isChecked[index -1] = !isChecked[index -1];

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
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Selecionar Membros para  equipe',
                                    style: TextStyle(color: Colors.brown)),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 300,
                            child: FutureBuilder<List>(
                              future: volunteers,
                              builder: (BuildContext context, AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) return Center(child: const Text('Sem eventos Cadastrados'));

                                // Render Events lists
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index) {

                                    var data = snapshot.data[index];
                                    return Card(
                                      child: CheckboxListTile(
                                        title: Text(data.name),
                                        value: isChecked[index],
                                        onChanged: (bool checked) {
                                          setState(
                                                () {
                                              isChecked[index] = checked;
                                            },
                                          );
                                        },
                                        secondary: const Icon(Icons.face),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              ElevatedButton(
                                child: const Text('Salvar'),
                                onPressed: () {
                                  

                                  team.eventId = eventId;
                                  team.responsibleId = _volunteer.id;

                                  final List<Volunteer>teamMembers = [];

                                  isChecked.forEachIndexed((index, element) {
                                    if(element) teamMembers.add(listV[index+1]);
                                  });
                                  _teamPresenter.createTeam(team,teamMembers).then((value) => showSnackBar(successText,context,'success'))
                                      .then((value) =>   Navigator.popAndPushNamed(context,'/home')).catchError((e) {

                                    showSnackBar(e,context,'error');
                                  });



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
                )),
          ],
        ),
      ),
    );
  }
}
