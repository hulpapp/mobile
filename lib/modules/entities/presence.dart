class Presence {
  String date;
  String startDate;
  String endDate;
  int volunteerId;
  int eventId;

  Presence({this.date, this.startDate, this.endDate, this.volunteerId,this.eventId});

  Presence.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    volunteerId = json['volunteer_id'];
    eventId = json['event_id'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['volunteer_id'] = this.volunteerId;
    data['event_id'] = this.eventId;
    return data;
  }
}