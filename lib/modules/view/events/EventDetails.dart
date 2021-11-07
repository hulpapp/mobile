import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/event.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({Key? key}) : super(key: key);


  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35) );

  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Confirma excluir o evento?'),
          actions: <Widget>[
            ElevatedButton (
              child: Icon(Icons.cancel),
             style: style,
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton (
              child: Icon(Icons.check_circle),
              style: style,
              onPressed: () => {},
            ),
          ],
        );
      },
    );
  }




  @override
  Widget build(BuildContext context) {
    Event args = ModalRoute.of(context)!.settings.arguments as Event ;


    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => confirmDelete(context),
          ),
        ],
      ),
      body: Container(
        height: 270.0,
        padding: const EdgeInsets.all(35),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Nome : ${args.name}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Detalhes : ${args.detail}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Data de Inicio : ${args.startDate}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Data de final  : ${args.endDate}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.edit),
        onPressed: () => {}
      ),
    );
  }
}
