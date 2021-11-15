class Event {
  int id;
  String name;
  String detail;
  String date;
  String startDate;
  String endDate;
  String city;

  Event({this.id, this.name, this.detail,this.date, this.startDate, this.endDate,this.city});

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    detail = json['detail'];
    date = json['date'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['detail'] = detail;
    data['date'] = date;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['city'] = city;
    return data;
  }
}