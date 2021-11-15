class EventPlace {
  int eventId;
  String placeId;
  String name;
  String address;
  double latitude;
  double longitude;

  EventPlace({this.eventId, this.placeId, this.name, this.address, this.latitude, this.longitude});

  EventPlace.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    placeId = json['placeid'];
    name = json['name'];
    address = json['address'];
    latitude = json['lat'];
    longitude = json['long'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['placeid'] = this.placeId;
    data['name'] = this.name;
    data['address'] = this.address;
    data['lat'] = this.latitude;
    data['long'] = this.longitude;
    return data;
  }
}