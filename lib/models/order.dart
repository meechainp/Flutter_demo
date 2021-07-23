class Order {
  String id;
  String name;
  int quantity;
  String imageUrl;
  int price;
  int calPrice;

  Order(
      {this.id,
      this.name,
      this.quantity,
      this.imageUrl,
      this.price,
      this.calPrice});

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    quantity = json['quantity'];
    imageUrl = json['image_url'];
    price = json['price'];
    calPrice = json['cal_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price;
    data['cal_price'] = this.calPrice;
    return data;
  }
}