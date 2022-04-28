// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../models/movies.dart';
import '../services/fetch_data.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'movie_details.dart';

class UpcomingMovieSlider extends StatefulWidget {
  const UpcomingMovieSlider({Key? key}) : super(key: key);

  @override
  State<UpcomingMovieSlider> createState() => _UpcomingMovieSliderState();
}

class _UpcomingMovieSliderState extends State<UpcomingMovieSlider>
    with AutomaticKeepAliveClientMixin {
  List<Movies> upcomingMovies = [];
  bool isLoaded = false;

  final List<String> imageList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  // @override
  // void didChangeDependency() {
  //   super.didChangeDependencies();
  //   if (isLoaded) {
  //     setState(() => getData());

  //   }
  //   isLoaded = false;
  // }

  var fetchData = FetchMovies();

  getData() async {
    upcomingMovies = await fetchData.fetchUpcomingMovies();
    for (var i = 0; i < upcomingMovies.length; i++) {
      imageList.add('https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
          upcomingMovies[i].posterPath);
    }
    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  bool get wantKeepAlive => true;
//upcomingMovies!.posterPath.map((i)
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoaded ? Container(
      height: 300,
      child: CarouselSlider(
        options: CarouselOptions(
          aspectRatio: 10 / 21,
          height: 300,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
          autoPlay: true,
        ),
        items: <Widget>[
          for (var i = 0; i < imageList.length; i++)
            Container(
              width: 230,
              height: 200,
              margin: const EdgeInsets.symmetric(vertical:10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageList[i]),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
        ],
      ),
    ): Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              alignment: Alignment.center,
              height: 300,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const SizedBox(
                      height: 300,
                      width:250 ,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
