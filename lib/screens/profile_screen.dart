// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String? _uid = FirebaseAuth.instance.currentUser?.uid;

  String email = 'guest@guest.com';
  String name = 'Guest';

  final CollectionReference _collectionRef =
      FirebaseFirestore.instance.collection('users');

  Future<void> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    final userData = allData.cast<dynamic>();
    for (var item in userData) {
      if (_uid == item['uid'] && mounted) {
        setState(() {
          name = item['username'];
          email = item['email'];
        });
      }
    }

    //   for (var item in allData) {
    //     if (item['uid'] == _uid) {
    //       name = item['username'];
    //       print(item['uid']);
    //     } else {
    //       name = "Guest";
    //     }
    //   }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        color: Colors.white,
        alignment: Alignment.topCenter,
        child: Container(
          margin: EdgeInsets.all(20),
          // alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * 0.7,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.height * 0.2,
              decoration: BoxDecoration(
                  // borderRadius: BorderRadius.circular(100),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/vector.jpg'),
                    fit: BoxFit.fitHeight,
                  )),
            ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Username: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Email: ",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
