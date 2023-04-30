import 'package:fani/animation/FadeAnimation.dart';
import 'package:flutter/material.dart';
import 'package:fani/main.dart';
import 'package:fani/serv/globalserv.dart';
import 'package:fani/serv/date_time.dart';
import 'package:fani/serv/worker.dart';
import 'package:fani/auth/user.dart';
import 'dart:convert';
import 'package:http/http.dart' as http2;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:quickalert/quickalert.dart';

List<String> wHour = selectedHour;
String typef = typeofserv;
String hourtosend = '';
List<workserv> allworkers = workers;
String ordhour = "";
String ordwname = "";

class viewa extends StatefulWidget {
  const viewa({Key? key}) : super(key: key);

  @override
  _viewaState createState() => _viewaState();
}

Future<void> createord(
    BuildContext context,
    String uname,
    String wname,
    String Hour,
    String Price,
    String isrepeated,
    String date,
    List<String> add,
    List<String> serv,
    String type) async {
  final body = jsonEncode({
    'TypeServ': type,
    'Wname': wname,
    'uname': uname,
    'Price': Price,
    'Hour': Hour,
    'serv': serv,
    'date': date,
    'add': add,
    'isrepeated': isrepeated
  });
  final response = await http2.post(
    Uri.parse('https://fani-service.onrender.com/ord'),
    headers: {'Content-Type': 'application/json'},
    body: body,
  );
  if (response.statusCode == 200) {
    // name = name;
    final worker = jsonDecode(response.body);
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: 'تمت عملية الطلب بنجاح',
      autoCloseDuration: const Duration(seconds: 2),
    );
  } else {
    print('Error: ${response.statusCode}');
  }
}

class _viewaState extends State<viewa> {
  // List<Service> services = [
  //];
  bool isDes1 = false;
  bool isDes2 = false;
  bool ord = false;
  List<workserv> otherworkers = [];

  @override
  void initState() {
    wHour = selectedHour;
    hourtosend = '';
    print("hourtosend is" + hourtosend);
    print(wHour);
    typef = typeofserv;
    for (int i = 0; i < wHour.length - 1; i++) {
      hourtosend = hourtosend + wHour[i] + ";";
    }
    hourtosend = hourtosend + wHour[wHour.length - 1];
    print(hourtosend);
    allworkers = workers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => tech()),
              );
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          backgroundColor: lb,
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          FadeAnimation(
              1,
              Padding(
                padding: EdgeInsets.only(left: 20.0, top: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        TextButton.icon(
                          icon: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(Icons.compare_arrows, size: 28)),
                          label: Text(
                            isDes1 ? 'تنازلي ' : 'تصاعدي',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () => setState(() => isDes1 = !isDes1),
                        ),
                        TextButton.icon(
                          icon: RotatedBox(
                              quarterTurns: 1,
                              child: Icon(Icons.compare_arrows, size: 28)),
                          label: Text(
                            ord ? 'حسب السعر ' : 'حسب التقييم',
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () => setState(() => ord = !ord),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
          FadeAnimation(
              1.2,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade200,
                          offset: Offset(0, 4),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: allworkers.length,
                        itemBuilder: (BuildContext context, int index) {
                          ord
                              ? workers
                                  .sort((a, b) => a.Price.compareTo(b.Price))
                              : workers
                                  .sort((a, b) => a.rating.compareTo(b.rating));
                          allworkers =
                              isDes1 ? workers : workers.reversed.toList();
                          return InkResponse(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 20,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          workers.isEmpty
                                              ? Text(
                                                  "",
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              : Text(
                                                  allworkers[index]
                                                      .rating
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 20,
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(children: [
                                            workers.isEmpty
                                                ? Text(
                                                    "",
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Text(
                                                    allworkers[index].Wname,
                                                    style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                            PopupMenuButton(
                                              onSelected: (value) => setState(
                                                  () => ordhour =
                                                      value.toString()),
                                              itemBuilder: (context) =>
                                                  allworkers[index]
                                                      .mHour
                                                      .map((item) =>
                                                          PopupMenuItem<String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                            ),
                                                          ))
                                                      .toList(),
                                            ),
                                          ]),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            // child: Image.network(image)),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          workers.isEmpty
                                              ? Text(
                                                  "",
                                                  style:
                                                      TextStyle(fontSize: 15),
                                                )
                                              : Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      allworkers[index].Price,
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                  ],
                                                )
                                        ],
                                      )
                                    ]),
                                SizedBox(
                                  height: 40,
                                ),
                                Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: TextButton(
                                      style: TextButton.styleFrom(
                                          minimumSize:
                                              const Size.fromHeight(50)),
                                      child: Text(
                                        'حجز',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                      onPressed: () {
                                        ordhour == ""
                                            ? AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.info,
                                                animType: AnimType.BOTTOMSLIDE,
                                                desc:
                                                    'الرجاء اختيار ساعة من القائمة بجوار الاسم,',
                                              ).show()
                                            : {
                                                ordwname =
                                                    allworkers[index].Wname,
                                                ordprice =
                                                    allworkers[index].Price,
                                                showAlertDialog(context),
                                              };
                                      }),
                                ),
                              ],
                            ),
                          );
                        })),
              )),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 150,
          ),
        ])));
  }

  serviceContainer(String name, int index) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.only(right: 20),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          border: Border.all(
            color: Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.network(image, height: 45),
              SizedBox(
                height: 20,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 15),
              )
            ]),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: Text("اتمام"),
      onPressed: () {
        createord(context, orduname, ordwname, ordhour, ordprice, ordrepeated,
            orddate, ordadd, ordserv, ordtype);
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("تأكيد عملية الطلب"),
      content: Text("هل تريد اتمام عملية الطلب"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

//  workerContainer(String name, String job,String image,  double rating) {
  workerContainer(String name, String job, int rating) {
    return GestureDetector(
      child: AspectRatio(
        aspectRatio: 3.5,
        child: Container(
          margin: EdgeInsets.only(right: 20),
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.grey.shade200,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      rating.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Icon(
                      Icons.star,
                      color: Colors.orange,
                      size: 20,
                    )
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      job,
                      style: TextStyle(fontSize: 15),
                    )
                  ],
                ),
                SizedBox(
                  width: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(15.0),
                  // child: Image.network(image)),
                ),
              ]),
        ),
      ),
    );
  }
}
