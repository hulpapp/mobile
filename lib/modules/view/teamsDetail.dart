import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/Volunteer.dart';
import 'package:hulp/modules/presenter/user.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';

class TeamsDetail extends StatefulWidget {
  const TeamsDetail({Key key}) : super(key: key);

  @override
  _TeamsDetailState createState() => _TeamsDetailState();
}

class _TeamsDetailState extends State<TeamsDetail> {
  var dropdownValue = new Volunteer(name:'selecionar responsavel');
  List<bool> isChecked;
  List listV = [new Volunteer(name:'selecionar responsavel')];
  UserPresenter user = new UserPresenter();
  Future<List<Volunteer>> volunteers;

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
    int eventId = ModalRoute.of(context).settings.arguments  ;
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
                child: Scaffold(
                  appBar: AppBar(
                    title: Text('Equipes'),
                    backgroundColor: Colors.pinkAccent,
                  ),
                  body: Center(
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
                                    var vol = listV.where((element) => element.name == newValue).toList();
                                    dropdownValue = vol.removeLast();
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
                                  onPressed: () {/* ... */},
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
                )),
          ],
        ),
      ),
    );
  }
}
