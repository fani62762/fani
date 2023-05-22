import 'package:fani/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:fani/serv/globalserv.dart';
import 'package:fani/serv/date_time.dart';
import 'package:fani/serv/viewall.dart';
import 'package:fani/auth/user.dart';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http2;

List<String> wHour = selectedHour;
String typef = typeofserv;
String hourtosend = '';
List<workserv> workers = [];
List<workserv> topm = [];
List<workserv> top1 = [];
List<workserv> top2 = [];
List<workserv> top3 = [];
List<workserv> topb = [];
List<workserv> topt = [];
List<workserv> topp = [];
List<workserv> topd = [];
List<workserv> temp = [];
String ordwname = "";
String ordprice = "";
String desc1 = "";
String desc2 = "";
String desc3 = "";

class tech extends StatefulWidget {
  const tech({Key? key}) : super(key: key);

  @override
  _techState createState() => _techState();
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
  morder({
    this.TypeServ = "",
    this.Wname = "",
    this.Price = "",
    this.isrepeated = "",
    this.uname = "",
    this.Hour = "",
    this.date = "",
    this.add = const [],
    this.serv = const [],
  });

  factory morder.fromJson(Map<String, dynamic> json) {
    return morder(
      Wname: json['Wname'],
      date: json['date'],
      Hour: json['Hours'],
      isrepeated: json['isrepeated'],
    );
  }
  @override
  String toString() {
    return 'morder{Wname: $Wname, Price: $Price,Hour:$Hour,date:$date,reapeated:$isrepeated}';
  }
}

class workserv {
  final String Wname;
  final String Price;
  String msh;
  final List<dynamic> Hour;
  List<dynamic> mHour;
  List<dynamic> worder;
  final int rating;
  final int timing;
  final int master;
  final int behave;
  int points;

  workserv({
    this.Wname = "",
    this.Price = "",
    this.msh = "",
    this.Hour = const [],
    this.mHour = const [],
    this.worder = const [],
    this.rating = 0,
    this.timing = 0,
    this.behave = 0,
    this.master = 0,
    this.points = 0,
  });

  factory workserv.fromJson(Map<String, dynamic> json) {
    return workserv(
      Wname: json['Wname'],
      Price: json['Price'],
      Hour: json['Hours'],
      worder: json['Worders'],
      rating: json['rating'],
      timing: json['timing'],
      master: json['master'],
      behave: json['behave'],
    );
  }
  @override
  String toString() {
    return 'workserv{Wname: $Wname, Price: $Price,Hour:$Hour,mHour:$mHour,rating:$rating,worder:$worder}';
  }
}

class _techState extends State<tech> {
  bool isDes1 = false;
  List<workserv> otherworkers = [];
  Future<List<workserv>> getw() async {
    print("hi function$typef");
    final resp = await http2.get(
      Uri.parse(
          'https://fani-service.onrender.com/servwork/4/$typef/$hourtosend'),
      headers: {'Content-Type': 'application/json'},
    );

    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      setState(() {
        workers = parsed.map((e) => workserv.fromJson(e)).toList();

        for (workserv ws in workers) {
          int co = 0;
          List<dynamic> mHour2 = [];
          ws.msh = "/";
          for (var h in selectedHour) {
            for (var mh in ws.Hour) {
              if (h == mh) {
                mHour2.insert(co, h);
                co++;
                ws.msh = ws.msh + h + "/";
              }
            }
          }
          ws.mHour = mHour2;
        }
      });
    }
    print(workers);
    int mincost = 1000;
    List<String> prefr = ordpref.split(',');
    for (int g = 0; g < workers.length; g++) {
      for (int o = 0; o < prefr.length; o++) {
        if (prefr[o] == 'b') {
          workers[g].points += (prefr.length - o) + workers[g].behave;
        }
        if (prefr[o] == 'm') {
          workers[g].points += (prefr.length - o) + workers[g].master;
        }
        if (prefr[o] == 't') {
          workers[g].points += (prefr.length - o) + workers[g].timing;
        }
        if (prefr[o] == 'p') {
          if (int.parse(workers[g].Price) <= mincost) {
            workers[g].points += (prefr.length - o) + 1;
            mincost = int.parse(workers[g].Price);
          }
        }
      }
    }
    for (int g = 0; g < workers.length; g++) {
      print(workers[g].Wname + " " + workers[g].points.toString());
    }

