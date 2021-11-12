import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/modules/presenter/Event.dart';

class MainViewPage extends StatefulWidget {
  @override
  _MainViewPageState createState() => _MainViewPageState();
}

class _MainViewPageState extends State<MainViewPage> {
  Future<List<Event>> events;
  EventPresenter eventPresenter = new EventPresenter();
  final eventListKey = GlobalKey<_MainViewPageState>();

  @override
  void initState() {
    super.initState();
    events = getEventsList();
  }

  Future<List<Event>> getEventsList() async {
    final response = await eventPresenter.listEvent();

    List<Event> events = [];

    for(final i in response){
      events.add(Event.fromJson(i));

    }
    print(events);
    return events;
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List>(
          future: events,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) return const Text('Sem eventos Cadastrados');
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
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/event/new',
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),


    );
  }
}
