import 'package:flutter/material.dart';
import 'package:hulp/modules/entities/event.dart';

class EditEventPage extends StatefulWidget {
  const EditEventPage({Key? key, required this.event}) : super(key: key);

  final Event event;



  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {

  final formKey = GlobalKey<FormState>();


  late TextEditingController nameController;
  late TextEditingController detailController;
  late TextEditingController startController;
  late TextEditingController endController;



  @override
  void initState() {
    nameController = TextEditingController(text: widget.event.name);
    detailController = TextEditingController(text: widget.event.detail);
    startController = TextEditingController(text: widget.event.startDate);
    endController = TextEditingController(text: widget.event.endDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      bottomNavigationBar: BottomAppBar(
        child: RaisedButton(
          child: Text('CONFIRM'),
          color: Colors.blue,
          textColor: Colors.white,
          onPressed: () {

          },
        ),
      ),
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Container()
          ),
        ),
      ),
    );
  }
}
