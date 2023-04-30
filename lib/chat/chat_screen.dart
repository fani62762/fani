import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fani/main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({required this.senderName, required this.receverName, key})
      : super(key: key);
  final String senderName;
  final String receverName;

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final _firestore = FirebaseFirestore.instance;
final _fires = FirebaseStorage.instance;
final mscont = TextEditingController();
File? imageFile;
String? imageUrl;
String? messageText;
void messagesStream() async {
  await for (var snapshot in _firestore.collection('messages').snapshots()) {
    for (var msg in snapshot.docs) {
      print(msg.data());
    }
  }
}

class _ChatScreenState extends State<ChatScreen> {
  Future<void> getImage() async {
    ImagePicker picker = ImagePicker();

    await picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        setState(() {
          imageFile = File(xFile.path);
        });
        uploadImage();
      }
    });
  }

  Future<void> uploadImage() async {
    String ReceiverSender;
    if (widget.senderName.compareTo(widget.receverName) < 0) {
      ReceiverSender = widget.senderName + widget.receverName;
    } else {
      ReceiverSender = widget.receverName + widget.senderName;
    }
    if (imageFile != null && await imageFile!.exists()) {
      final fileName = basename(imageFile!.path);
      final ref = _fires.ref().child('images/$fileName');
      final uploadTask = ref.putFile(imageFile!);
      await uploadTask.whenComplete(() async {
        final imageUrl = await ref.getDownloadURL();
        print('Image uploaded successfully: $imageUrl');

        _firestore.collection('messages').add({
          'text': '',
          'sender': widget.senderName,
          'senderreceiver': ReceiverSender,
          'time': FieldValue.serverTimestamp(),
          'imageUrl': imageUrl
        });
      });
    } else {
      print('Invalid image file path');
    }
  }

  void onSendMessage() {
    String ReceiverSender;
    if (widget.senderName.compareTo(widget.receverName) < 0) {
      ReceiverSender = widget.senderName + widget.receverName;
    } else {
      ReceiverSender = widget.receverName + widget.senderName;
    }

    if (messageText != null && messageText!.isNotEmpty) {
      mscont.clear();
      _firestore.collection('messages').add({
        'text': messageText,
        'sender': widget.senderName,
        'senderreceiver': ReceiverSender,
        'time': FieldValue.serverTimestamp(),
        'imageUrl': ''
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: dy,
          title: Row(
            children: [
              SizedBox(width: 20),
              Image.asset('images/logo2.png', height: 25),
              SizedBox(width: 20),
              Text('${widget.receverName}'),
              SizedBox(width: 10),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                // add here logout function
              },
              icon: Icon(Icons.close),
            ),
          ],
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MessageStream(
                senderName: widget.senderName,
                receverName: widget.receverName,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.orange,
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: mscont,
                        onChanged: (value) {
                          setState(() {
                            messageText = value;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 20,
                          ),
                          hintText: 'اكتب رسالتك هنا',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                        icon: Icon(Icons.send), onPressed: onSendMessage),
                    IconButton(icon: Icon(Icons.photo), onPressed: getImage),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageLine extends StatelessWidget {
  const MessageLine({
    this.sender,
    this.text,
    this.imageUrl,
    this.ismy,
    Key? key,
  }) : super(key: key);

  final String? sender;
  final String? text;
  final String? imageUrl;
  final bool? ismy;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment:
            ismy! ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          if (imageUrl != null && imageUrl != '')
            Stack(
              alignment: ismy! ? Alignment.centerRight : Alignment.centerLeft,
              children: [
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: ismy!
                        ? BorderRadius.only(
                            topLeft: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          )
                        : BorderRadius.only(
                            topRight: Radius.circular(30),
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: BoxFit.cover,
                    ),
                    border: Border.all(
                      color: ismy!
                          ? lb
                          : Color.fromARGB(
                              136, 0, 0, 0), // set the border color
                      width: 2, // set the border width
                    ),
                  ),
                ),
              ],
            ),
          if (text != null && text != '')
            Material(
              elevation: 5,
              borderRadius: ismy!
                  ? BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    )
                  : BorderRadius.only(
                      topRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
              color: ismy! ? lb : Colors.white54,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text(
                  '$text',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({
    Key? key,
    required this.senderName,
    required this.receverName,
  }) : super(key: key);

  final String senderName;
  final String receverName;

  @override
  Widget build(BuildContext context) {
    String ReceiverSender;
    if (senderName.compareTo(receverName) < 0) {
      ReceiverSender = senderName + receverName;
    } else {
      ReceiverSender = receverName + senderName;
    }
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('messages')
          .where('senderreceiver', isEqualTo: ReceiverSender)
          .orderBy('time')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
              //child: CircularProgressIndicator(),
              );
        }
        final messages = snapshot.data!.docs.reversed.toList();
        final messageLines = messages.map((msg) {
          final sender = msg.get('sender');
          final imm = msg.get('imageUrl');
          final text = msg.get('text');
          return MessageLine(
            sender: sender,
            text: text,
            imageUrl: imm,
            ismy: sender == senderName,
          );
        }).toList();

        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageLines,
          ),
        );
      },
    );
  }
}
