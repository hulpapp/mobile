import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/Volunteer.dart';
import 'package:hulp/modules/entities/presence.dart';
import 'package:hulp/modules/presenter/user.dart';
import 'package:hulp/utils/topSnackBar.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hulp/modules/presenter/team.dart';
import 'package:intl/intl.dart';

class PresencePage extends StatefulWidget {
  const PresencePage({Key key, this.event}) : super(key: key);
  final Event event;

  @override
  _PresencePageState createState() => _PresencePageState();
}

class _PresencePageState extends State<PresencePage> {
  TeamPresenter teamPresenter = new TeamPresenter();
  UserPresenter _userPresenter = new UserPresenter();
  var maskFormatter = new MaskTextInputFormatter(mask: '##:##', filter: { "#": RegExp(r'[0-9]') });
  TextEditingController startController = new TextEditingController();
  TextEditingController endController = new TextEditingController();
  Future<List<Volunteer>>  teamMembers;
  var presences = [];
  var teamName;
  String entrada, saida;
  final String successText = 'Presenca cadastrada com sucesso!!';



  Future<List<Volunteer>>  getEventListByUser() async {

    SharedPreferences prefs =  await SharedPreferences.getInstance();
    print(prefs.getKeys());
    final response = await teamPresenter.listTeamByLeader();
    print('response');
    print(response);
    teamName = response['name'];
    List<Volunteer> vols = [];
    final men =  response['members'];
    for(final i in men)
    {
      vols.add(Volunteer.fromJson(i));

    }

    return vols;
  }

  @override
  void initState() {
    super.initState();
    teamMembers = getEventListByUser();

  }

  savePresence(Volunteer vol) async{
    Presence p = new Presence();
    var data =     DateFormat('dd/MM/yyyy').format(DateTime.now());
    p.date = data;
    p.startDate = entrada;
    p.endDate  = saida;
    p.volunteerId =  vol.id;
    p.eventId = widget.event.id;
    print(p);
    await _userPresenter.createNewPresence(p).then((value) => showSnackBar(successText,context,'success')).catchError((e) {

      showSnackBar(e,context,'error');
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registrar Presenças'),),
      body: ListView(
        padding: EdgeInsets.all(20.0),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 50),
                  children: <TextSpan>[
                    TextSpan(text: 'Equipe '),
                    if(teamName !=null) TextSpan(text:'Nome da equipe:'),TextSpan(text: teamName,style: TextStyle(color: Colors.blueGrey)),
                  ],
                ),
                textScaleFactor: 0.5,
              ),
            ),
          ),
          Container(
            height: 400,
            child: FutureBuilder<List>(
              future: teamMembers,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return ListView.builder(
                  shrinkWrap: false,

                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data[index];
                    return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Icon(Icons.event),
                              SizedBox(width: 20,),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(color: Colors.black, fontSize: 30),
                                  children: <TextSpan>[
                                    TextSpan(text: data.name),
                                  ],
                                ),
                                textScaleFactor: 0.5,
                              ),
                              Spacer(),
                              SizedBox(width: 20,),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  inputFormatters: [maskFormatter],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Entrada',
                                  ),

                                  onChanged: (value){
                                    if(value.length == 5)

                                      setState(() {
                                        entrada = value;
                                      });

                                  },
                                ),
                              ),
                              SizedBox(width: 20,),
                              Container(
                                width: 100,
                                child: TextFormField(
                                  inputFormatters: [maskFormatter],
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Saida',
                                  ),
                                  onChanged: (value){

                                    if(value.length == 5){
                                      setState(() {
                                        saida = value;
                                      });
                                      savePresence(data);
                                    }

                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
