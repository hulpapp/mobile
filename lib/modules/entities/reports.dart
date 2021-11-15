class Report {
  int id;
  String category;
  double quantity;
  String position;
  String destination;
  int eventId;
  String city;

  Report(
      {this.id,
        this.category,
        this.quantity,
        this.position,
        this.destination,
        this.eventId,
        this.city});

  Report.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    quantity = json['quantity'];
    position = json['position'];
    destination = json['destination'];
    eventId = json['event_id'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['quantity'] = this.quantity;
    data['position'] = this.position;
    data['destination'] = this.destination;
    data['event_id'] = this.eventId;
    data['city'] = this.city;
    return data;
  }
}