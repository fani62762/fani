import 'dart:convert';
import 'package:fani/msgs/viewmsg.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:http/http.dart' as http;
import 'package:fani/auth/user.dart';

class UsT extends StatefulWidget {
  const UsT({
    super.key,
    required this.workName,
  });
  final String workName;
  @override
  State<UsT> createState() => _UsTState();
}

List<dynamic> servwork = [];
String ne = "";
String ge = "";
String dt = "";
String em = "";
String ps = "";
String pn = "";
String pt = "";
String bio = "";
String addr = "";
var imag = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');
List addressList = addr.split(',');

class _UsTState extends State<UsT> {
  void initState() {
    super.initState();
    ne = widget.workName;
    servwork.clear();
    workerInfo(widget.workName);
    getalls(widget.workName);
  }

  Future<void> workerInfo(String name) async {
    final responseW =
        await http.get(Uri.parse('https://fanii.onrender.com/worker/2/$name'));
    if (responseW.statusCode == 200) {
      final worker = jsonDecode(responseW.body);
      setState(() {
        ne = worker['name'];
        ge = worker['gender'];
        dt = worker['date'];
        em = worker['email'];
        ps = worker['password'];
        pn = worker['phone'];
        rt = worker['rating'];
        bio = worker['bio'];
        addr = worker['address'];
        addressList = addr.split(',');
        imag = NetworkImage(worker['image']);
        print("hii${worker['image']}");
      });
    } else {
      print("not exsist");
    }
  }

  Future<void> getalls(String name) async {
    final response = await http
        .get(Uri.parse('https://fanii.onrender.com/servwork/4/?Wname=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      servwork = data;

      print(servwork);
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    print(ne);
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
            image: imag,
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    Widget builbio() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 255, 239, 91),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'السيرة الذاتية :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    bio,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      );
    }

    Widget builcon() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
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
                  em,
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
                  pn,
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

    Widget builinfo() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
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
                  ge,
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
                  dt,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget builjobs() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 228, 228, 226),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'المهن التي أقوم بها :',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: MediaQuery.of(context).size.width / 3,
              child: ListView.builder(
                itemCount: servwork.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.circle, color: Colors.black, size: 17),
                          SizedBox(width: 10),
                          Text(
                            servwork[index]["TypeServ"].toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              SizedBox(width: 27),
                              Row(children: <Widget>[
                                for (int i = 0;
                                    i < servwork[index]["rating"];
                                    i++)
                                  Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 25,
                                  )
                              ])
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            ' ساعات العمل: ',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width / 23,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 10,
                            width: MediaQuery.of(context).size.width / 2,
                            child: ListView(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              children: List.generate(
                                  servwork[index]["Hours"].length, (indd) {
                                final isLast =
                                    indd == servwork[index]["Hours"].length - 1;
                                final comma = isLast ? '' : ', ';
                                return Row(
                                  children: [
                                    Text(
                                      "${servwork[index]["Hours"][indd].toString()}",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      comma,
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            ' سعر الساعة : ' +
                                servwork[index]["Price"].toString(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                    ],
                  );
                },
              ),
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
          title: Text('مرحبا $nee',
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
              SizedBox(height: 40),
              builimg(),
              SizedBox(height: 20),
              Text(
                " الفني $ne ",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              builinfo(),
              SizedBox(height: 20),
              builjobs(),
              SizedBox(height: 20),
              builcon(),
              SizedBox(height: 20),
              builbio(),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
