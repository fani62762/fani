import 'dart:convert';
import 'package:fani/auth/user.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:http/http.dart' as http2;
import 'package:fani/animation/FadeAnimation.dart';
import 'package:fani/serv/date_time.dart';

String typef = "";
List<String> ordserv = [];
String ordtype = "";

class Gserv extends StatefulWidget {
  const Gserv({super.key});

  @override
  State<Gserv> createState() => _GservState();
}

class serv {
  final String name;
  final String type;
  final String avatar;
  serv({
    this.name = "",
    this.type = "",
    this.avatar = "",
  });

  factory serv.fromJson(Map<String, dynamic> json) {
    return serv(
      name: json['name'],
      type: json['type'],
      avatar: json['avatar'],
    );
  }
  @override
  String toString() {
    return 'service{name: $name, type: $type}';
  }
}

class _GservState extends State<Gserv> {
  GlobalKey<FormState> formkk = GlobalKey<FormState>();
  final TextEditingController cname2 = TextEditingController();
  final TextEditingController cpass2 = TextEditingController();
  List service = [];

  Future<List<serv>> getAllserv() async {
    print("hi function$typef");
    final resp = await http2.get(
      Uri.parse('https://fani-service.onrender.com/serv/2/$typef'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      setState(() {
        service = parsed.map((e) => serv.fromJson(e)).toList();
      });
    }
    return parsed.map((e) => serv.fromJson(e)).toList();
  }

  @override
  void initState() {
    ordserv = [];

    typef = typeofserv;
    ordtype = typeofserv;

    getAllserv();
  }

  List<int> _selectedserv = [];
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Userpage(
                              userName: nee,
                            )),
                  );
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              backgroundColor: dy,
              title: Text(
                'مرحبا, $nee  ',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              automaticallyImplyLeading: false,
            ),
            endDrawer: billenddrawer(context),
            floatingActionButton: _selectedserv.length > 0
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DateAndTime()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${_selectedserv.length}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold)),
                        SizedBox(width: 2),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 18,
                        ),
                      ],
                    ),
                    backgroundColor: Colors.blue,
                  )
                : null,
            body: NestedScrollView(
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverToBoxAdapter(
                      child: FadeAnimation(
                    1,
                    Padding(
                      padding:
                          EdgeInsets.only(top: 50.0, right: 20.0, left: 20.0),
                      child: Text(
                        'تحديد الخدمة التي تريد حجزها ',
                        style: TextStyle(
                          fontSize: 35,
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
                ];
              },
              body: Padding(
                padding: EdgeInsets.all(20.0),
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: service.length,
                    itemBuilder: (BuildContext context, int index) {
                      return FadeAnimation(
                          (1.2 + index) / 4, servicef(service[index], index));
                    }),
              ),
            )));
  }

  servicef(serv v, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_selectedserv.contains(index)) {
            _selectedserv.remove(index);
            ordserv.remove(v.name);
          } else {
            _selectedserv.add(index);
            ordserv.add(v.name);
          }
        });
      },
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          margin: EdgeInsets.only(bottom: 20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        v.avatar,
                        width: 52,
                        height: 52,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        v.name,
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Spacer(),
                  _selectedserv.contains(index)
                      ? Container(
                          padding: EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            color: Colors.greenAccent.shade100.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 20,
                          ))
                      : SizedBox()
                ],
              ),
            ],
          )),
    );
  }
}
