class Menu {
  String name;
  String detail;
  String imageUrl;
  int price;
  String id;

  Menu({this.name, this.detail, this.imageUrl, this.price, this.id});

  Menu.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    detail = json['detail'];
    imageUrl = json['image_url'];
    price = json['price'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['detail'] = this.detail;
    data['image_url'] = this.imageUrl;
    data['price'] = this.price;
    data['id'] = this.id;
    return data;
  }
}