import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fani/auth/login.dart';
import 'package:fani/auth/uort.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';

bool isEmailValid(String email) {
  return EmailValidator.validate(email);
}

bool isValidPhoneNumber(String phoneNumber) {
  final regex = RegExp(r'^\d{10}$');
  return regex.hasMatch(phoneNumber);
}

String nameup = "";
String passup = "";
String emailup = "";
String phonenumberup = "";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

final TextEditingController cname = TextEditingController();
final TextEditingController cpass = TextEditingController();
final TextEditingController ccon = TextEditingController();
final TextEditingController cemail = TextEditingController();
final TextEditingController cmob = TextEditingController();

class _SignUpState extends State<SignUp> {
  Future<bool> fetchUserByName(String name) async {
    final response = await http
        .get(Uri.parse('https://fani-service.onrender.com/users/2/$name'));
    final responseW = await http
        .get(Uri.parse('https://fani-service.onrender.com/worker/2/$name'));
    if (response.statusCode == 200) {
      final user = jsonDecode(response.body);
      return (true);
    } else if (responseW.statusCode == 200) {
      final worker = jsonDecode(responseW.body);
      return (true);
    } else {
      print("not exsist");
      return (false);
    }
  }

  GlobalKey<FormState> formk = GlobalKey<FormState>();
  bool obscured = true;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 70, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Form(
                  key: formk,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: cname,
                        decoration: InputDecoration(
                          labelText: 'اسم المستخدم',
                          helperText: '',
                          prefixIcon: Icon(Icons.person, color: db),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء ادخال الإسم';
                          } else if (value.length < 2) {
                            return 'اسم المستخدم لا يمكن أن يكون أصغر من حرفين';
                          } else if (value.length > 20) {
                            return 'اسم المستخدم لا يمكن أن يكون أكبر من 20 حرف';
                          } else {
                            nameup = value;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: cpass,
                        decoration: InputDecoration(
                          labelText: 'كلمة المرور',
                          helperText: '',
                          prefixIcon: Icon(
                            Icons.lock,
                            color: db,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              obscured
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.black12,
                            ),
                            onPressed: () {
                              setState(() {
                                obscured = !obscured;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        obscureText: obscured,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال كلمة المرور';
                          } else if (value.length < 6) {
                            return 'كلمة المرور يجب أن تكون أكبر من 5';
                          } else {
                            passup = value;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: ccon,
                        decoration: InputDecoration(
                          labelText: 'تأكيد كلمة المرور',
                          helperText: '',
                          prefixIcon: Icon(Icons.lock, color: db),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value != cpass.text) {
                            return 'كلمات المرور غير متطابقات';
                          } else {
                            passup = cpass.text;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: cemail,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'الإيميل',
                          helperText: '',
                          prefixIcon: Icon(Icons.email, color: db),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال الإيميل';
                          } else if (!isEmailValid(value)) {
                            return ('الرجاء ادخال ايميل صحيح');
                          } else {
                            emailup = value;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: cmob,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'الهاتف',
                          helperText: '',
                          prefixIcon: Icon(Icons.phone, color: db),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخل رقم هاتفك';
                          } else if (!isValidPhoneNumber(value)) {
                            return ('الرجاء ادخال هاتف صحيح');
                          } else {
                            phonenumberup = value;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formk.currentState!.validate()) {
                              formk.currentState!.save();
                              bool isExist = await fetchUserByName(nameup);
                              if (isExist == true) {
                                AwesomeDialog(
                                  context: context,
                                  dialogType: DialogType.info,
                                  animType: AnimType.BOTTOMSLIDE,
                                  desc: 'صاحب هذا الاسم لديه حساب بالفعل ',
                                ).show();
                              } else {
                                print("sign $nameup");
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Uort(
                                            nameup: nameup,
                                            passup: passup,
                                            emailup: emailup,
                                            phonenumberup: phonenumberup,
                                          )),
                                );
                              }
                            }
                          },
                          child: Text(
                            'أكمل عملية التسجيل',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(dy),
                            padding: MaterialStateProperty.all(
                              EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width / 10,
                                  vertical:
                                      MediaQuery.of(context).size.height / 45),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.only(right: 0),
                  child: Row(
                    
                    children: [
                      Text(
                        "هل لديك بالفعل حساب مِن قبل ؟ ",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, color: db),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
                          );
                        },
                        child: Text(
                          "تسجيل دخول",
                          style:
                              TextStyle(fontWeight: FontWeight.bold, color: dy),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
