import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fani/serv/viewordu.dart';
import 'package:http/http.dart' as http2;
import 'dart:convert';
import 'package:fani/auth/user.dart';
import 'package:fani/profiles/edittech.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:fani/msgs/viewmsg.dart';
import 'package:fani/notifi/notifi_service.dart';
import 'package:fani/profiles/foruser.dart';
import 'package:flutter/material.dart';
import 'package:fani/serv/globalserv.dart';
import 'package:fani/serv/dashboard.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'dart:ui' as ui;
import 'package:intl/intl.dart';

int ch = 1;
int ch1 = 1;
int ch2 = 1;
int oldrat = 0;
String myid = "";
int additionalValue = 0; // The additional value to add to the color

Color originalColor = Colors.white;
Color modifiedColor = Color.fromARGB(
  originalColor.alpha,
  originalColor.red + additionalValue,
  originalColor.green + additionalValue,
  originalColor.blue + additionalValue,
);

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

class servwork {
  final String TypeServ;
  final String Wname;

  final String Price;
  final List<String> Hour;

  final int rating;
  final int master;
  final int behave;
  final int timing;

  String id;
  servwork({
    this.TypeServ = "",
    this.Wname = "",
    this.Price = "",
    this.Hour = const [],
    this.rating = 0,
    this.timing = 0,
    this.behave = 0,
    this.master = 0,
    this.id = "",
  });
  int additionalValue = 50; // The additional value to add to the color

  factory servwork.fromJson(Map<String, dynamic> json) {
    return servwork(
      TypeServ: json['TypeServ'],
      Wname: json['Wname'],
      rating: json['rating'],
      timing: json['timing'],
      behave: json['behave'],
      master: json['master'],
      Hour: json['Hour'],
      id: json['_id'],
      Price: json['Price'],
    );
  }
  @override
  String toString() {
    return 'servwork{Wname: $Wname, Price: $Price,Hour:$Hour,,reating:$rating,timing:$timing,master:$master,behave:$behave}';
  }
}

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 91, 179, 242),
      elevation: 0.0,
      // leading: IconButton(
      //   icon: const Icon(Icons.menu),
      //   iconSize: 28.0,
      //   onPressed: () {},
      // ),
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.notifications_none),
          iconSize: 28.0,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

_StatsScreenState inst = new _StatsScreenState();

class StatsGrid extends StatefulWidget {
  StatsGrid({required this.orderg, required this.index, super.key});
  final morder orderg;
  final int index;

  @override
  State<StatsGrid> createState() => _StatsGridState();
}

int _rating = 0;

