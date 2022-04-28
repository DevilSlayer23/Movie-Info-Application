// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
 NavBar({Key? key}) : super(key: key);

  final String? _email = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
          child: Text(_email ?? "Guest",
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  shadows: const [
                    Shadow(
                      color: Colors.black,
                      blurRadius: 20,
                      offset: Offset(0, 0),
                    )
                  ])),
          decoration: BoxDecoration(
              color: Colors.greenAccent,
              image: DecorationImage(
                image: AssetImage('assets/images/cover.jpg'),
                fit: BoxFit.fill,
              )),
        ),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Home'),
          onTap: () => {Navigator.pushNamed(context, 'homeScreen')},
        ),
        // ListTile(
        //   leading: Icon(Icons.tv_outlined),
        //   title: Text('TV Shows'),
        //   onTap: () => {Navigator.pushNamed(context, 'tvScreen')},
        // ),
        FirebaseAuth.instance.currentUser == null ?
        ListTile(
          leading: Icon(Icons.login_outlined),
          title: Text('Login'),
          onTap: () => {
            FirebaseAuth.instance
                .signOut()
                .then((value) => Navigator.pushNamed(context, 'loginScreen'))
          },
        )
        :
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: () => {
            FirebaseAuth.instance.signOut().then((value) =>
            Navigator.pushNamed(context, 'homeScreen'))
            },
        ),
         
      ],
    ));
  }
}
