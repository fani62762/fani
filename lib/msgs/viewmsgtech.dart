import 'dart:convert';
import 'package:fani/profiles/edittech.dart';
import 'package:fani/profiles/TechSeeUser.dart';
import 'package:fani/profiles/fortech.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:http/http.dart' as http;
import 'package:fani/chat/chat_screen.dart';

var user;
var imagg = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');

class ViewMsgT extends StatefulWidget {
  @override
  _ViewMsgTState createState() => _ViewMsgTState();
}

class _ViewMsgTState extends State<ViewMsgT> {
  Widget builimg(String usen,int index) {
    return GestureDetector(
      onTap: () {
        if (index == Users.length - 1) {
                              
                                 
                              } else {
                                Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TsU(
                    userName: usen,
                  )),
        );
                              }
       
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 5.5,
        height: MediaQuery.of(context).size.height / 10.5,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: lb,
            width: 0.0,
          ),
          image: DecorationImage(
            image: imagg,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  List<dynamic> Users = [];

  Future<void> getAllusers() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/users/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        Users = data;
      });
      await getAdmin();
    } else {
      print('Error fetching Users data: ${response.statusCode}');
    }
  }

  Future<void> getAdmin() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/admin/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        Users.add(data);
      });
    } else {
      print('Error fetching Users data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getAllusers();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ForTech()));
            },
          ),
          title: Text(
            'الرسائل',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
          ),
          backgroundColor: lb,
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView.builder(
            itemCount: Users.length, // Replace with actual number of messages
            itemBuilder: (context, index) {
              user = Users[index];

              imagg = NetworkImage(user['image']);

              return GestureDetector(
                onTap: () async {
                  Color:
                  Colors.black;
                  user = Users[index];

                  print(index);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              senderName: ne,
                              receverName: Users[index]['name'],
                            )),
                  );
                },
                child: Dismissible(
                  key: ValueKey(index),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    // TODO: Handle delete action
                  },
                  background: Container(
                    alignment: AlignmentDirectional.centerEnd,
                    color: Colors.white10,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        builimg(Users[index]['name'],index),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user['name'],
                                style: TextStyle(
                                    color: Color(0xFF0FBCD4),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8.0),
                              if (index == Users.length - 1) ...{
                                Text(
                                  'تواصل مع المُدير',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.red),
                                ),
                              } else ...{
                                Text(
                                  'تواصل مع ${user['name']}',
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.grey),
                                ),
                              }
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
