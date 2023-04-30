import 'dart:convert';
import 'package:fani/auth/login.dart';
import 'package:fani/auth/signup.dart';
import 'package:fani/notifi/notifi_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

int t = 0;

final Color db = Color(0xFF488FCD); //Dark blue
final Color dy = Color(0xFFF8981D); //Dark yallow
final Color ly = Color(0xFFFFCC111); //light yallow
final Color lb = Color(0xFFF0FBCD4); //light blue
final List<String> servicesList = [];
final List<bool> hmf = [];
bool islogin = false;

List<dynamic> types = [];
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.blue,
            errorColor: dy,
          ),
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> getAlltype() async {
    servicesList.clear();
    final response =
        await http.get(Uri.parse('https://fanii.onrender.com/type/3'));
    print(response);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      types = data;

      for (int i = 0; i < types.length; i++) {
        servicesList.add(types[i]['type']);
        hmf.add(types[i]['hm']);
      }
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    getAlltype();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildLoginBtn() {
      return SizedBox(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: Text(
            'تـسـجـيـل دخـول',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(db),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5,
                  vertical: MediaQuery.of(context).size.height / 45),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      );
    }

    Widget buildSigninBtn() {
      return SizedBox(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUp()),
            );
          },
          child: Text(
            'إنـشـاء حـسـاب',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(lb),
            padding: MaterialStateProperty.all(
              EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5,
                  vertical: MediaQuery.of(context).size.height / 45),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ),
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 166, 199, 227),
                Colors.white,
                Color.fromARGB(255, 250, 240, 154),
                ly
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    child: Image.asset('images/1.png'),
                  ),
                ],
              ),
              SizedBox(height: 40),
              buildLoginBtn(),
              SizedBox(height: 20),
              buildSigninBtn(),
            ],
          ),
        ),
      ),
    );
  }
}
