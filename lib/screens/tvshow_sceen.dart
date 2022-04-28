import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../models/tvshow_model.dart';
import '../services/fetch_data.dart';

class TvShowPage extends StatefulWidget {
  const TvShowPage({Key? key}) : super(key: key);

  @override
  State<TvShowPage> createState() => _TvShowPageState();
}

class _TvShowPageState extends State<TvShowPage> {
  bool isLoaded = false;
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
    if (mounted) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoaded
          ? Container(
              color: Colors.transparent,
              child: GridView.builder(
                itemCount: shows.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 1.5,
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                padding: EdgeInsets.all(10),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: SizedBox(
                      height: 300,
                      width: 100,
                      child: Image.network(
                        'https://www.themoviedb.org/t/p/w600_and_h900_bestv2' +
                            shows[index].posterPath,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              ),
            )
          : Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 1.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SizedBox(
                      height: 190,
                      width: MediaQuery.of(context).size.width,
                    ),
                  );
                },
               
              ),
            ),
    );
  }
}
