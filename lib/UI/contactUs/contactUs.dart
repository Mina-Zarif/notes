import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
 // import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Open Mailer"),
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        alignment: Alignment.topCenter,
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {

                },
                child: Text("Mail Us Now"))
          ],
        ),
      ),
    );
  }
}
