import 'dart:convert';

import 'package:fani/auth/user.dart';
import 'package:fani/msgs/viewmsg.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:fani/profiles/edittuser.dart';
//import 'package:fani/serv/Viewordu.dart';
import 'package:fani/serv/dashboard.dart';
import 'package:http/http.dart' as http;

class Preference {
  final String id;
  final String label;

  Preference(this.id, this.label);
}

class ForUser extends StatefulWidget {
  const ForUser({super.key});

  @override
  State<ForUser> createState() => _ForUserState();
}

List addressList = addrr.split(',');
List<Preference> orderedPreferences = [];
List<Preference> availablePreferences = [
  Preference('d', 'المسافة'),
  Preference('p', 'السعر'),
  Preference('m', 'الاتقان'),
  Preference('t', 'الدقة في المواعيد'),
  Preference('b', 'الاسلوب'),
  // Add more preferences as needed
];

// Order order = Order(
//   typeOfService: 'Cleaning',
//   hour: '2-4',
//   workerName: 'John Doe',
//   userName: 'Jane Doe',
//   services: ['Kitchen', 'Bathroom', 'Living Room'],
//   additionalServices: ['Windows Cleaning', 'Carpet Cleaning'],
//   appointmentTime: '2-2-2002', //DateTime(2022, 5, 15, 14, 30),
//   isRepeated: true,
//   pricePerHour: 25.0,
// );

class _ForUserState extends State<ForUser> {
  bool showPreferences = false; // Flag to control visibility

  void togglePreferencesVisibility() {
    setState(() {
      showPreferences = !showPreferences;
    });
  }

  Future<void> userInfo(String name) async {
    final responseU = await http
        .get(Uri.parse('https://fani-service.onrender.com/users/2/$name'));
    if (responseU.statusCode == 200) {
      final userr = jsonDecode(responseU.body);
      setState(() {
        naaCon = TextEditingController(text: userr['name']);
        emmCon = TextEditingController(text: userr['email']);
        mobbC = TextEditingController(text: userr['phone']);
        pssCon = TextEditingController(text: userr['password']);
        gnnCon = TextEditingController(text: userr['gender']);
        dttCon = TextEditingController(text: userr['date']);
        addrrcon = TextEditingController(text: userr['address']);
        nee = userr['name'];
        gee = userr['gender'];
        dtt = userr['date'];
        emm = userr['email'];
        pss = userr['password'];
        pnn = userr['phone'];
        addrr = userr['address'];
        print(addrr);
        ordpref = userr['pref'];
        imagg = NetworkImage(userr['image']);
      });
    } else {
      print('uur: ${responseU.statusCode}');
      print("not exsist");
    }
  }

  @override
  void initState() {
    super.initState();
    addressList = addrr.split(',');
    print(addressList);
    userInfo(nee);

    List<String> preferenceIds = ordpref.split(',');
    orderedPreferences = preferenceIds.map((id) {
      return availablePreferences
          .firstWhere((preference) => preference.id.toString() == id);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
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

    Widget builipref() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        // padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 223, 223, 223),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'تحديد أهم صفات العمال  :',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Expanded(
                ElevatedButton(
                  onPressed: togglePreferencesVisibility,
                  child: Text('الاولويات'),
                ),

                // Other widgets in the Row
                Expanded(
                    child: Visibility(
                  visible: showPreferences,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 300,
                      maxWidth: 600,
                    ),
                    child: Container(
                      width: double.infinity, // Adjust the width as needed
                      child: ListView.builder(
                        itemCount: orderedPreferences.length,
                        itemBuilder: (context, index) {
                          Preference preference = orderedPreferences[index];

                          return ListTile(
                            title: Text(preference.label),
                            // leading: Checkbox(
                            //   value: selectedPreferences.contains(preference),
                            //   onChanged: (value) {
                            //     togglePreferenceSelection(preference);
                            //   },
                            // ),
                          );
                        },
                      ),
                    ),
                  ),
                ))
                // Visibility(
                //   visible: showPreferences,
                //   child: ConstrainedBox(
                //       constraints: BoxConstraints(
                //         maxHeight: 300,
                //         maxWidth: 600,
                //       ),
                //       child: ListView.builder(
                //         itemCount: orderedPreferences.length,
                //         itemBuilder: (context, index) {
                //           Preference preference = orderedPreferences[index];

                //           return ListTile(
                //             title: Text(preference.label),
                //             // leading: Checkbox(
                //             //   value: selectedPreferences.contains(preference),
                //             //   onChanged: (value) {
                //             //     togglePreferenceSelection(preference);
                //             //   },
                //             // ),
                //           );
                //         },
                //       )),
                // )
              ],
            ))
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
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: lb,
            toolbarHeight: 80,
            title: Text('صفحتي الشخصية',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                )),
            centerTitle: true,
            automaticallyImplyLeading: false),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                height: MediaQuery.of(context).size.height / 5.5,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: dy,
                    width: 5.0,
                  ),
                  image: DecorationImage(
                    image: imagg,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                nee,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_outlined),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Userpage(
                                    userName: nee,
                                  )));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => editUser(
                                    UserName: nee,
                                  )));
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.exit_to_app_sharp),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              builinfo(),
              SizedBox(height: 20),
              builcon(),
              SizedBox(height: 20),
              builipref(),
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
                    MaterialPageRoute(builder: (context) => ViewMsg()));
                print("viewmsgFORUSER");
                break;

              case 2:
                print("req");
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => StatsScreen()));
                break;
            }
          },
        ),
      ),
    );
  }
}
