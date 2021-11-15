import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:hulp/modules/entities/location.dart';
import 'package:hulp/modules/interactor/eventePlace.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hulp/modules/entities/event.dart';
import 'package:hulp/utils/topSnackBar.dart';

class LocationSelectPage extends StatefulWidget {
  const LocationSelectPage(
      {Key key, this.event, this.markers, this.eventPlaces})
      : super(key: key);
  final Event event;
  final markers;
  final eventPlaces;

  @override
  _LocationSelectPageState createState() => _LocationSelectPageState();
}

class _LocationSelectPageState extends State<LocationSelectPage> {
  TextEditingController controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  GoogleMapController mapController;
  Position _currentPosition;
  List<EventPlace> _eventPlace = [];
  var markers = Set<Marker>();
  EventPlaceInteractor eventPlaceInteractor = new EventPlaceInteractor();
  final String successText = 'Locais Adicionados ao evento com sucesso!!';

  void _addPlace(Prediction p, String name) {
    Event args = widget.event;

    setState(() {
      markers.add(Marker(
          markerId: MarkerId(p.placeId),
          position: LatLng(double.parse(p.lat), double.parse(p.lng)),
          infoWindow: InfoWindow(title: name)));
    });

    _eventPlace.add(EventPlace(
        eventId: args.id,
        name: name,
        address: p.description,
        placeId: p.placeId,
        latitude: double.parse(p.lat),
        longitude: double.parse(p.lng)));
    _listKey.currentState.insertItem(0, duration: Duration(seconds: 1));
  }

  Future createNewLocations(List<EventPlace> places) async {
    await eventPlaceInteractor
        .create(places)
        .then((value) => showSnackBar(successText, context, 'success'))
        .then((value) => Navigator.popAndPushNamed(context,'/event/detail',arguments: widget.event.id))
        .catchError((e) {
      showSnackBar(e, context, 'error');
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _eventPlace = widget.eventPlaces;
    markers = widget.markers;


    }



  Future _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        for (final i in _eventPlace) {
          _listKey.currentState.insertItem(0, duration: Duration(seconds: 1));
        }
      });
    }).catchError((e) {
      print(e);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Locais'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              children: [
                placesAutoCompleteTextField(),
                Expanded(
                  child: _currentPosition != null
                      ? gMaps()
                      : Center(child: CircularProgressIndicator()),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 36),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Locais Cadastrados ',
                            style: TextStyle(color: Colors.blue)),
                      ],
                    ),
                    textScaleFactor: 0.5,
                  ),
                ),
                Expanded(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: 0,
                    padding: EdgeInsets.all(10),
                    itemBuilder: (_, index, animation) {
                      return SizeTransition(
                        key: UniqueKey(),
                        sizeFactor: animation,
                        child: Card(
                          margin: EdgeInsets.all(10),
                          elevation: 10,
                          color: Colors.orange,
                          child: ListTile(
                            contentPadding: EdgeInsets.all(15),
                            title: Text(_eventPlace[index].name,
                                style: TextStyle(fontSize: 24)),
                            subtitle: Text(_eventPlace[index].address),
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () => _removeItem(index),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                  child: ElevatedButton(
                      onPressed: () {
                        createNewLocations(_eventPlace);
                      },
                      child: Text('Salvar locais')),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
          textEditingController: controller,
          googleAPIKey: "",
          inputDecoration:
              InputDecoration(hintText: "Informe o local do evento"),
          debounceTime: 800,
          countries: ["br"],
          isLatLngRequired: true,
          getPlaceDetailWithLatLng: (Prediction prediction) {
            print("placeDetails" + prediction.lng.toString());
            saveDialog(prediction);
          },
          itmClick: (Prediction prediction) {
            controller.text = prediction.description;
            print("longetude" + prediction.lng.toString());
            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: prediction.description.length));
          }
          // default 600 ms ,
          ),
    );
  }

  gMaps() {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      mapType: MapType.normal,
      initialCameraPosition: CameraPosition(
        target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        zoom: 15.0,
      ),
      markers: markers,
    );
  }

  void _removeItem(int index) {
    _listKey.currentState.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: Card(
          margin: EdgeInsets.all(10),
          elevation: 10,
          color: Colors.purple,
          child: ListTile(
            contentPadding: EdgeInsets.all(15),
            title: Text("Removido", style: TextStyle(fontSize: 24)),
          ),
        ),
      );
    }, duration: Duration(seconds: 1));

    _eventPlace.removeAt(index);
    setState(() {
      markers.remove(markers.elementAt(index));
    });
  }

  saveDialog(Prediction p) {
    Alert(
        context: context,
        title: "Adicionar Local",
        content: Column(
          children: <Widget>[
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => {
              _addPlace(p, nameController.text),
              nameController.clear(),
              controller.clear(),
              Navigator.pop(context)
            },
            child: Text(
              "Salvar",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }
}
