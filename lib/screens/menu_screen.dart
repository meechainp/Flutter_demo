import 'package:flutter/material.dart';
import 'package:flutter_demo/models/menu.dart';
import 'package:flutter_demo/screens/order_screen.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<Menu> menu = [];
  Future<void> getMenu() async {
    try {
      final url = "https://60f94658ee56ef0017975d05.mockapi.io/product";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List jsonResponse = convert
            .jsonDecode(convert.Utf8Decoder().convert(response.bodyBytes));
        setState(() {
          menu = jsonResponse.map((data) => new Menu.fromJson(data)).toList();
        });
      }
    } catch (e) {}
  }

  Future<void> addOrder(
      String name, String imageUrl, int price, int quantity) async {
    try {
      print('add order');
      final url = "https://60f94658ee56ef0017975d05.mockapi.io/order";
      final response = await http.post(Uri.parse(url),
          headers: {'Content-Type': 'application/json; charset=UTF-8'},
          body: convert.json.encode({
            "name": name,
            "image_url": imageUrl,
            "price": price,
            "quantity": quantity,
            "cal_price": price * quantity
          }));
      print(response.statusCode);
      if (response.statusCode == 201) {
        print('Add order success');
      } else {
        print('Add order fail');
      }
    } catch (e) {}
  }

  Future<void> deleteOrder(int id) async {
    try {
      final url = "https://60f94658ee56ef0017975d05.mockapi.io/order/$id";
      final response = await http.post(Uri.parse(url));
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getMenu();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        title: Text(
          'Menu',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OrderScreen()));
              },
              icon: Icon(
                Icons.store,
                size: 20,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 600,
              child: ListView.builder(
                itemCount: menu.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.only(
                        bottom: 18, top: 18, right: 10, left: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0x10000000),
                            blurRadius: 10,
                            spreadRadius: 5,
                            offset: Offset(8.0, 8.0))
                      ],
                    ),
                    child: ExpansionTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(menu[index].imageUrl),
                                  fit: BoxFit.fill),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            children: <Widget>[
                              Text(
                                menu[index].name,
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text('${menu[index].price.toString()} บาท')
                            ],
                          ),
                        ],
                      ),
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(menu[index].detail),
                            ),
                            Container(
                              padding: EdgeInsets.only(bottom: 15, top: 15),
                              width: 160,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () async {
                                        print('Add');
                                        await addOrder(
                                            menu[index].name,
                                            menu[index].imageUrl,
                                            menu[index].price,
                                            1);
                                      },
                                      icon: Icon(Icons.add),
                                    ),
                                    Text('เพิ่มลงตะกร้า'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
