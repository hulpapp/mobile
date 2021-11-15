class Donation {
  int id;
  String category;
  double quantity;
  String destination;
  String position = 'Em coleta';
  int eventId;

  Donation(
      {this.id, this.category, this.quantity, this.destination, this.eventId,this.position});

  Donation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'];
    position = json['position'];
    quantity = json['quantity'];
    destination = json['destination'];
    eventId = json['event_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['category'] = this.category;
    data['position'] = this.position;
    data['quantity'] = this.quantity;
    data['destination'] = this.destination;
    data['event_id'] = this.eventId;
    return data;
  }
}