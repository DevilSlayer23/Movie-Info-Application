// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/upcoming_carousel.dart';
import '../widgets/popular_movies.dart';
import '../widgets/top_movies.dart';
import '../widgets/genre.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage>
    with AutomaticKeepAliveClientMixin<MoviePage> {
  Future<bool?> _onBackPressed() async {
    showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: Text('Warning'),
        content: Text('Do you really want to exit'),
        actions: [
          GestureDetector(
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text('Yes')), 
                onTap: () => SystemNavigator.pop(),
                ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(10), 
              child: Text('No')),
            onTap: () => Navigator.pop(context, false),
          ),
        ],
      ),
    );
    return null;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GenreWidget(),
                UpcomingMovieSlider(),
                Center(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.orange.shade400,
                          width: 2.0, // Underline thickness
                        ))),
                        child: Text(
                          "Popular Movies",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                PopularMovie(),
                Center(
                    child: Container(
                        margin: EdgeInsets.all(10),
                        padding: EdgeInsets.only(bottom: 3),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                          color: Colors.orange.shade400,
                          width: 2.0, // Underline thickness
                        ))),
                        child: Text(
                          "Top Movies",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ))),
                TopMovie(),
              ],
            ),
          ),
        ),
        onWillPop: () async {
          bool? result = await _onBackPressed();
          result ??= false;
          return result;
        });
  }
}