class _StatsGridState extends State<StatsGrid> {
  void showRatingDialog(int index) {
    int masteryRating = 0;
    int behaviorRating = 0;
    int timeAccuracyRating = 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('تقييم عامل'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('كيف تقيم العامل في هذه المهنة ؟'),
              SizedBox(height: 20),
              Text('تقييم الإتقان'),
              RatingBar.builder(
                initialRating: masteryRating.toDouble(),
                minRating: 1,
                maxRating: 5,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Icon(
                    index < masteryRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (rating) {
                  setState(() {
                    masteryRating = rating.toInt();
                  });
                },
              ),
              Text('تقييم السلوك'),
              RatingBar.builder(
                initialRating: behaviorRating.toDouble(),
                minRating: 1,
                maxRating: 5,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Icon(
                    index < behaviorRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (rating) {
                  setState(() {
                    behaviorRating = rating.toInt();
                  });
                },
              ),
              Text('تقييم الدقة الزمنية'),
              RatingBar.builder(
                initialRating: timeAccuracyRating.toDouble(),
                minRating: 1,
                maxRating: 5,
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Icon(
                    index < timeAccuracyRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                  );
                },
                onRatingUpdate: (rating) {
                  setState(() {
                    timeAccuracyRating = rating.toInt();
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('الغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('تم'),
              onPressed: () async {
                await inst.getSerWorkert(
                    naccp[index].Wname,
                    naccp[index].TypeServ,
                    index,
                    _rating,
                    masteryRating,
                    behaviorRating,
                    timeAccuracyRating);

                // TODO: save the ratings

                naccp[index].acc = 2;
                accp.add(naccp[index]);
                myid = naccp[index].id;
                await inst.updateaccw(naccp[index].id, 2);
                await naccp.removeAt(index);

                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
          ],
        );
      },
    );
  }
  // void showRatingDialog(int index) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text('تقييم عامل'),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Text('كيف تقيم العامل في هذه المهنة ؟'),
  //             SizedBox(height: 20),
  //             RatingBar.builder(
  //               initialRating: _rating.toDouble(),
  //               minRating: 1,
  //               maxRating: 5,
  //               itemCount: 5,
  //               itemBuilder: (context, index) {
  //                 return Icon(
  //                   index < _rating ? Icons.star : Icons.star_border,
  //                   color: Colors.amber,
  //                 );
  //               },
  //               onRatingUpdate: (rating) {
  //                 setState(() {
  //                   _rating = rating.toInt();
  //                 });
  //               },
  //             ),
  //           ],
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: Text('الغاء'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           TextButton(
  //             child: Text('تم'),
  //             onPressed: () async {
  //               await inst.getSerWorkert(
  //                   naccp[index].Wname, naccp[index].TypeServ, index, _rating);

  //               // TODO: save the rating

  //               naccp[index].acc = 2;
  //               accp.add(naccp[index]);
  //               await inst.updateaccw(naccp[index].id, 2);
  //               await naccp.removeAt(index);

  //               Navigator.of(context, rootNavigator: true).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildStatCard(
                    ' اسم العامل ونوع الخدمة',
                    widget.orderg.Wname + "\n" + widget.orderg.TypeServ,
                    Colors.orange),
                _buildStatCard(
                    'السعر في الساعة', widget.orderg.Price, Colors.orange),
              ],
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildStatCard(
                    'التاريخ والوقت',
                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse(widget.orderg.date))}' +
                        "\n" +
                        widget.orderg.Hour +
                        "\n" +
                        widget.orderg.isrepeated,
                    Colors.green),
                _buildStatCard(
                    'الخدمات', widget.orderg.serv.toString(), Colors.green),
                _buildStatCard('طلبات اضافية', widget.orderg.add.toString(),
                    Colors.green),
              ],
            ),
          ),
          if (ch == 1 && ch1 == 2)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    // handle cross button press
                    showRatingDialog(widget.index);
                  },
                  icon: Icon(
                    Icons.check,
                    color: Colors.green,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // handle cross button press
                    _handleButtonPress();
                  },
                  icon: Icon(Icons.close, color: Colors.red),
                ),
              ],
            ),
          // if (ch == 2)
          if (ch == 2 || ch1 == 2) SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _handleButtonPress() async {
    setState(() {
      naccp[widget.index].acc = -2;
      cccp.add(naccp[widget.index]);
      inst.updateaccw(naccp[widget.index].id, -2);
      naccp.removeAt(widget.index);
    });
  }

  Expanded _buildStatCard(String title, String count, Color color) {
    return Expanded(
        child: Container(
      height: MediaQuery.of(context).size.height * .50,
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          textDirection: ui.TextDirection.rtl,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              textDirection: ui.TextDirection.rtl,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              count,
              textDirection: ui.TextDirection.rtl,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Styles {
  static const buttonTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  static const chartLabelsTextStyle = TextStyle(
    color: Colors.grey,
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static const tabTextStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );
}

class Palette {
  static const Color primaryColor = Color.fromARGB(255, 240, 248, 250);
}

class StatsScreen extends StatefulWidget {
  const StatsScreen({Key? key}) : super(key: key);
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

List<morder> naccp = [];
List<morder> waccp = [];
List<morder> accp = [];
List<morder> cccp = [];
List<servwork> service = [];

class _StatsScreenState extends State<StatsScreen> {
  Future<List<morder>> getUserordu() async {
    print(techname + "this is techname");
    final resp = await http2.get(
      Uri.parse('https://fani-service.onrender.com/ord/4/$usname'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      print("func44");
      setState(() {
        naccp = parsed.map((e) => morder.fromJson(e)).toList();
        print(naccp);
      });
    }
    return parsed.map((e) => morder.fromJson(e)).toList();
  }

  Future<List<servwork>> getSerWorkert(String name, String TypeServ, int index,
      int _rating, int master, int behave, int timing) async {
    print(name);
    print(TypeServ);
    print("func");
    final resp = await http2.get(
      Uri.parse(
          'https://fani-service.onrender.com/servwork/6/?Wname=$name&TypeServ=$TypeServ'),
      headers: {'Content-Type': 'application/json'},
    );
    print("func2");
    if (resp.statusCode == 200) {
      print("func3");
      final parsed = jsonDecode(resp.body) as List;
      //if (this.mounted) {
      print("func4");
      // setState(() {
      service = parsed.map((e) => servwork.fromJson(e)).toList();
      print(service);
      oldrat = service[0].rating;
      print(oldrat);
      // });
      print("func5");
      _rating = ((master + behave + timing) / 3).round();
      int newm = ((master + service[0].master) / 2).round();
      int newt = ((behave + service[0].behave) / 2).round();
      int newb = ((timing + service[0].timing) / 2).round();
      updaterate2(myid, _rating);
      inst.updaterate(naccp[index].Wname, naccp[index].TypeServ, _rating,
          service[0].rating, newm, newb, newt);
      // }

      return parsed.map((e) => servwork.fromJson(e)).toList();
    } else {
      print("not exist");
    }

    return service;
  }

  Future<List<morder>> getUserordc() async {
    print(techname + "this is techname");
    final resp = await http2.get(
      Uri.parse('https://fani-service.onrender.com/ord/9/$usname'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      setState(() {
        cccp = parsed.map((e) => morder.fromJson(e)).toList();
        print(cccp);
      });
    }
    return parsed.map((e) => morder.fromJson(e)).toList();
  }

  Future<void> updaterate2(String id, int rating) async {
    print("hihihi" + id + rating.toString());
    final body = jsonEncode({
      'acc': rating,
    });
    final response = await http2.put(
      Uri.parse('https://fani-service.onrender.com/ord/88/$id'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      print('success to update');
    } else {
      print('Failed to update ');
    }
  }

  Future<void> updateaccw(String id, int acc) async {
    print("hihihi" + id + acc.toString());
    final body = jsonEncode({
      'acc': acc,
    });
    final response = await http2.put(
      Uri.parse('https://fani-service.onrender.com/ord/7/$id'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      print('success to update');
    } else {
      print('Failed to update ');
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

  Future<void> updaterate(String name, String TypeServ, int rating, int oldrat,
      int master, int behave, int timing) async {
    int newrate = ((rating + oldrat) / 2).round();
    print(name);

    print(behave);
    print(master);
    print(timing);
    print(TypeServ);
    print(rating);
    print(oldrat);
    print("newrate");
    print(newrate);
    final body = jsonEncode({
      "rating": newrate,
      "timing": timing,
      "master": master,
      "behave": behave
    });
    final response = await http2.put(
      Uri.parse(
          'https://fani-service.onrender.com/servwork/7/?Wname=$name&TypeServ=$TypeServ'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      print("success update all rate");
      // Worker rating updated successfully
    } else {
      print('Failed to update worker rating');
    }
  }

  Future<List<morder>> getUserordd() async {
    final resp = await http2.get(
      Uri.parse('https://fani-service.onrender.com/ord/3/$usname'),
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

  Future<List<morder>> getUserordw() async {
    final resp = await http2.get(
      Uri.parse('https://fani-service.onrender.com/ord/99/$usname'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      setState(() {
        waccp = parsed.map((e) => morder.fromJson(e)).toList();
        print(waccp);
      });
    }

    return parsed.map((e) => morder.fromJson(e)).toList();
  }

  @override
  void initState() {
    techname = tname;
    print(usname + "this is usname");
    getUserordu();
    getUserordd();
    getUserordc();
    getUserordw();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Palette.primaryColor,
        //appBar: CustomAppBar(),
        appBar: builbar(),
        endDrawer: billenddrawer(context),
        body: CustomScrollView(
          physics: ClampingScrollPhysics(),
          slivers: <Widget>[
            _buildHeader(),
            _buildRegionTabBar(),
            ch == 1 ? _buildStatsTabBard() : _buildStatsTabBar(),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              //sliver: SliverToBoxAdapter(
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    additionalValue += 50;
                    modifiedColor = Color.fromARGB(
                      originalColor.alpha,
                      modifiedColor.red + additionalValue,
                      modifiedColor.green + additionalValue,
                      modifiedColor.blue + additionalValue,
                    );
                    if (ch == 1) {
                      if (ch1 == 1) {
                        return Column(
                          children: [
                            StatsGrid(orderg: waccp[index], index: index),
                            Divider(color: Colors.black, thickness: 1.0),
                          ],
                        );
                      } else if (ch1 == 2) {
                        return Column(
                          children: [
                            StatsGrid(orderg: naccp[index], index: index),
                            Divider(color: Colors.black, thickness: 1.0),
                          ],
                        );
                      }
                    } else if (ch2 == 1) {
                      return Column(
                        children: [
                          StatsGrid(orderg: accp[index], index: index),
                          Divider(color: Colors.black, thickness: 1.0),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          StatsGrid(orderg: cccp[index], index: index),
                          Divider(color: Colors.black, thickness: 1.0),
                        ],
                      );
                    }
                  },
                  childCount: ch == 1 && ch1 == 1
                      ? waccp.length
                      : ch == 1 && ch1 == 2
                          ? naccp.length
                          : ch == 2 && ch2 == 1
                              ? accp.length
                              : cccp.length,
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(top: 20.0),
              sliver: SliverToBoxAdapter(
                  // child: CovidBarChart(covidCases: covidUSADailyNewCases),
                  ),
            ),
          ],
        ),
      ),
    );
  }

  SliverPadding _buildHeader() {
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: Text(
          'طلباتي',
          textDirection: ui.TextDirection.rtl,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  PreferredSize billenddrawer(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight),
      child: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: dy),
              accountName: Text(
                nee,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                emm,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              currentAccountPicture: Container(
                width: MediaQuery.of(context).size.width / 5.5,
                height: MediaQuery.of(context).size.height / 10.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  image: DecorationImage(
                    image: imagg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
                height: 1,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(236, 231, 150, 74),
                      blurRadius: 10.0,
                    ),
                  ],
                )),
            ListTile(
              leading: Icon(
                Icons.person,
                color: db,
              ),
              title: Text(
                "صفحتي الشخصية",
                style: TextStyle(color: db, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ForUser()));
                //   print("foruser profiles");
              },
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              leading: Icon(
                Icons.message,
                color: db,
              ),
              title: Text(
                "الرسائل",
                style: TextStyle(color: db, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ViewMsg()));
                //   print("foruser profiles");
              },
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              leading: Icon(
                Icons.add_home_work,
                color: db,
              ),
              title: Text(
                " الخدمات التي قمت بحجزها",
                style: TextStyle(color: db, fontWeight: FontWeight.w300),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => StatsScreen()));
                //   print("foruser profiles");
              },
            ),
            SizedBox(
              height: 5,
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
                color: db,
              ),
              title: Text(
                " تسجيل الخروج",
                style: TextStyle(color: db, fontWeight: FontWeight.w300),
              ),
              onTap: () async {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildRegionTabBar() {
    return SliverToBoxAdapter(
      child: DefaultTabController(
        length: 2,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          height: 50.0,
          decoration: BoxDecoration(
            color: Color.fromARGB(59, 99, 126, 245),
            borderRadius: BorderRadius.circular(25.0),
          ),
          child: TabBar(
            indicator: BubbleTabIndicator(
              tabBarIndicatorSize: TabBarIndicatorSize.tab,
              indicatorHeight: 40.0,
              indicatorColor: Colors.white,
            ),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.black,
            unselectedLabelColor: Colors.blue,
            tabs: <Widget>[
              Text('قيد التنفيذ'),
              Text('طلبات سابقة'),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  print("curr");
                  setState(() =>
                      //datatime = nt
                      ch = 1);
                  break;
                case 1:
                  setState(() {
                    //datatime = nt
                    ch = 2;
                    _buildStatsTabBar();
                  });
                  print("ex");
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  double _rating = 0;

  SliverPadding _buildStatsTabBar() {
    print("silver");
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 2,
          child: TabBar(
            indicatorColor: Color.fromARGB(0, 115, 90, 241),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.blue,
            tabs: <Widget>[
              Text('تمت'),
              Text('تم الغاؤها'),
              // Text('Yesterday'),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  print("curr");
                  setState(() =>
                      //datatime = nt
                      ch2 = 1);
                  break;
                case 1:
                  setState(() {
                    //datatime = nt
                    ch2 = 2;
                  });
                  print("ex");
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  SliverPadding _buildStatsTabBard() {
    print("silver2");
    return SliverPadding(
      padding: const EdgeInsets.all(20.0),
      sliver: SliverToBoxAdapter(
        child: DefaultTabController(
          length: 2,
          child: TabBar(
            indicatorColor: Color.fromARGB(0, 115, 90, 241),
            labelStyle: Styles.tabTextStyle,
            labelColor: Colors.blue,
            unselectedLabelColor: Colors.blue,
            tabs: <Widget>[
              Text('بانتظار موافقة العامل'),
              Text('قيد التنفيذ '),
              // Text('Yesterday'),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  print("curr");
                  setState(() =>
                      //datatime = nt
                      ch1 = 1);
                  break;
                case 1:
                  setState(() {
                    //datatime = nt
                    ch1 = 2;
                  });
                  print("ex");
                  break;
              }
            },
          ),
        ),
      ),
    );
  }
}
