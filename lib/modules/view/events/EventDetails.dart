import 'package:flutter/material.dart';
import 'package:hulp/modules/entitys/event.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({Key? key, required this.event}) : super(key: key);
  final Event event;


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
              "Nome : ${widget.event.name}",
              style: TextStyle(fontSize: 20),
            ),
            Padding(
              padding: EdgeInsets.all(10),
            ),
            Text(
              "Detalhes : ${widget.event.detail}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Data de Inicio : ${widget.event.startDate}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Data de final  : ${widget.event.endDate}",
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
