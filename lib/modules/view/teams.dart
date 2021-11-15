import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/teams.dart';
import 'package:hulp/modules/presenter/team.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:hulp/modules/entities/event.dart';

class TeamPage extends StatefulWidget {
  const   TeamPage({Key key, this.event}) : super(key: key);
  final Event event;

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  Future<List<Team>> teams;
   TeamPresenter _teamsPresenter = new TeamPresenter();


   @override
   void initState() {
     super.initState();
     teams = getTeamsList();
   }


   Future<List<Team>> getTeamsList() async {
     final response = await _teamsPresenter.listTeams();

     List<Team> teams = [];

     for(final i in response){
       teams.add(Team.fromJson(i));

     }
     return teams;
   }

  @override
  Widget build(BuildContext context) {
    int eventId = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
          title: Text('Equipes')),
      drawer: SideMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(
              context,
              '/teams/new',
              arguments: eventId
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
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
                child: FutureBuilder<List>(
                  future: teams,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) return const Text('Sem Equipes Cadastrados');
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data[index];
                        return Card(
                          child: ListTile(
                            leading: const Icon(Icons.event),
                            trailing: const Icon(Icons.view_list),
                            title: Text(
                              data.name,
                              style: const TextStyle(fontSize: 20),
                            ),
                            onTap: () {
                              Navigator.pushNamed(
                                  context,
                                  '/teams',
                                  arguments: widget.event.id
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                ),
              )

            ),
          ],
        ),
      ),
    );
  }
}

