import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:http/http.dart' as http;

class TsU extends StatefulWidget {
  const TsU({
    super.key,
    required this.userName,
  });
  final String userName;
  @override
  State<TsU> createState() => _TsUState();
}

var user;
var imagg = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');
String nee = "";
String gee = "";
String dtt = "";
String emm = "";
String pss = "";
String pnn = "";
String ptt = "";
String addrr = "";
List addressList = addrr.split(',');

class _TsUState extends State<TsU> {
  void initState() {
    super.initState();
    nee = widget.userName;
    userInfo(widget.userName);
  }

  Future<void> userInfo(String name) async {
    final responseW = await http
        .get(Uri.parse('https://fani-service.onrender.com/users/2/$name'));
    if (responseW.statusCode == 200) {
      final user = jsonDecode(responseW.body);
      setState(() {
        nee = user['name'];
        gee = user['gender'];
        dtt = user['date'];
        emm = user['email'];
        pss = user['password'];
        pnn = user['phone'];
        addrr = user['address'];
        addressList = addrr.split(',');
        imagg = NetworkImage(user['image']);
      });
    } else {
      print("not exsist");
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget builimg() {
      return Container(
        width: 140.0,
        height: 140.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: lb,
            width: 5.0,
          ),
          image: DecorationImage(
            image: imagg,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget builinfo() {
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 18),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 247, 192, 89),
        ),
        child: Column(
          children: [
            Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'الجنس :',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  gee,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "الموقع :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width / 10,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children: List.generate(addressList.length, (index) {
                      final isLast = index == addressList.length - 1;
                      final comma = isLast ? '' : ', ';
                      return Row(
                        children: [
                          Text(
                            "${addressList[index]}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            comma,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "تاريخ الميلاد :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  dtt,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget builcon() {
      return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 18),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 239, 91),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'للتواصل :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.email, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  emm,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 23,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.phone, color: Colors.black),
                SizedBox(width: 10),
                Text(
                  pnn,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          // automaticallyImplyLeading: false,
          backgroundColor: lb,
          toolbarHeight: 60,
          title: Text('مرحبا ',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          // centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60),
              builimg(),
              SizedBox(height: 30),
              Text(
                "العميل $nee ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50),
              builinfo(),
              SizedBox(height: 30),
              builcon(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
