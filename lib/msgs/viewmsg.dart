import 'dart:convert';
import 'package:fani/auth/user.dart';
import 'package:fani/chat/chat_screen.dart';
import 'package:fani/profiles/UserSeeTech.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:http/http.dart' as http;

int rt = 0;
List<dynamic> selecServ = [];
List<String> timeSelec = [];
var work;
var imag = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');

class ViewMsg extends StatefulWidget {
  @override
  _ViewMsgState createState() => _ViewMsgState();
}

class _ViewMsgState extends State<ViewMsg> {
  Future<void> getmyeWorker(String wName) async {
    final String url =
        'https://fani-service.onrender.com/servwork/2/?Wname=$wName';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      selecServ = jsonResponse;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Widget builimg(String workn) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => UsT(
                    workName: workn,
                  )),
        );
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
            image: imag,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  List<dynamic> workers = [];

  Future<void> getAllWorkers() async {
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/worker/'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        workers = data;
      });
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getAllWorkers();
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
                  context,
                  MaterialPageRoute(
                      builder: (context) => Userpage(
                            userName: nee,
                          )));
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
            itemCount: workers.length, // Replace with actual number of messages
            itemBuilder: (context, index) {
              work = workers[index];

              imag = NetworkImage(work['image']);

              return GestureDetector(
                onTap: () async {
                  Color:
                  Colors.black;
                  work = workers[index];
                  await getmyeWorker(work['name']);
                  print(index); // add this line to print the index

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              senderName: nee,
                              receverName: workers[index]['name'],
                            )),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      builimg(workers[index]['name']),
                      SizedBox(width: 8.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              work['name'],
                              style: TextStyle(
                                  color: Color(0xFF0FBCD4),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8.0),
                            Text(
                              '  تواصل مع ${work['name']}  ',
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.person_sharp),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UsT(workName: workers[index]['name'])),
                          );
                        },
                      ),
                    ],
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
