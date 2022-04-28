import 'package:flutter/material.dart';

import '../models/tvshow_model.dart';
import '../services/fetch_data.dart';

class SearchMoviePage extends StatefulWidget {
  const SearchMoviePage({Key? key}) : super(key: key);

  @override
  State<SearchMoviePage> createState() => _SearchMoviePageState();
}

class _SearchMoviePageState extends State<SearchMoviePage> {
  List<TvShow> shows = [];
  var fetchData = FetchMovies();
  String query = 'avengers';
  
  @override
  void initState() {
    super.initState();
    searchMovie();
  }

  searchMovie() async {
    shows = await fetchData.getTvShows();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          color: Colors.transparent,
          
          child: GridView.builder(
            itemCount: shows.length,

            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 1/1.5,
                crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
            padding: EdgeInsets.all(10),
            shrinkWrap: true,

            itemBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 300,
                width: 100,
                child : Image.network(
                  'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
                      shows[index].posterPath,
                  fit: BoxFit.fill,
                ),
              );
            },
            
          ),
        ));
  }
}
