import 'package:fani/main.dart';
import 'package:flutter/material.dart';
import 'package:fani/profiles/edittech.dart';
import 'dart:convert';
import 'package:http/http.dart' as http2;
import 'package:intl/intl.dart';
import 'dart:ui' as ui;


String techname = "";

class Vieword extends StatefulWidget {
  const Vieword({Key? key}) : super(key: key);

  @override
  _ViewordState createState() => _ViewordState();
}

class Order {
  final String id;
  final String title;
  final String status;
  final String description;
  bool isCompleted;

  Order({
    required this.id,
    required this.title,
    required this.status,
    required this.description,
    required this.isCompleted,
  });
}

class morder {
  final String TypeServ;
  final String Wname;
  final String isrepeated;
  final String uname;
  final String Price;
  final String Hour;
  final List<dynamic> serv;
  final String date;
  final List<dynamic> add;
  int acc;
  String id;
  morder({
    this.TypeServ = "",
    this.Wname = "",
    this.Price = "",
    this.isrepeated = "",
    this.uname = "",
    this.Hour = "",
    this.date = "",
    this.id = "",
    this.acc = 0,
    this.add = const [],
    this.serv = const [],
  });

  factory morder.fromJson(Map<String, dynamic> json) {
    return morder(
      TypeServ: json['TypeServ'],
      Wname: json['Wname'],
      date: json['date'],
      Hour: json['Hour'],
      acc: json['acc'],
      id: json['_id'],
      add: json['add'],
      serv: json['serv'],
      Price: json['Price'],
      uname: json['uname'],
      isrepeated: json['isrepeated'],
    );
  }
  @override
  String toString() {
    return 'morder{Wname: $Wname, Price: $Price,Hour:$Hour,date:$date,reapeated:$isrepeated}';
  }
}

class _ViewordState extends State<Vieword> {
  final List<Order> _orders = [
    Order(
        id: '1',
        title: 'طلب 1',
        status: 'جديد',
        description: 'وصف الطلب 1',
        isCompleted: false),
    Order(
        id: '2',
        title: 'طلب 2',
        status: 'جديد',
        description: 'وصف الطلب 2',
        isCompleted: false),
    Order(
        id: '3',
        title: 'طلب 3',
        status: 'مكتمل',
        description: 'وصف الطلب 3',
        isCompleted: false),
  ];

