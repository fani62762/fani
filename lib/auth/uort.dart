import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fani/notifi/notifi_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:fani/auth/signup.dart';
import 'package:fani/auth/login.dart';
import 'package:http/http.dart' as http;

String? gen;
String? dat;

class Uort extends StatefulWidget {
  const Uort(
      {required this.nameup,
      required this.passup,
      required this.emailup,
      required this.phonenumberup,
      super.key});
  final String nameup;
  final String passup;
  final String emailup;
  final String phonenumberup;
  @override
  State<Uort> createState() => _UortState();
}

class _UortState extends State<Uort> {
  final _formKey1 = GlobalKey<FormState>();

  static const String signupUrl = 'https://fani-service.onrender.com/users';
  static const String signupUrlW = 'https://fani-service.onrender.com/worker';

  Future<void> createworker(String name, String email, String password,
      String phone, String gen, String dat) async {
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'gender': gen,
      'date': dat
    });
    final response = await http.post(
      Uri.parse(signupUrlW),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      name = name;
      final worker = jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<void> createUser(String name, String email, String password,
      String phone, String gen, String dat) async {
    print(name);
    final body = jsonEncode({
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'gender': gen,
      'date': dat
    });
    final response = await http.post(
      Uri.parse(signupUrl),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final user = jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  DateTime datatime = DateTime(2000);
  bool isSwtch = false;

  @override
  Widget build(BuildContext context) {
    Widget builarrow() {
      return Container(
        margin: EdgeInsets.fromLTRB(0, 40, 250, 0),
        child: IconButton(
          icon: Icon(
            Icons.arrow_forward,
            size: 25,
            color: Colors.black26,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
        ),
      );
    }

    Widget builgen() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: dy,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'هل أنت ',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: dy),
            ),
            SizedBox(height: 5),
            RadioListTile(
              title: Text(
                'ذكر',
                style: TextStyle(fontSize: 22, color: db),
              ),
              value: 'ذكر',
              groupValue: gen,
              onChanged: (value) {
                setState(() {
                  gen = value as String?;
                });
              },
              activeColor: db,
              secondary: gen == 'ذكر'
                  ? Icon(
                      Icons.male,
                      size: 28,
                      color: lb,
                    )
                  : null,
            ),
            RadioListTile(
              title: Text(
                'أنثى',
                style: TextStyle(fontSize: 22, color: db),
              ),
              value: 'أنثى',
              groupValue: gen,
              onChanged: (value) {
                setState(() {
                  gen = value as String?;
                });
              },
              activeColor: db,
              secondary: gen == 'أنثى'
                  ? Icon(
                      size: 28,
                      Icons.female,
                      color: lb,
                    )
                  : null,
            ),
          ],
        ),
      );
    }

    Widget builswitch() {
      return Container(
        margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "أنـا فَـنـي ",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: db,
              ),
            ),
            Switch(
              value: isSwtch,
              onChanged: (value) async {
                nameup = nameup;
                isSwtch = value;
                if (isSwtch) {
                  if (_formKey1.currentState!.validate()) {
                    if (gen == null) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.BOTTOMSLIDE,
                        desc: 'الرجاء اختيار الجنس ',
                      ).show();
                    } else if (dat == null) {
                      AwesomeDialog(
                        context: context,
                        dialogType: DialogType.info,
                        animType: AnimType.BOTTOMSLIDE,
                        desc: 'الرجاء اختيار تاريخ الميلاد ',
                      ).show();
                      isSwtch = false;
                    } else {
                      await createworker(
                          widget.nameup,
                          widget.emailup,
                          widget.passup,
                          widget.phonenumberup,
                          gen as String,
                          dat as String);

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => (Login())),
                      );
                      NotificationService().showNotification(
                          title: "    🖐   أهلاً  ${widget.nameup}",
                          body: "        قم بتسجيل الدخول الى حسابك 🔥 ");
                    }
                  }
                }
              },
              inactiveThumbColor: lb,
              activeTrackColor: ly,
              activeColor: dy,
            ),
          ],
        ),
      );
    }

    Widget buildate() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: dy,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.fromLTRB(20, 5, 20, 20),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'تاريخ ميلادك',
              style: TextStyle(
                  fontSize: 25, fontWeight: FontWeight.bold, color: dy),
            ),
            SizedBox(height: 10),
            Container(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: datatime,
                  minimumYear: 1900,
                  maximumYear: DateTime.now().year,
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime nt) {
                    setState(() {
                      datatime = nt;
                      dat =
                          "${datatime.year.toString()}-${datatime.month.toString()}-${datatime.day.toString()}";
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _formKey1,
            child: Column(children: [
              builarrow(),
              builgen(),
              buildate(),
              builswitch(),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formKey1.currentState!.validate()) {
                      if (gen == null) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.BOTTOMSLIDE,
                          desc: 'الرجاء اختيار الجنس ',
                        ).show();
                        // print("Gender err: ${gen.toString()}");
                      } else if (dat == null) {
                        AwesomeDialog(
                          context: context,
                          dialogType: DialogType.info,
                          animType: AnimType.BOTTOMSLIDE,
                          desc: 'الرجاء اختيار تاريخ الميلاد ',
                        ).show();
                      } else {
                        await createUser(
                            widget.nameup,
                            widget.emailup,
                            widget.passup,
                            widget.phonenumberup,
                            gen as String,
                            dat as String);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                        );
                        NotificationService().showNotification(
                            title: "    🖐   أهلاً  ${widget.nameup}",
                            body: "        قم بتسجيل الدخول الى حسابك 🔥 ");
                        setState(() {
                          nameup = nameup;
                        });
                      }
                      isSwtch = false;
                    }
                  },
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(db),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 7,
                          vertical: MediaQuery.of(context).size.height / 55),
                    ),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ]),
          ),
        ),
      ),
    );
  }
}
//