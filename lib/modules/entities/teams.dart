class Team {
  String name;
  int eventId;
  int responsibleId;

  Team({this.name, this.eventId, this.responsibleId});

  Team.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    eventId = json['event_id'];
    responsibleId = json['responsible_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['event_id'] = this.eventId;
    data['responsible_id'] = this.responsibleId;
    return data;
  }
}