  List<Order> _completedOrders = [];
  List<morder> naccp = [];
  List<morder> accp = [];
  Future<List<morder>> getworkordu() async {
    print(techname + "this is techname");
    final resp = await http2.get(
      Uri.parse('https://fani-service.onrender.com/ord/6/$tname'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      setState(() {
        naccp = parsed.map((e) => morder.fromJson(e)).toList();
        print(naccp);
      });
    }
    return parsed.map((e) => morder.fromJson(e)).toList();
  }
  var serverToken="AAAAfAZYhAo:APA91bH4KtyI1wyJVnYjT6FU60RLY2Vfu0U0mXlMCa-Hq_2lYuZtL5imkfVrAw8Yb2xWvbf0X5GSUjSd8K2-Wo4W4au8jhl_oqT2d7DTBHXJh5nu8JXbBnJy1A3c1RnD9zh0R_fekvdI";
Future<void> sendNotificationToAll(String title, String body,String name) async {
  final url = Uri.parse('https://fcm.googleapis.com/fcm/send');

  final headers = {
    'Content-Type': 'application/json',
    'Authorization': 'key=$serverToken',
  };

  final notification = {
    'body': body,
    'title': title,
  };

  final message = {
    'notification': notification,
    'priority': 'high',
    'to': '/topics/all',
    'data': <String, dynamic>{
'click_action': 'FLUTTER_NOTIFICATION_CLICK',

"name":name
},
  };

  final response = await http2.post(
    url,
    headers: headers,
    body: jsonEncode(message),
  );

  if (response.statusCode == 200) {
    print('Notification sent successfully');
  } else {
    print('Failed to send notification. Status code: ${response.statusCode}');
  }
}

  Future<void> updateaccw(String id, int acc) async {
    print("hihihi");
    final body = jsonEncode({
      'acc': acc,
    });
    final response = await http2.put(
      Uri.parse('https://fani-service.onrender.com/ord/7/$id'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
    } else {
      print('Failed to update worker bio');
    }
  }

  Future<void> deleteo(String id) async {
    print("hihihid");
    final response = await http2.delete(
      Uri.parse('https://fani-service.onrender.com/ord/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
    } else {
      print('Failed to deleteworker bio');
    }
  }

  Future<List<morder>> getworkordd() async {
    final resp = await http2.get(
      Uri.parse('https://fani-service.onrender.com/ord/5/$tname'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      setState(() {
        accp = parsed.map((e) => morder.fromJson(e)).toList();
        print(accp);
      });
    }
    return parsed.map((e) => morder.fromJson(e)).toList();
  }

  @override
  void initState() {
    techname = tname;
    print(tname + "this is tname");
    getworkordu();
    getworkordd();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.ltr,
      child: Scaffold(
          appBar: AppBar(
            title: Text('الطلبات'),
             centerTitle: true,
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: naccp.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.info_outline),
                            onPressed: () {
                              _showOrderDialog(context, naccp[index]);
                            },
                          ),
                          IconButton(
                            onPressed: ()async {
                              await sendNotificationToAll(
        "قبول الطلب ",
        "تم قبول طلبك من قبل العامل ${naccp[index].Wname}",
        naccp[index].uname,
      );
                              setState(()  {
                                 
                                naccp[index].acc = 1;
                                accp.add(naccp[index]);
                                updateaccw(naccp[index].id, 1);
                                naccp.removeAt(index);
                               
                              });
                            },
                            icon: Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() async {
                                  await sendNotificationToAll(
        "رفض الطلب ",
        "تم رفض طلبك من قبل العامل ${accp[index].Wname}",
        accp[index].uname,
      );
                                naccp[index].acc = -1;

                                naccp.removeAt(index);
                                updateaccw(naccp[index].id, -1);
                               
                              });
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        naccp[index].uname,
                        style: TextStyle(
                          fontFamily: 'cairo',
                        ),
                      ),
                      subtitle: Text(
                        naccp[index].TypeServ + " " + naccp[index].Price,
                        style: TextStyle(
                          fontFamily: 'cairo',
                        ),
                      ),
                    ));
                  },
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: accp.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: ListTile(
                        title: Text(
                          accp[index].uname,
                          style: TextStyle(
                            fontFamily: 'cairo',
                          ),
                        ),
                        subtitle: Text(
                          accp[index].TypeServ + " " + accp[index].Price,
                          style: TextStyle(
                            fontFamily: 'cairo',
                          ),
                        ),
                        leading: Row(mainAxisSize: MainAxisSize.min, children: [
                          IconButton(
                            icon: Icon(Icons.info_outline),
                            onPressed: () {
                              _showOrderDialog(context, accp[index]);
                            },
                          ),
                        ]),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              deleteo(accp[index].id);
                              accp.removeAt(index);
                            });
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )),
    );
  }
}
 void _showOrderDialog(BuildContext context, morder order) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: AlertDialog(
      title: Center(child: Text('تفاصيل الطلب', style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold))),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'نوع الخدمة:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order.TypeServ}',
                style: TextStyle(color: db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'السعر:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order.Price}',
                style: TextStyle(color: db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الوقت:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order.Hour}',
                style: TextStyle(color:db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'الخدمات:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order.serv.toString()}',
                style: TextStyle(color:db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'التاريخ:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${DateFormat('dd/MM/yyyy').format(DateTime.parse(order.date))}',
                style: TextStyle(color: db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'خدمات اضافية:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order.add.toString()}',
                style: TextStyle(color: db),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'التكرار:',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 10),
              Text(
                '${order.isrepeated}',
                style: TextStyle(color: db),
              ),
            ],
          ),
        ],
      ),
      ),
      actions: [
      TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Center(child: Text('اغلاق', style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold))),
      ),
      ],
    ),
    );
  },
    );
  }

  

