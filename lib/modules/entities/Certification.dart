


import 'event.dart';

import 'Volunteer.dart';

class Certification {
  Volunteer volunteer;
  Event event;
  String date;
  String startDate;
  String endDate;

  Certification(
      {this.volunteer, this.event, this.date, this.startDate, this.endDate});

  Certification.fromJson(Map<String, dynamic> json) {
    volunteer = json['volunteer'] != null
        ? new Volunteer.fromJson(json['volunteer'])
        : null;
    event = json['event'] != null ? new Event.fromJson(json['event']) : null;
    date = json['date'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.volunteer != null) {
      data['volunteer'] = this.volunteer.toJson();
    }
    if (this.event != null) {
      data['event'] = this.event.toJson();
    }
    data['date'] = this.date;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    return data;
  }

}



