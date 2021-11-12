import 'package:flutter/material.dart';
import 'package:hulp/modules/view/side_menu.dart';
import 'package:hulp/utils/responsivity.dart';

class TeamPage extends StatefulWidget {
  const TeamPage({Key key}) : super(key: key);

  @override
  _TeamPageState createState() => _TeamPageState();
}

class _TeamPageState extends State<TeamPage> {
  get teams => null;

  @override
  Widget build(BuildContext context) {
    int eventId = ModalRoute.of(context).settings.arguments  ;

    return Scaffold(
      appBar: AppBar(
          title: Text('Equipes')),
      drawer: SideMenu(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/teams/new',
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
              child: Scaffold(
                appBar: AppBar(title: Text('Equipes'),backgroundColor: Colors.pinkAccent,),
                body: Center(
                  child: FutureBuilder<List>(
                    future: null,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (!snapshot.hasData) return const Text('Sem Equipes Cadastrados');
                      // Render Events lists
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
                                    '/event/detail',
                                    arguments: data
                                  // MaterialPageRoute(
                                  //   builder: (context) => DetailScreen(todo: todos[index]),
                                  // ),
                                );
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )

            ),
          ],
        ),
      ),
    );
  }
}