    for (int g = 0; g < workers.length; g++) {
      int d = 0;
      if (workers[g].worder != null) {
        for (int y = 0; y < workers[g].worder.length; y++) {
          if (workers[g].worder[y]['isrepeated'] == 'مرة واحدة') {
            if (workers[g].worder[y]['date'] == orddate) {
              for (int o = 0; o < workers[g].mHour.length; o++) {
                if (workers[g].worder[y]['Hour'] == workers[g].mHour[o]) {
                  workers[g].mHour.removeAt(o);
                  o = 0;
                }
              }
            }
          }
          if (workers[g].worder[y]['isrepeated'] == 'يومياً') {
            DateTime dt1 = DateTime.parse(workers[g].worder[y]['date']);
            DateTime dt2 = DateTime.parse(orddate);
            print(dt1);
            print(workers[g].worder[y]['date'] + " date s");
            print(orddate + " orddate");
            print(dt2);
            if (dt2.isAfter(dt1)) {
              for (int o = 0; o < workers[g].mHour.length; o++) {
                if (workers[g].worder[y]['Hour'] == workers[g].mHour[o]) {
                  workers[g].mHour.removeAt(o);
                  o = 0;
                }
              }
            }
          }
          if (workers[g].worder[y]['isrepeated'] == 'اسبوعياً') {
            DateTime dt1 = DateTime.parse(workers[g].worder[y]['date']);
            DateTime dt2 = DateTime.parse(orddate);
            print(dt1);
            print(dt2);
            final difference = dt2.difference(dt1).inDays;
            if (dt2.isAfter(dt1) && (difference % 7 == 0)) {
              for (int o = 0; o < workers[g].mHour.length; o++) {
                if (workers[g].worder[y]['Hour'] == workers[g].mHour[o]) {
                  workers[g].mHour.removeAt(o);
                  o = 0;
                }
              }
            }
          }
          if (workers[g].worder[y]['isrepeated'] == 'شهرياً ') {
            DateTime dt1 = DateTime.parse(workers[g].worder[y]['date']);
            DateTime dt2 = DateTime.parse(orddate);
            print(dt1);
            print(dt2);
            final difference = dt2.difference(dt1).inDays;
            if (dt2.isAfter(dt1) && (difference % 30 == 0)) {
              for (int o = 0; o < workers[g].mHour.length; o++) {
                if (workers[g].worder[y]['Hour'] == workers[g].mHour[o]) {
                  workers[g].mHour.removeAt(o);
                  o = 0;
                }
              }
            }
          }
        }
      }
      for (int g = 0; g < workers.length; g++) {
        if (workers[g].mHour.length == 0) {
          workers.removeAt(g);
          g = 0;
        }
      }
    }
    return parsed.map((e) => workserv.fromJson(e)).toList();
  }

  Future<List<workserv>> getow() async {
    print("hi function$typef");
    final resp = await http2.get(
      Uri.parse(
          'https://fani-service.onrender.com/servwork/5/$typef/$hourtosend'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      setState(() {
        // make changes here
        otherworkers = parsed.map((e) => workserv.fromJson(e)).toList();
      });
    }
    int mincost = 1000;
    // int rt = -1000;
    // int rm = -1000;
    // int rb = -1000;
    // int rp = 10000;
    List<String> prefr = ordpref.split(',');
    temp = otherworkers;
    temp.sort((a, b) => b.timing.compareTo(a.timing));
    topt = temp.take(3).toList();
    temp.sort((a, b) => b.master.compareTo(a.master));
    topm = temp.take(3).toList();
    temp.sort((a, b) => b.behave.compareTo(a.behave));
    topb = temp.take(3).toList();
    workers.sort((a, b) => a.Price.compareTo(b.Price));
    topp = temp.take(3).toList();

    for (int g = 0; g < otherworkers.length; g++) {
      for (int o = 0; o < prefr.length; o++) {
        if (prefr[o] == 'b') {
          otherworkers[g].points += (prefr.length - o) + otherworkers[g].behave;
          if (o == 0) {
            top1 = topb;
            desc1 = "الأعلى تقييما في السلوك ";
          }
          if (o == 1) {
            top2 = topb;
            desc2 = "الأعلى تقييما في السلوك ";
          }
          if (o == 2) {
            top3 = topb;
            desc3 = "الأعلى تقييما في السلوك ";
          }
        }
        if (prefr[o] == 'm' || prefr[o] == 'd') {
          otherworkers[g].points += (prefr.length - o) + otherworkers[g].master;
          if (o == 0) {
            top1 = topm;
            desc1 = "الأعلى تقييما في الاتقان ";
          }
          if (o == 1) {
            top2 = topm;
            desc2 = "الأعلى تقييما في الاتقان ";
          }
          if (o == 2) {
            top3 = topm;
            desc3 = "الأعلى تقييما في الاتقان ";
          }
        }
        if (prefr[o] == 't') {
          otherworkers[g].points += (prefr.length - o) + otherworkers[g].timing;
          if (o == 0) {
            top1 = topt;
            desc1 = "الأعلى تقييما في المواعيد ";
          }
          if (o == 1) {
            top2 = topt;
            desc2 = "الأعلى تقييما في المواعيد ";
          }
          if (o == 2) {
            top3 = topt;
            desc3 = "الأعلى تقييما في المواعيد ";
          }
        }
        if (prefr[o] == 'p') {
          if (int.parse(workers[g].Price) <= mincost) {
            workers[g].points += (prefr.length - o) + 1;
            mincost = int.parse(workers[g].Price);
            if (o == 0) {
              top1 = topp;
              desc1 = "الاقل سعرا";
            }
            if (o == 1) {
              top2 = topp;
              desc2 = "الاقل سعرا";
            }
            if (o == 2) {
              top3 = topp;
              desc3 = "الاقل سعرا";
            }
          }
        }
      }
    }
    return parsed.map((e) => workserv.fromJson(e)).toList();
  }

  @override
  void initState() {
    wHour = selectedHour;
    hourtosend = '';
    print("hourtosend is" + hourtosend);
    print(wHour);
    typef = typeofserv;
    for (int i = 0; i < wHour.length - 1; i++) {
      hourtosend = hourtosend + wHour[i] + ";";
    }
    hourtosend = hourtosend + wHour[wHour.length - 1];
    print(hourtosend);
    getw();
    getow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DateAndTime()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: lb,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          FadeAnimation(
              1,
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => viewa()),
                          );
                        },
                        child: Text(
                          'عرض الكل',
                        )),
                    Text(
                      'الأكثر ملائمة ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
          FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                  padding: EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade200,
                        offset: Offset(0, 4),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                workers.isEmpty
                                    ? Text(
                                        "",
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold),
                                      )
                                    : Text(
                                        workers[0].rating.toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                SizedBox(
                                  height: 5,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.orange,
                                  size: 20,
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(children: [
                                  PopupMenuButton(
                                    onSelected: (value) => setState(
                                        () => ordhour = value.toString()),
                                    itemBuilder: (context) => workers[0]
                                        .mHour
                                        .map((item) => PopupMenuItem<String>(
                                              value: item,
                                              child: Text(
                                                item,
                                              ),
                                            ))
                                        .toList(),
                                  ),
                                  workers.isEmpty
                                      ? Text(
                                          "",
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : Text(
                                          workers[0].Wname,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold),
                                        ),
                                ]),
                                SizedBox(
                                  height: 5,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  // child: Image.network(image)),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                workers.isEmpty
                                    ? Text(
                                        "",
                                        style: TextStyle(fontSize: 15),
                                      )
                                    : Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Text(
                                            textDirection: TextDirection.rtl,
                                            workers[0].Price,
                                            style: TextStyle(fontSize: 15),
                                          ),
                                        ],
                                      )
                              ],
                            )
                          ]),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(15.0)),
                        child: TextButton(
                            style: TextButton.styleFrom(
                                minimumSize: const Size.fromHeight(50)),
                            child: Text(
                              'حجز',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            onPressed: () {
                              ordhour == ""
                                  ? AwesomeDialog(
                                      context: context,
                                      dialogType: DialogType.info,
                                      animType: AnimType.BOTTOMSLIDE,
                                      desc:
                                          'الرجاء اختيار ساعة من القائمة بجوار الاسم,',
                                    ).show()
                                  : {
                                      ordwname = workers[0].Wname,
                                      ordprice = workers[0].Price,
                                      print(orduname +
                                          " " +
                                          ordwname +
                                          " " +
                                          ordhour +
                                          " " +
                                          ordprice +
                                          " " +
                                          ordrepeated +
                                          " " +
                                          orddate +
                                          " " +
                                          ordtype),
                                      showAlertDialog(context),
                                    };
                            }),
                      )
                    ],
                  ),
                ),
              )),
          SizedBox(
            height: 40,
          ),
          //
          SizedBox(
            height: 20,
          ),
          FadeAnimation(
              1.3,
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '',
                        )),
                    Text(
                      desc1,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: otherworkers.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeAnimation(
                      (1.0 + index) / 4,
                      workerContainer(top1[index].Wname, top1[index].Price,
                          top1[index].rating, top1[index].Hour));
                }),
          ),
          // SizedBox(
          //   height: 150,
          // ),
          SizedBox(
            height: 20,
          ),
          FadeAnimation(
              1.3,
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '',
                        )),
                    Text(
                      desc2,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: otherworkers.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeAnimation(
                      (1.0 + index) / 4,
                      workerContainer(top2[index].Wname, top2[index].Price,
                          top2[index].rating, top2[index].Hour));
                }),
          ),
          SizedBox(
            height: 20,
          ),
          FadeAnimation(
              1.3,
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          '',
                        )),
                    Text(
                      desc3,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            height: 120,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: otherworkers.length,
                itemBuilder: (BuildContext context, int index) {
                  return FadeAnimation(
                      (1.0 + index) / 4,
                      workerContainer(top3[index].Wname, top3[index].Price,
                          top3[index].rating, top3[index].Hour));
                }),
          ),
          SizedBox(
            height: 150,
          ),
        ])));
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("اتمام"),
      onPressed: () {
        createord(context, orduname, ordwname, ordhour, ordprice, ordrepeated,
            orddate, ordadd, ordserv, ordtype);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تأكيد عملية الطلب"),
      content: Text("هل تريد اتمام عملية الطلب"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  serviceContainer(String name, int index) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(
            color: Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.network(image, height: 45),
              SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 15),
              )
            ]),
      ),
    );
  }

