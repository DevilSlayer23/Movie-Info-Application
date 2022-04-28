import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../models/movies.dart';
import '../services/fetch_data.dart';
import 'movie_details.dart';

class PopularMovie extends StatefulWidget {
  const PopularMovie({Key? key}) : super(key: key);

  @override
  State<PopularMovie> createState() => _PopularMovieState();
}

class _PopularMovieState extends State<PopularMovie>
    with AutomaticKeepAliveClientMixin<PopularMovie> {
  List<Movies> popularMovies = [];
  bool isLoaded = false;

  @override
  @override
  void initState() {
    super.initState();
    getData();
  }

  var fetchData = FetchMovies();

  getData() async {
    popularMovies = await fetchData.fetchPopularMovies();
    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return isLoaded
        ? SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                // shrinkWrap: true,
                itemCount: popularMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetails(popularMovies[index])),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        height: 195,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
                                    popularMovies[index].posterPath),
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
                                    popularMovies[index]
                                        .voteAverage
                                        .toString() +
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
                        popularMovies[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    )
                  ]);
                }),
          )
        : Shimmer.fromColors(
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
                    child: const SizedBox(height: 190, width: 150,),
                  );
                },
              ),
            ),
          );
  }
}
