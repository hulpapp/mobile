class Event {
  String? name;
  String? detail;
  String? startDate;
  String? endDate;

  Event({this.name, this.detail, this.startDate, this.endDate});

  Event.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    detail = json['detail'];
    startDate = json['startDate'];
    endDate = json['endDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['detail'] = detail;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    return data;
  }
}