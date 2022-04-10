import 'package:flutter/material.dart';
import 'package:vimigo_technical_assessment/model/user.dart';
import '../widgets/display_image_widget.dart';

class DetailView extends StatefulWidget {
  final User userData;
  final String checkIn;
  const DetailView({Key? key, required this.userData, required this.checkIn})
      : super(key: key);

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact's Details"),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue, Colors.green],
              begin: Alignment.bottomRight,
              end: Alignment.topLeft,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const DisplayImage(
              imagePath: 'assets/pfp.jpg',
            ),
            buildUserInfoDisplay(widget.userData.name, 'Full Name'),
            buildUserInfoDisplay(widget.userData.phoneNumber, 'Phone Number'),
            buildUserInfoDisplay(widget.checkIn, 'Check-In')
          ],
        ),
      ),
    );
  }

  Widget buildUserInfoDisplay(String getValue, String title) => Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 1,
          ),
          Container(
              width: 350,
              height: 40,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: Colors.grey,
                width: 1,
              ))),
              child: Row(children: [
                Expanded(
                    child: Center(
                  child: Text(
                    getValue,
                    style: TextStyle(
                        fontSize: 16,
                        height: 1.4,
                        color: Colors.green.shade400),
                  ),
                )),
              ]))
        ],
      ));
}
