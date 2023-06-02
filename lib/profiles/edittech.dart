import 'dart:convert';
import 'package:fani/main.dart';
import 'package:fani/notifi/notifi_service.dart';
import 'package:fani/profiles/fortech.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:fani/location/loc.dart';

String tname = "";
var ge,dt;
List<dynamic> servwork = [];
List<dynamic> selecServv = [];
List<String> timeSelecc = [];
final picker = ImagePicker();
var imag = NetworkImage(
    'https://firebasestorage.googleapis.com/v0/b/fani-2.appspot.com/o/imagesprofiles%2Fuser.png?alt=media&token=30236ccb-7cb1-44f9-b200-4dc2a661c2a5');
File? imageFile;

class editTech extends StatefulWidget {
  const editTech({required this.techName, super.key});
  @override
  final String techName;
  State<editTech> createState() => _editTechState();
}

String ne = "";
String em = "";
String ps = "";
String pn = "";
String pt = "";
String bio = "";
String addr = "";
int rt = 0;
DateTime ?selectedDate;

List<String> selecServ = [];
List<String> timeSelec = [];

TextEditingController priceCont = TextEditingController();
TextEditingController bioController = TextEditingController();
TextEditingController naCon = TextEditingController();
TextEditingController emCon = TextEditingController();
TextEditingController psCon = TextEditingController();
TextEditingController mobC = TextEditingController();
// TextEditingController gnCon = TextEditingController();
TextEditingController dtCon = TextEditingController();
TextEditingController addrcon = TextEditingController();

