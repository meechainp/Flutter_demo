import 'package:flutter/material.dart';
import 'package:flutter_demo/models/order.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  List<Order> order = [];
  Future<void> getOrder() async {
    try {
      final url = "https://60f94658ee56ef0017975d05.mockapi.io/order";
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List jsonResponse = convert
            .jsonDecode(convert.Utf8Decoder().convert(response.bodyBytes));
        setState(() {
          order = jsonResponse.map((data) => new Order.fromJson(data)).toList();
        });
      }
    } catch (e) {}
  }

  @override
  void initState() {
    super.initState();
    getOrder();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'My Order',
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 600,
              child: ListView.builder(
                itemCount: order.length,
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
                    child: Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(order[index].imageUrl),
                                fit: BoxFit.fill),
                          ),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          order[index].name,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              '${order[index].quantity} รายการ',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text('${order[index].calPrice.toString()} บาท')
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
