// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../models/movies.dart';

class MovieDetails extends StatefulWidget {
  MovieDetails(this.movieData, {Key? key}) : super(key: key);
  Movies movieData;

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  // late List<Genre> genre;

  final String? _uid = FirebaseAuth.instance.currentUser?.uid;
  bool favorite = false;
  double rating = 1;
  late int movieId;

  @override
  void initState() {
    super.initState();
    movieId = widget.movieData.id;
    getData();
  }

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
          item['favorite'].forEach((k, v) {
            if (movieId.toString() == k) {
              favorite = v ?? false;
            }
            item['rating'].forEach((k, v) {
              if (movieId.toString() == k) {
                rating = double.parse(v);
              }
            });
          });
        });
      }
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          // height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
                            widget.movieData.posterPath),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Rate: ',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SmoothStarRating(
                              allowHalfRating: true,
                              onRatingChanged: (v) async {
                                setState(() {
                                  rating = v;
                                });
                                User? user = FirebaseAuth.instance.currentUser;
                                if (user != null) {
                                  await FirebaseFirestore.instance
                                      .collection("users")
                                      .doc(user.uid)
                                      .set({
                                    'rating': {movieId.toString(): v.toString()},
                                  }, SetOptions(merge: true));
                                }
                              },
                              starCount: 5,
                              rating: rating,
                              size: 25.0,
                              filledIconData: Icons.star_rate,
                              halfFilledIconData: Icons.star_half,
                              color: Colors.amber,
                              borderColor: Colors.amber,
                              spacing: 0.0,
                            )
                          ],
                        ),
                        IconButton(
                          onPressed: () async {
                            setState(() {
                              favorite = !favorite;
                            });

                            User? user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(user.uid)
                                  .set({
                                'favorite': {movieId.toString(): favorite},
                              }, SetOptions(merge: true));
                            }
                          },
                          icon: favorite
                              ? Icon(
                                  Icons.favorite_sharp,
                                  color: Colors.redAccent,
                                )
                              : Icon(
                                  Icons.favorite_border_outlined,
                                  color: Colors.redAccent,
                                ),
                        )
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      child: Text(widget.movieData.title,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 0, 5),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.star_rate,
                            color: Color.fromRGBO(255, 196, 0, 1),
                            size: 17,
                          ),
                          Text(
                            widget.movieData.voteAverage.toString() + '/10 IMDB',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   padding: EdgeInsets.only(left: 10),
                    //   child: Text(widget.movieData.genreIds.toString()),
                    // ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(children: [
                              Text(
                                'Language',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                widget.movieData.originalLanguage.toUpperCase(),
                                style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Column(children: [
                              Text(
                                "Audience",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              widget.movieData.adult
                                  ? Text('R-Rated',
                                      style: TextStyle(
                                        // fontSize: 20,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w800,
                                      ))
                                  : Text('General',
                                      style: TextStyle(
                                        // fontSize: 20,
                                        color: Colors.green.shade400,
                                        fontWeight: FontWeight.w800,
                                      ))
                            ]),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Text(
                        'Description',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        physics: AlwaysScrollableScrollPhysics(),
                        children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          widget.movieData.overview,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ],),
                    ),
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
