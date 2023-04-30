import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fani/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

@override
class _ForgetState extends State<Forget> {
  Widget builarrow() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 20, 250, 0),
      child: IconButton(
        icon: Icon(
          Icons.arrow_forward,
          size: 25,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Login()),
          );
        },
      ),
    );
  }

  Future<void> resetPassword(String name) async {
    print(name);
    final response = await http.post(
      Uri.parse(
          'https://fanii.onrender.com/users/forgot-password'), //108 for shahd 212 for fanan
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
      }),
    );
    final responseW = await http.post(
      Uri.parse(
          'https://fanii.onrender.com/worker/forgot-password'), //108 for shahd 212 for fanan
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
      }),
    );
    var data;
    if (response.statusCode == 200 || responseW.statusCode == 200) {
      if (response.statusCode == 200) {
        data = jsonDecode(response.body);
      } else {
        data = jsonDecode(responseW.body);
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('تم الإرسال '),
              content: Text(data['message']),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => Login()));
                  },
                  child: Text('تسجيل الدخول'),
                ),
              ],
            ),
          );
        },
      );
    } else if (response.statusCode == 404 || responseW.statusCode == 404) {
      if (response.statusCode == 404) {
        data = jsonDecode(response.body);
      } else {
        data = jsonDecode(responseW.body);
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('حدث خطأ  '),
              content: Text(data['message'].toString()),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('تم'),
                ),
              ],
            ),
          );
        },
      );
    } else {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.info,
        animType: AnimType.BOTTOMSLIDE,
        desc: 'حدث خظأ غير متوقع الرجاء المحاوله مرة أخرى',
      ).show();
    }
  }

  Widget buildEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "اسم المستخدم",
          style:
              TextStyle(color: db, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
              ]),
          height: 60,
          child: TextFormField(
            controller: cname2,
            // enabled: false,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(right: 14),
                hintText: 'اسم المستخدم',
                hintStyle: TextStyle(color: Colors.black38)),
            validator: (value) {
              setState(() {
                name = value!;
              });
            },
          ),
        )
      ],
    );
  }

  Widget buildForgotPass() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        'نسيت كلمة المرور',
        style: TextStyle(
            color: Colors.black, fontSize: 44, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget buildimg() {
    return SizedBox(
      child: Image.asset(
        'images/1.png',
        height: 280,
        width: 280,
      ),
    );
  }

  GlobalKey<FormState> ff = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: GestureDetector(
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 166, 199, 227),
                      Colors.white,
                      Color.fromARGB(255, 250, 240, 154),
                      Color.fromARGB(255, 255, 182, 74)
                    ],
                  )),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Form(
                          key: ff,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                builarrow(),
                                buildimg(),
                                buildForgotPass(),
                                SizedBox(height: 20),
                                buildEmail(),
                                Container(
                                  padding: EdgeInsets.symmetric(vertical: 25),
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (ff.currentState!.validate()) {
                                        ff.currentState!.save();
                                        resetPassword(name);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      elevation: 5,
                                      padding: EdgeInsets.all(15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      primary: db,
                                    ),
                                    child: Text(
                                      'ارسال كلمة سر جديدة ',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),

                    ///
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