//  workerContainer(String name, String job,String image,  double rating) {
  workerContainer(String name, String Price, int rating, List<dynamic> Hour) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Container(
          margin: EdgeInsets.only(right: 20),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: <
              Widget>[
            PopupMenuButton(
              onSelected: (value) => setState(() => ordhour = value.toString()),
              itemBuilder: (context) =>
                  Hour.map((item) => PopupMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                        ),
                      )).toList(),
            ),
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(5.0)),
              child: TextButton(
                  style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(10)),
                  child: Text(
                    'حجز',
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  onPressed: () {
                    ordhour == ""
                        ? AwesomeDialog(
                            context: context,
                            dialogType: DialogType.info,
                            animType: AnimType.BOTTOMSLIDE,
                            desc: 'الرجاء اختيار ساعة من القائمة بجوار الاسم,',
                          ).show()
                        : {
                            ordwname = name,
                            ordprice = Price,
                            showAlertDialog(context),
                          };
                  }),
            ),
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  rating.toString(),
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Icon(
                  Icons.star,
                  color: Colors.orange,
                  size: 20,
                )
              ],
            ),
            //
            Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  Price,
                  style: TextStyle(fontSize: 15),
                )
              ],
            ),
            SizedBox(
              width: 20,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              // child: Image.network(image)),
            ),
          ]),
        ),
      ),
    );
  }
}