class _editTechState extends State<editTech> {
  Future<void> getalls(String name) async {
    final response = await http.get(
        Uri.parse('https://fani-service.onrender.com/servwork/4/?Wname=$name'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        servwork = data;
      });
      // print(servwork);
    } else {
      print('Error fetching workers data: ${response.statusCode}');
    }
  }
  Future<void> updateWorker(String name, String password, String email,
      String gender, String phone, String date, String address) async {
    final body = jsonEncode({
      'password': password,
      'email': email,
      'gender': gender,
      'phone': phone,
      'date': date,
      'address': address
    });

    final response = await http.put(
      Uri.parse('https://fani-service.onrender.com/worker/2/$name'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
    } else {
      print('Failed to update worker');
    }
  }
  Future<void> updateWorkerbio(String name, String bio) async {
    final body = jsonEncode({
      'bio': bio,
    });
    final response = await http.put(
      Uri.parse('https://fani-service.onrender.com/worker/4/$name'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
    } else {
      print('Failed to update worker bio');
    }
  }
  Future<void> _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    // You can customize the date picker appearance and behavior further if needed
  );
  if (picked != null && picked != selectedDate) {
    setState(() {
      selectedDate = picked;
        dt =
                          "${picked.year.toString()}-${picked.month.toString()}-${picked.day.toString()}";
                           dtCon = TextEditingController(text:"${picked.year.toString()}-${picked.month.toString()}-${picked.day.toString()}");
    });
  }
}

  bool obscuredw = true;
  Widget builedittinfo(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 15.0),
      TextField(
        controller: emCon,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: "ايميل المستخدم",
          hintStyle: TextStyle(
            color: dy,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: db,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: dy,
            ),
          ),
        ),
      ),
      SizedBox(height: 15.0),
      TextField(
        controller: psCon,
        obscureText: obscuredw,
        decoration: InputDecoration(
          hintText: "كلمة المرور",
          hintStyle: TextStyle(
            color: dy,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              obscuredw ? Icons.visibility_off : Icons.visibility,
              color: Colors.black12,
            ),
            onPressed: () {
              setState(() {
                obscuredw = !obscuredw;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: db,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: dy,
            ),
          ),
        ),
      ),
      SizedBox(height: 15.0),
      TextField(
        controller: mobC,
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          hintText: "رقم الهاتف",
          hintStyle: TextStyle(
            color: dy,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: db,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: dy,
            ),
          ),
        ),
      ),
      SizedBox(height: 15.0),
      TextField(
        controller: addrcon,
        decoration: InputDecoration(
          hintText: "الموقع",
          hintStyle: TextStyle(
            color: dy,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: db,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: dy,
            ),
          ),
        ),
      ),
      SizedBox(height: 15.0),
      GestureDetector(
  onTap: () {
    _selectDate(context);
  },
  child: AbsorbPointer(
    child: TextField(
      controller: dtCon,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "تاريخ الميلاد",
        hintStyle: TextStyle(
          color: dy,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: db,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: dy,
          ),
        ),
      ),
    ),
  ),
),
      SizedBox(height: 15.0),
      DropdownButtonFormField<String>(
         value: ge,
         decoration: InputDecoration(
           labelText: 'اختر الجنس',
           icon: Icon(Icons.person),
         ),
         items: [
           DropdownMenuItem<String>(
             value: 'ذكر',
             child: Center(child: Text('ذكر')),
           ),
           DropdownMenuItem<String>(
             value: 'أنثى',
             child: Center(child: Text('أنثى')),
           ),
         ],
         onChanged: (value) {
           setState(() {
             ge = value;
           });
         },
       ), 
      SizedBox(height: 15.0),
      ElevatedButton(
        onPressed: () async {
          await updateWorker(
            naCon.text.toString(),
            psCon.text.toString(),
            emCon.text.toString(),
            ge as String,
            mobC.text.toString(),
            // dtCon.text.toString(),
            dt as String,
            addrcon.text.toString(),
          );
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      editTech(techName: naCon.text.toString())));
        },
        child: Text(
          'تعديل المعلومات الشخصية',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        style: ElevatedButton.styleFrom(
          primary: lb,
        ),
      ),
    ]);
  }

  Future<void> getmyeWorker(String wName) async {
    priceCont = TextEditingController(text: "");
    final String url =
        'https://fani-service.onrender.com/servwork/2/?Wname=$wName';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> selecServ = jsonResponse;

      for (int i = 0; i < selecServ.length; i++) {
        _onServiceSelected(selecServ[i]);
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    if (selecServ.length == 0) {
      NotificationService().showNotification(
          title: "    🖐   أهلاً  ${widget.techName}",
          body: "    قم بتحديد جدول أعمالك  🔥 ");
    }
  }

  Future<void> createservworker(
      String TypeServ, String Wname, String Price, List Hours) async {
    final body = jsonEncode(
        {"TypeServ": TypeServ, "Wname": Wname, "Price": Price, "Hours": Hours});
    final response = await http.post(
      Uri.parse('https://fani-service.onrender.com/servwork'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );
    if (response.statusCode == 200) {
      final servwork = jsonDecode(response.body);
    } else {
      print('Error: ${response.statusCode}');
    }
  }
 void req()async{
  FirebaseMessaging messaging=FirebaseMessaging.instance;
  NotificationSettings settings=await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,

  );
  if(settings.authorizationStatus==AuthorizationStatus.authorized) {print("user perm");}
  else{print ("no");}

FirebaseMessaging.onMessage.listen((message) {
  // print(message.notification?.body);
  if (message.data['name'] == widget.techName) {
    // print(widget.techName);
    // print(message.data['name']);
      NotificationService().showNotification(
          title: message.notification?.title,
          body: message.notification?.body);
   }
});

///back
FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  print("go back");
});
}
 
  Future<void> deleteServworker(String TypeServ, String Wname) async {
    final body = jsonEncode({"TypeServ": TypeServ, "Wname": Wname});
    final response = await http.delete(
      Uri.parse('https://fani-service.onrender.com/servwork'),
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      final servwork = jsonDecode(response.body);
    } else {
      print('Error deleting servwork: ${response.statusCode}');
    }
  }

  Future<void> getServiceWorker(String typeServ, String wName) async {
    priceCont = TextEditingController(text: "");
    final Uri uri = Uri.parse(
        'https://fani-service.onrender.com/servwork/1/?TypeServ=$typeServ&Wname=$wName');
    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      final Map<String, dynamic> serviceWorker = jsonDecode(response.body);
      setState(() {
        List<dynamic> timeSelec = serviceWorker['Hours'];
        priceCont = TextEditingController(text: serviceWorker['Price']);
        for (int i = 0; i < timeSelec.length; i++) {
          _onTimeSelected(timeSelec[i]);
        }
      });
    } else {
      print('Failed to load service worker');
    }
  }

  Future<void> workerInfo(String name) async {
    final responseW = await http
        .get(Uri.parse('https://fani-service.onrender.com/worker/2/$name'));
    if (responseW.statusCode == 200) {
      final worker = jsonDecode(responseW.body);
      setState(() {
        naCon = TextEditingController(text: worker['name']);
        emCon = TextEditingController(text: worker['email']);
        mobC = TextEditingController(text: worker['phone']);
        psCon = TextEditingController(text: worker['password']);
        // gnCon = TextEditingController(text: worker['gender']);
        dtCon = TextEditingController(text: worker['date']);
        bioController = TextEditingController(text: worker['bio']);
        addrcon = TextEditingController(text: worker['address']);
        ne = worker['name'];
        ge = worker['gender'];
        dt = worker['date'];
        em = worker['email'];
        ps = worker['password'];
        pn = worker['phone'];
        rt = worker['rating'];
        bio = worker['bio'];
        addr = worker['address'];
        imag = NetworkImage(worker['image']);
        tname = naCon.text.toString();
      });
    } else {
      print("not exsist");
    }
  }

  final formkk = GlobalKey<FormState>();

  List<String> _timeList = [
    '12-2',
    '10-12',
    '8-10',
    '4-6',
    '2-4',
  ];
  void showMyDialog(
      BuildContext context, String service, List timeSelec, String hint) {
    AwesomeDialog(
      context: context,
      dismissOnTouchOutside: false,
      dialogType: DialogType.noHeader,
      animType: AnimType.BOTTOMSLIDE,
      title: 'مُنظف',
      desc: 'يرجى اختيار معلومات الخدمة:',
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 15, 0),
            child: Form(
              key: formkk,
              child: Column(
                children: [
                  TextFormField(
                    controller: priceCont,
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      suffixIcon: Icon(
                        Icons.attach_money,
                        size: 20,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'يرجى إدخال السعر ';
                      }
                      if (timeSelec.isEmpty) {
                        return 'يرجى اختيار وقت العمل ';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "ساعات العمل",
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Wrap(
                        spacing: 17.0,
                        alignment: WrapAlignment.center,
                        children: _timeList.map((t) {
                          return FilterChip(
                            label: Text(t),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                            backgroundColor: Color.fromARGB(227, 233, 232, 232),
                            selected: timeSelec.contains(t),
                            onSelected: (selected) {
                              setState(() {
                                _onTimeSelected(t);
                              });
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (formkk.currentState!.validate() &&
                              timeSelec.isNotEmpty) {
                            formkk.currentState!.save();

                            _onServiceSelected(service);
                            await deleteServworker(service, ne);

                            await createservworker(
                                service, ne, priceCont.text, timeSelec);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => editTech(
                                          techName: ne,
                                        )));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          primary: db,
                        ),
                        child: Text(
                          ' تـأكـيـد',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          await deleteServworker(service, ne);
                          setState(() {
                            selecServ.remove(service);
                            timeSelec.clear();
                            priceCont = TextEditingController(text: "");
                          });

                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 2,
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          primary: dy,
                        ),
                        child: Text(
                          "حذف المهنة",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ).show();
  }

  void _onServiceSelected(String service) {
    setState(() {
      if (selecServ.contains(service)) {
      } else {
        selecServ.add(service);
      }
    });
  }

  void _onTimeSelected(String time) {
    setState(() {
      if (timeSelec.contains(time)) {
        timeSelec.remove(time);
      } else {
        timeSelec.add(time);
      }
    });
  }

  Future<void> getAlltype() async {
    servicesList.clear();
    final response =
        await http.get(Uri.parse('https://fani-service.onrender.com/type/3'));
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

  void initState() {
     super.initState();
       req();
    selecServ.clear();
    timeSelec.clear();
    servwork.clear();
    getAlltype();
    workerInfo(widget.techName);
    getalls(widget.techName);
    getmyeWorker(widget.techName); 
  
  }

  @override
  Widget build(BuildContext context) {
    Future<void> uploadImagemongo(String image, String name) async {
      final body = jsonEncode({
        'image': image,
      });
      final response = await http.put(
        Uri.parse('https://fani-service.onrender.com/worker/1/$name'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => editTech(
                      techName: name,
                    )));
      } else {
        print('Failed to update worker image');
      }
    }

    Future<void> uploadImage() async {
      if (imageFile != null && await imageFile!.exists()) {
        final fileName = basename(imageFile!.path);
        final ref =
            FirebaseStorage.instance.ref().child('imagesprofiles/$fileName');
        final uploadTask = ref.putFile(imageFile!);
        await uploadTask.whenComplete(() async {
          final imageUrl = await ref.getDownloadURL();
          uploadImagemongo(imageUrl, ne);
          print('Image uploaded successfully: $imageUrl');
        });
      } else {
        print('Invalid image file path');
      }
    }

    Future<void> getImage() async {
      ImagePicker picker = ImagePicker();

      await picker.pickImage(source: ImageSource.gallery).then((xFile) {
        if (xFile != null) {
          setState(() {
            imageFile = File(xFile.path);
          });
          print(imageFile);
          uploadImage();
        }
      });
    }

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
            'تعديل صفحتي الشخصية',
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
          ),
          backgroundColor: dy,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ForTech())); // add here logout function
              },
              icon: Icon(Icons.person),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                Container(
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
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
                            image: imag,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width / 6.5,
                          height: MediaQuery.of(context).size.height / 14.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: dy,
                          ),
                          child: IconButton(
                            onPressed: getImage,
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  'الفني $ne',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        maxLines: 2,
                        controller: bioController,
                        decoration: InputDecoration(
                          hintText: "السيرة الذاتية",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black45,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () async {
                        await updateWorkerbio(
                            widget.techName, bioController.text.toString());
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    editTech(techName: naCon.text.toString())));
                      },
                      icon: Icon(
                        Icons.done_outlined,
                        size: 30,
                      ),
                      color: lb,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        enabled: false,
                        readOnly: true,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          labelText: addr,
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide(
                              color: Colors.black45,
                              width: 1.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    IconButton(
                      onPressed: () {
                        // loccc functionality for the icon button here
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Loc(locName: widget.techName)));
                      },
                      icon: Icon(Icons.location_on),
                      color: lb,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black45,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ' اختر المهن التي تعمل بها :  ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: lb),
                      ),
                      SizedBox(height: 15.0),
                      Wrap(
                        spacing: 15.0,
                        alignment: WrapAlignment.center,
                        children: servicesList.map((service) {
                          return FilterChip(
                            label: Text(service),
                            labelStyle: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                            backgroundColor: Color.fromARGB(227, 233, 232, 232),
                            selected: selecServ.contains(service),
                            onSelected: (selected) async {
                              await getServiceWorker(service, widget.techName);
                              if (hmf[servicesList.indexOf(service)] == false ||
                                  hmf[servicesList.indexOf(service)] == null) {
                                pt = "سعر الساعة";
                              } else {
                                pt = "سعر المتر";
                              }
                              showMyDialog(context, service, timeSelec, pt);
                              _onServiceSelected(service);
                            },
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 15.0),
                builedittinfo(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
