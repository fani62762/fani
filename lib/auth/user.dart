import 'package:fani/main.dart';
import 'package:fani/msgs/viewmsg.dart';
import 'package:fani/notifi/notifi_service.dart';
import 'package:fani/profiles/foruser.dart';
import 'package:flutter/material.dart';
import 'package:fani/serv/globalserv.dart';
import 'dart:async';
import 'package:flutter/rendering.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

String usname = "";
String orduname = "";
var imagg = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');

TextEditingController naaCon = TextEditingController();
TextEditingController emmCon = TextEditingController();
TextEditingController pssCon = TextEditingController();
TextEditingController mobbC = TextEditingController();
TextEditingController gnnCon = TextEditingController();
TextEditingController dttCon = TextEditingController();
TextEditingController addrrcon = TextEditingController();

String nee = "";
String gee = "";
String dtt = "";
String emm = "";
String pss = "";
String pnn = "";
String ptt = "";
String addrr = "";

var exwork = List<int>.filled(15, 0, growable: true); // [0, 0, 0]

String typeofserv = "";
PreferredSize builbar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(kToolbarHeight),
    child: AppBar(
      backgroundColor: dy,
      title: Text(
        '     مرحبا $nee',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
      ),
      automaticallyImplyLeading: false,
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => ForUser()));
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
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => ViewMsg()));
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
              //  Navigator.of(context).pushNamed("request");
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

class Userpage extends StatefulWidget {
  const Userpage({required this.userName, super.key});
  final String userName;
  @override
  State<Userpage> createState() => _UserpageState();
}

class Service {
  final String nameS;
  final String imageURL;
  Widget nextpage;
  Service(this.nameS, this.imageURL, this.nextpage);
}

class types {
  final String type;
  final String avatar;
  String id;
  types({
    this.type = "",
    this.avatar = "",
    this.id = "",
  });

  factory types.fromJson(Map<String, dynamic> json) {
    return types(
      type: json['type'],
      avatar: json['avatar'],
      id: json["_id"],
    );
  }
  @override
  String toString() {
    return 'types{avatar: $avatar, type: $type}';
  }
}

int idx = -1;

class lim {
  final String max;
  final String min;
  final String id;
  lim({
    this.max = "",
    this.min = "",
    this.id = "",
  });

  factory lim.fromJson(Map<String, dynamic> json) {
    return lim(
      max: json['max'],
      min: json['min'],
      id: json['_id'],
    );
  }
  @override
  String toString() {
    return 'limits{id:$id,max: $max, min: $min}';
  }
}

class _UserpageState extends State<Userpage> {
  Future<void> userInfo(String name) async {
    final responseU =
        await http.get(Uri.parse('https://fanii.onrender.com/users/2/$name'));
    if (responseU.statusCode == 200) {
      final userr = jsonDecode(responseU.body);
      naaCon = TextEditingController(text: userr['name']);
      emmCon = TextEditingController(text: userr['email']);
      mobbC = TextEditingController(text: userr['phone']);
      pssCon = TextEditingController(text: userr['password']);
      gnnCon = TextEditingController(text: userr['gender']);
      dttCon = TextEditingController(text: userr['date']);
      dttCon = TextEditingController(text: userr['date']);
      addrrcon = TextEditingController(text: userr['address']);
      nee = userr['name'];
      gee = userr['gender'];
      dtt = userr['date'];
      emm = userr['email'];
      pss = userr['password'];
      pnn = userr['phone'];
      addrr = userr['address'];
      imagg = NetworkImage(userr['image']);
    } else {
      print('uur: ${responseU.statusCode}');
      print("not exsist");
    }
  }

  late final PageController pageController;
  ScrollController _scrollController = ScrollController();
  int pageNo = 0;
  int selectedService = -1;

