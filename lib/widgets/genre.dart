// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import '../services/fetch_data.dart';
import '../models/genre_model.dart';

class GenreWidget extends StatefulWidget {
  const GenreWidget({Key? key}) : super(key: key);

  @override
  State<GenreWidget> createState() => _GenreWidgetState();
}

class _GenreWidgetState extends State<GenreWidget> {
  List<Genre> categories = [];
  int selectedCategory = 0;
  @override
  initState() {
    super.initState();
    getData();
  }

  var fetchData = FetchMovies();

  getData() async {
    categories = await fetchData.fetchGenre();
    if (mounted) {
      setState((){
      
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      child: ListView.builder(
        itemCount: categories.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedCategory = index;
                    },);
                  },
                  child: Text(categories[index].name,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: index == selectedCategory
                                ? Colors.black
                                : Colors.black.withOpacity(0.5),
                          )),
                ),
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == selectedCategory
                        ? Colors.orange.shade400
                        : Colors.transparent,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
