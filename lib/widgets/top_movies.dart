import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../services/fetch_data.dart';
import '../models/movies.dart';
import 'movie_details.dart';

class TopMovie extends StatefulWidget {
  const TopMovie({Key? key}) : super(key: key);

  @override
  State<TopMovie> createState() => _TopMovieState();
}

class _TopMovieState extends State<TopMovie>
    with AutomaticKeepAliveClientMixin<TopMovie> {
  List<Movies> topMovies = [];
  bool isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  var fetchData = FetchMovies();

  getData() async {
    topMovies = await fetchData.fetchTopMovies();
    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoaded ? Container(
      height: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          // shrinkWrap: true,
          itemCount: topMovies.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(children: [
              // SizedBox(height:20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetails(topMovies[index])),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  height: 200,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(
                          'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
                              topMovies[index].posterPath),
                      fit: BoxFit.fill,
                      alignment: Alignment.topCenter,
                    ),
                  ),
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star_rate,
                          color: Color.fromRGBO(255, 196, 0, 1),
                          size: 15,
                        ),
                        Text(
                          'IMDB : ' +
                              topMovies[index].voteAverage.toString() +
                              '/10',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black.withOpacity(0.4),
                                  offset: const Offset(0, 0),
                                  blurRadius: 10,
                                ),
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                alignment: Alignment.center,
                child: Text(
                  topMovies[index].title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              )
            ]);
          }),
    ): Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: 250,
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
                      height: 190,
                      width: 150,
                    ),
                  );
                },
              ),
            ),
          );
  }
}
