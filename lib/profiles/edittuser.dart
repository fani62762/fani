import 'dart:convert';
import 'package:fani/main.dart';
import 'package:fani/profiles/foruser.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fani/auth/user.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fani/location/locu.dart';
import 'package:path/path.dart';

class editUser extends StatefulWidget {
  const editUser({required this.UserName, super.key});
  @override
  final String UserName;
  State<editUser> createState() => _editUserState();
}

File? imageFile;

class _editUserState extends State<editUser> {
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
        imagg = NetworkImage(userr['image']);
      });
    } else {
      print('uur: ${responseU.statusCode}');
      print("not exsist");
    }
  }

  final formkkk = GlobalKey<FormState>();
  void initState() {
    super.initState();
    userInfo(nee);
  }

  bool obscurede = true;
  @override
  Widget build(BuildContext context) {
    Future<void> uploadImagemongo(String image, String name) async {
      final body = jsonEncode({
        'image': image,
      });
      final response = await http.put(
        Uri.parse('https://fani-service.onrender.com/users/1/$name'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );
      if (response.statusCode == 200) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => editUser(
                      UserName: name,
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
          uploadImagemongo(imageUrl, nee);
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

    Future<void> updateUser(String name, String password, String email,
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
        Uri.parse('https://fani-service.onrender.com/users/2/$name'),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      if (response.statusCode == 200) {
        print('User updated successfully');
      } else {
        print('Failed to update User');
      }
    }

    Widget builedittinfo() {
      return Column(children: <Widget>[
        SizedBox(height: 15.0),
        TextField(
          controller: emmCon,
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
          controller: pssCon,
          obscureText: obscurede,
          decoration: InputDecoration(
            hintText: "كلمة المرور",
            hintStyle: TextStyle(
              color: dy,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscurede ? Icons.visibility_off : Icons.visibility,
                color: Colors.black12,
              ),
              onPressed: () {
                setState(() {
                  obscurede = !obscurede;
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
          controller: mobbC,
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
          controller: gnnCon,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "نوع المستخدم",
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
          controller: addrrcon,
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
        TextField(
          controller: dttCon,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "تاريخ الميلاد ",
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
        ElevatedButton(
          onPressed: () async {
            await updateUser(
              naaCon.text.toString(),
              pssCon.text.toString(),
              emmCon.text.toString(),
              gnnCon.text.toString(),
              mobbC.text.toString(),
              dttCon.text.toString(),
              addrrcon.text.toString(),
            );

            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => editUser(
                          UserName: nee,
                        )));
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

    Widget buildprofimg() {
      return Container(
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2.5,
              height: MediaQuery.of(context).size.height / 4.5,
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
      );
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ForUser()));
            },
          ),
          title: Text(
            'تعديل صفحتي الشخصية',
            style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
          ),
          backgroundColor: dy,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.0),
                buildprofimg(),
                SizedBox(height: 20),
                Text(
                  nee,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 40.0),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        enabled: false,
                        readOnly: true,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          labelText: addrr,
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
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LocU(LocUName: widget.UserName)));
                      },
                      icon: Icon(Icons.location_on),
                      color: lb,
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                builedittinfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
