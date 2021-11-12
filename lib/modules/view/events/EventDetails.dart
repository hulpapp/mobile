import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/utils/responsivity.dart';

import '../side_menu.dart';
import '../side_menu_event.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({Key key}) : super(key: key);


  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final ButtonStyle style =
  ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35) );
  final markers =  Set<Marker>();
  Position _currentPosition;

  Future _getCurrentLocation() async {
    await Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });

    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  GoogleMapController mapController;

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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    Event args = ModalRoute.of(context).settings.arguments as Event ;


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
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenuEvent(eventId:args.id),
              ),
            Expanded(
                flex: 5,
                child: Center(
                  child: Column(
                    children: [
                      Card(
                        child: Container(
                          height: 350,
                          child: ListView(
                            padding: EdgeInsets.all(20),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: RichText(
                                  text: TextSpan(
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w600),
                                    children: <TextSpan>[
                                      TextSpan(
                                          text: 'Detalhes do Evento ',
                                          style: TextStyle(color: Colors.brown)),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                  children: <Widget>[
                                    Expanded(
                                        child: Divider()
                                    ),
                                  ]
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                      fontSize: 30,
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Nome: ',
                                        style: TextStyle(color: Colors.brown ,fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: args.name,
                                        style: TextStyle(color: Colors.brown))

                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Descrição: ',
                                        style: TextStyle(color: Colors.brown ,fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: args.detail,
                                        style: TextStyle(color: Colors.brown))

                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Data: ',
                                        style: TextStyle(color: Colors.brown ,fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: args.date,
                                        style: TextStyle(color: Colors.brown))

                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Hora de inicio: ',
                                        style: TextStyle(color: Colors.brown ,fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: args.startDate,
                                        style: TextStyle(color: Colors.brown))

                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: 'Hora do termino: ',
                                        style: TextStyle(color: Colors.brown ,fontWeight: FontWeight.w600)),
                                    TextSpan(
                                        text: args.endDate,
                                        style: TextStyle(color: Colors.brown))

                                  ],
                                ),
                              ),
                              SizedBox(height: 20,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Editar Informações'),
                                    onPressed: () {/* ... */},
                                  ),
                                  const SizedBox(width: 8),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.lightBlue ,
                                    ) ,
                                    child: const Text('Cadastrar locais'),
                                    onPressed: () {Navigator.pushNamed(
                                      context,
                                      '/event/location',
                                    );},
                                  ),
                                  const SizedBox(width: 8),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(child: _currentPosition != null? GoogleMap(
                        onMapCreated: _onMapCreated,
                        mapType: MapType.normal ,
                        initialCameraPosition: CameraPosition(
                          target:  LatLng(_currentPosition.latitude, _currentPosition.longitude),
                          zoom: 15.0,
                        ),
                        markers: markers,
                      ) :Center(child: CircularProgressIndicator(),))
                    ],
                  ),
                ),),
          ],
        ),
      ),



    );
  }
}
