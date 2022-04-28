// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:movie_app/screens/tvshow_sceen.dart';

import '../widgets/NavBar.dart';
import 'movie_page.dart';
import 'profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  final PageController _pageController = PageController();


  int selectedIndex = 0;
 
  final tabs = [
    MoviePage(),
    TvShowPage(),
  ];
  
  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                  iconSize: 10,
                  padding: const EdgeInsets.only(left: 20),
                  icon: Image.asset('assets/Icons/menu1.png'),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  });
            },
          ),
          actions: <Widget>[
            IconButton(
              iconSize: 30,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              icon: Image.asset('assets/Icons/profile.png',),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ],
          title: Text(
            'Movies'.toUpperCase(),
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        body: tabs[selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.orange.shade400,
          currentIndex: selectedIndex,
          onTap: (index) => setState(() {
            selectedIndex = index;
          }),
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.movie_creation_outlined),
              label: 'Movies',
            ),
            // const BottomNavigationBarItem(
            //   icon: Icon(Icons.tv_outlined, size: 28),
            //   label: 'TV Series',
            // ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.live_tv_outlined),
              label: 'Tv Shows',
            ),
          ],
        ),
      );

}