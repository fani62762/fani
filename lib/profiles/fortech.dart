import 'package:fani/msgs/viewmsgtech.dart';
import 'package:fani/profiles/edittech.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:fani/serv/Vieword.dart';

class ForTech extends StatefulWidget {
  const ForTech({
    super.key,
  });

  @override
  State<ForTech> createState() => _ForTechState();
}

List addressList = addr.split(',');

class _ForTechState extends State<ForTech> {
  @override
  void initState() {
    super.initState();
    addressList = addr.split(',');
  }

  @override
  Widget build(BuildContext context) {
    Widget builimg() {
      return Container(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 5.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: dy,
            width: 5.0,
          ),
          image: DecorationImage(
            image: imag,
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
                                fontSize: 16, fontWeight: FontWeight.bold),
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

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: lb,
          toolbarHeight: 75,
          title: Text('صفحتي الشخصية',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              builimg(),
              SizedBox(height: 15),
              Text(
                '  الفني $ne',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => editTech(
                                    techName: ne,
                                  )));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => editTech(
                                    techName: ne,
                                  )));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => Home()),
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              builbio(),
              SizedBox(height: 20),
              builinfo(),
              SizedBox(height: 20),
              builjobs(),
              SizedBox(height: 20),
              builcon(),
              SizedBox(height: 20),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: lb,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'صفحتي',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'الرسائل',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.request_page,
              ),
              label: 'المهام',
            ),
          ],
          onTap: (index) {
            switch (index) {
              case 0:
                print("prof");
                break;

              case 1:
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ViewMsgT()));
                print("viewmsgFORUSER");
                break;

              case 2:
                print("req");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Vieword()));
                break;
            }
          },
        ),
      ),
    );
  }
}
