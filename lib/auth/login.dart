import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fani/auth/forget.dart';
import 'package:fani/auth/signup.dart';
import 'package:fani/auth/user.dart';
import 'package:fani/profiles/edittech.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

String name = "";
String pass = "";

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class serv {
  final String name;
  final String type;
  serv({
    this.name = "",
    this.type = "",
  });

  factory serv.fromJson(Map<String, dynamic> json) {
    return serv(
      name: json['name'],
      type: json['type'],
    );
  }
  @override
  String toString() {
    return 'service{name: $name, type: $type}';
  }
}

GlobalKey<FormState> formkk = GlobalKey<FormState>();
final TextEditingController cname2 = TextEditingController();
final TextEditingController cpass2 = TextEditingController();

class _LoginState extends State<Login> {
  Future<void> submitCredentials(String name, String password) async {
    final response = await http.post(
      Uri.parse('https://fani-service.onrender.com/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
        'Token': await FirebaseMessaging.instance.getToken(),
      }),
    );

    final responseW = await http.post(
      Uri.parse('https://fani-service.onrender.com/worker/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'password': password,
        'Token': await FirebaseMessaging.instance.getToken(),
      }),
    );

    if (response.statusCode == 200 || responseW.statusCode == 200) {
      name = name;

      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Userpage(
                      userName: name,
                    )));
      } else {
        if (formkk.currentState!.validate()) {
          formkk.currentState!.save();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => editTech(
                        techName: name,
                      )));
        }
      }
    } else if (response.statusCode == 401 || responseW.statusCode == 410) {
      final message = jsonDecode(response.body)['message'];
      final messagee = jsonDecode(responseW.body)['message'];
      if (message == 'Invalid nameU' && messagee == 'Invalid nameW') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.BOTTOMSLIDE,
          desc: 'الاسم غير مسجل قم بانشاء حساب',
        ).show();
      } else if (message == 'Invalid passwordU' ||
          messagee == 'Invalid passwordW') {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.BOTTOMSLIDE,
          desc: ' كلمة المرور خاطئة',
        ).show();
      } else {
        AwesomeDialog(
          context: context,
          dialogType: DialogType.info,
          animType: AnimType.BOTTOMSLIDE,
          desc: 'حدث خظأ غير متوقع الرجاء المحاوله مرة أخرى',
        ).show();
      }
    }
  }

  bool falg = true;
  var isRememberMe = false;
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
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.person, color: dy),
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

  Widget buildPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'كلمة المرور',
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
            controller: cpass2,
            obscureText: true,
            style: TextStyle(color: Colors.black87),
            decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14),
                prefixIcon: Icon(Icons.lock, color: dy),
                hintText: 'كلمة المرور',
                hintStyle: TextStyle(color: Colors.black38)),
          ),
        )
      ],
    );
  }

  Widget buildForgotPassBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          formkk.currentState!.save();
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Forget()));
          print("نسيت كلمة المرور");
        },
        child: Text(
          'نسيت كلمة المرور',
          style: TextStyle(color: db, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          if (formkk.currentState!.validate()) {
            formkk.currentState!.save();
            submitCredentials(cname2.text.toString(), cpass2.text.toString());
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
          'تسجيل دخول',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildSignUpBtn() {
    return GestureDetector(
      onTap: () {
        formkk.currentState!.save();
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignUp()));
      },
      child: RichText(
        text: TextSpan(children: [
          TextSpan(
              text: ' ليس لديك حساب؟',
              style: TextStyle(
                  color: db, fontSize: 18, fontWeight: FontWeight.w500)),
          TextSpan(text: "  "),
          TextSpan(
              text: 'إنشاء حساب',
              style: TextStyle(
                  color: db, fontSize: 18, fontWeight: FontWeight.w500))
        ]),
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
                          key: formkk,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                buildimg(),
                                buildEmail(),
                                SizedBox(height: 20),
                                buildPassword(),
                              ]),
                        ),
                        SizedBox(height: 10),
                        buildForgotPassBtn(),
                        buildLoginBtn(),
                        buildSignUpBtn(),
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
