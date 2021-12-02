import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/modules/entities/location.dart';
import 'package:hulp/modules/interactor/eventePlace.dart';
import 'package:hulp/modules/view/AddEventPlace.dart';
import 'package:hulp/modules/view/events/EventEdit.dart';
import 'package:hulp/modules/view/teams.dart';
import 'package:hulp/utils/responsivity.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Certificado.dart';
import '../PresencePage.dart';
import '../donations.dart';
import '../side_menu_event.dart';

class EventDetail extends StatefulWidget {
  const EventDetail({Key key, this.event}) : super(key: key);
  final Event event;


  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  final ButtonStyle style =
  ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 20), minimumSize: Size(115, 35));
  final markers = Set<Marker>();
  Position _currentPosition;
  EventPlaceInteractor _eventPlaceInteractor = new EventPlaceInteractor();
  List<EventPlace> places = [];
  GoogleMapController mapController;
  int userId;

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
    getPlaces(widget.event.id);
    getUSer();
  }

  getUSer() async {
    SharedPreferences prefs =  await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.get("user");
    });

  }

  getPlaces(id) async {
    final response = await _eventPlaceInteractor.list(id);

        if (response !=null) {
          for (final i in response) {
            var eventPlaces = EventPlace.fromJson(i);

             setState(() {
               places.add(eventPlaces);
               markers.add(
                   Marker(markerId: MarkerId(eventPlaces.placeId),
                       position: LatLng(eventPlaces.latitude, eventPlaces.longitude),
                       infoWindow: InfoWindow(title: eventPlaces.name))
               );
             });
          }
        }


  }



  void confirmDelete(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(' Confirma excluir o evento?'),
          actions: <Widget>[
            ElevatedButton(
              child: Icon(Icons.cancel),
              style: style,
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
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
    return Scaffold(
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenuEvent(eventId: widget.event.id),
              ),
            Expanded(
              flex: 5,
              child: Center(
                child: Column(
                  children: [
                    Card(
                      child: Container(
                        height: 400,
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
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: widget.event.name,
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
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: widget.event.detail,
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
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: widget.event.date,
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
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: widget.event.startDate,
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
                                      style: TextStyle(color: Colors.brown,
                                          fontWeight: FontWeight.w600)),
                                  TextSpan(
                                      text: widget.event.endDate,
                                      style: TextStyle(color: Colors.brown))

                                ],
                              ),
                            ),
                            SizedBox(height: 20,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  child: const Text('Certificado'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CertificationPage(
                                                event: widget.event,
                                              )),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                child: const Text('Presença'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PresencePage(
                                              event: widget.event,
                                            )),
                                  );
                                },
                              ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  child: const Text('Cadastrar Doações'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.orangeAccent,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DonationPage(
                                                event: widget.event,
                                              )),
                                    );
                                  },
                                ),
                                const SizedBox(width: 8),




                              ],
                            ),
                            if(userId == widget.event.userId )Row(children: [
                              ElevatedButton(
                                child: const Text('Adicionar Equipes'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent,
                                ),
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context,
                                      '/teams/new',
                                      arguments: widget.event.id
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                child: const Text('Motorista'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.cyan,
                                ),
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                    context,
                                    '/motorista',
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                child: const Text('Adicionar Equipes'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent,
                                ),
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context,
                                      '/teams/new',
                                      arguments: widget.event.id
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                child: const Text('Editar Informações'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditEventPage(
                                              event: widget.event,
                                            )),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                child: const Text('Equipes'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orangeAccent,
                                ),
                                onPressed: () {
                                  Navigator.popAndPushNamed(
                                      context,
                                      '/teams',
                                      arguments: widget.event.id
                                  );
                                },
                              ),

                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.lightBlue,
                                ),
                                child: const Text('Cadastrar locais'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LocationSelectPage(
                                              event: widget.event,
                                              markers:  markers,
                                              eventPlaces: places,
                                            )),
                                  );
                                },
                              ),
                              const SizedBox(width: 8),
                            ],)
                          ],
                        ),
                      ),
                    ),
                    Expanded(child: _currentPosition != null ? GoogleMap(
                      onMapCreated: _onMapCreated,
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_currentPosition.latitude,
                            _currentPosition.longitude),
                        zoom: 15.0,
                      ),
                      markers: markers,
                    ) : Center(child: CircularProgressIndicator(),))
                  ],
                ),
              ),),
          ],
        ),
      ),


    );
  }

}