  Timer? carasouelTmer;
  List stype = [];
  var limits = [];
  Future<List<types>> getAlltype() async {
    // print("hi function get all");
    final resp = await http.get(
      Uri.parse('https://fanii.onrender.com/type/'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    //rooms = parsed.map((e) => serv.fromJson(e)).toList();

    if (this.mounted) {
      setState(() {
        // make changes here
        stype = parsed.map((e) => types.fromJson(e)).toList();
      });
    }
    return parsed.map((e) => types.fromJson(e)).toList();
  }

  Future<List<types>> getlimits() async {
    // print("hi function get all");
    final resp = await http.get(
      Uri.parse('https://fanii.onrender.com/servwork/3'),
      headers: {'Content-Type': 'application/json'},
    );
    final parsed = jsonDecode(resp.body) as List;
    if (this.mounted) {
      setState(() {
        limits = parsed.map((e) => lim.fromJson(e)).toList();
      });
    }
    return parsed.map((e) => types.fromJson(e)).toList();
  }

  Timer getTimer() {
    return Timer.periodic(const Duration(seconds: 3), (timer) {
      if (pageNo == 4) {
        pageNo = 0;
      }
      // pageController.animateToPage(
      //   pageNo,
      //   duration: const Duration(seconds: 1),
      //   curve: Curves.easeInOutCirc,
      // );
      pageNo++;
    });
  }

  @override
  void initState() {
    getAlltype();
    getlimits();
    userInfo(widget.userName);
    usname = widget.userName;
    pageController = PageController(initialPage: 0, viewportFraction: 0.85);
    carasouelTmer = getTimer();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        showBtmAppBr = false;
        setState(() {});
      } else {
        showBtmAppBr = true;
        setState(() {});
      }
    });
    if (t == 0) {
      NotificationService().showNotification(
          title: "    🖐   أهلاً  ${widget.userName}",
          body: "    قم باختيار خدماتك مع أفضل الفًَنين  🔥 ");
      t = t + 1;
    }

    super.initState();
  }

  @override
  bool showBtmAppBr = true;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: selectedService >= 0
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Gserv()));
                },
                child: Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                ),
                backgroundColor: Colors.blue,
              )
            : null,
        appBar: builbar(),
        endDrawer: billenddrawer(context),
        body: Column(
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (index) {
                  pageNo = index;
                  setState(() {});
                },
                itemBuilder: (_, index) {
                  return AnimatedBuilder(
                    animation: pageController,
                    builder: (ctx, child) {
                      return child!;
                    },
                    child: GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Hello you tapped at ${index + 1} "),
                          ),
                        );
                      },
                      onPanDown: (d) {
                        carasouelTmer?.cancel();
                        carasouelTmer = null;
                      },
                      onPanCancel: () {
                        carasouelTmer = getTimer();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            right: 8, left: 8, top: 24, bottom: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24.0),
                          color: Colors.amberAccent,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: 5,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: 'ما هي الخدمة التي تريدها ؟',
                  hintStyle: TextStyle(color: db),
                  helperText: '',
                  prefixIcon: Icon(Icons.search_sharp, color: db),
                  suffixIcon: Icon(Icons.camera_alt, color: db),
                ),
                validator: (value) {
                  print(value);
                },
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: stype.length,
                padding: EdgeInsets.fromLTRB(20.0, 5, 20, 20),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //4
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 20.0, //5
                  mainAxisSpacing: 20.0,
                ),
                itemBuilder: (context, index) {
                  idx = limits.indexWhere((f) => f.id == stype[index].type);
                  if (idx >= 0)
                    exwork[index] = 1;
                  else
                    exwork[index] = 0;
                  return InkResponse(
                    onTap: () {
                      setState(() {
                        if (selectedService == index)
                          selectedService = -1;
                        else {
                          if (exwork[index] == 0)
                            selectedService = -1;
                          else {
                            print("idx is not -1 $exwork[index]$index");
                            selectedService = index;
                            typeofserv = stype[index].type;
                          }
                        }
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: selectedService == index
                            ? Colors.blue.shade50
                            : Colors.grey.shade100,
                        border: Border.all(
                          color: selectedService == index
                              ? Colors.blue
                              : Colors.blue.withOpacity(0),
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            stype[index].avatar,
                            width: MediaQuery.of(context).size.width / 5,
                            height: MediaQuery.of(context).size.width / 5,
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            stype[index].type,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          idx >= 0
                              ? limits[idx].min != limits[idx].max
                                  ? Text(
                                      limits[idx].min +
                                          "\$ - " +
                                          limits[idx].max +
                                          "\$",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize: 15),
                                    )
                                  : Text(
                                      limits[idx].min + "\$  ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                          fontSize: 15),
                                    )
                              : Text(
                                  "لا يوجد عمال حاليا",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                      fontSize: 13),
                                ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  serviceContainer(String image, String nameS, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index)
            selectedService = -1;
          else {
            selectedService = index;
          }
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index
              ? Colors.blue.shade50
              : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index
                ? Colors.blue
                : Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 80),
              SizedBox(
                height: 20,
              ),
              Text(
                nameS,
                style: TextStyle(fontSize: 20),
              )
            ]),
      ),
    );
  }
}
