import 'package:flutter/material.dart';
import 'package:hulp/modules/entitys/event.dart';
import 'package:dio/dio.dart';

import '../side_menu.dart';

class ListEvent extends StatefulWidget {
  const ListEvent({Key? key}) : super(key: key);

  @override
  _ListEventState createState() => _ListEventState();
}

class _ListEventState extends State<ListEvent> {
  late Future<List<Event>> events;
  final eventListKey = GlobalKey<_ListEventState>();

  @override
  void initState() {
    super.initState();
    events = getStudentList();
  }

  Future<List<Event>> getStudentList() async {
    var dio = Dio();
    final response = await dio.get('https://jsonplaceholder.typicode.com/todos');

    List<Event> events = [];

    for(final i in response.data){
      events.add(Event.fromJson(i));

    }

    return events;
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: eventListKey,
      appBar: AppBar(
        title: const Text('Lista de Eventos'),
      ),
      drawer: SideMenu(),
      body: Center(
        child: FutureBuilder<List>(
          future: events,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // By default, show a loading spinner.
            if (!snapshot.hasData) return const Text('Sem eventos Cadastrados');
            // Render student lists
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.event),
                    trailing: const Icon(Icons.view_list),
                    title: Text(
                      data.title,
                      style: const TextStyle(fontSize: 20),
                    ),
                    onTap: () {

                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context,
            '/event/new',
          );
        },
      ),
    );
  }
}
