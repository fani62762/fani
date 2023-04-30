import 'package:flutter/material.dart';
import 'package:fani/notifi/notifi_service.dart';

class Noti extends StatefulWidget {
  const Noti({super.key, required this.title});

  final String title;

  @override
  State<Noti> createState() => _NotiState();
}

class _NotiState extends State<Noti> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Show notifications'),
        onPressed: () {
          NotificationService()
              .showNotification(title: "try title ", body: "🚴‍♂️ م ");
        },
      )),
    );
  }
}
