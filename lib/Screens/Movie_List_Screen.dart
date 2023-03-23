import 'package:flutter/material.dart';

import '../Model/Movies_Model.dart'; //imported from model...

class Movie_list_Details extends StatelessWidget {
  final String MovieName; //
  final Movie movie; //coming from the model
  const Movie_list_Details({required this.MovieName, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MovieName),
        backgroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Movie_detail_thumbNail(
            ThumbNail_img: movie.images[1],
          ),
          MovieDetails_poster(
            movie_poster: movie,
          ),
          HorizontalLine(), //horizontal line
          MovieDetailsCast(movie_cast: movie),
          HorizontalLine(), //horizontal line
          MovieDetailsExtraPosters(posters: movie.images),
          const SizedBox(
            height: 5,
          )
        ],
      ),
    );
  }
}

//another Re-usable section for the movie ThumbNail
class Movie_detail_thumbNail extends StatelessWidget {
  final String ThumbNail_img;
  const Movie_detail_thumbNail({Key? key, required this.ThumbNail_img})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 260,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(ThumbNail_img), fit: BoxFit.cover),
              ),
            ),
            const Icon(
              Icons.play_circle_outline,
              size: 100,
              color: Colors.white,
            )
          ],
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0x00f5f5f5), Color(0xfff5f5f5)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          height: 80,
        )
      ],
    );
  }
}

//another Re-usable section for the movieDetails with poster
class MovieDetails_poster extends StatelessWidget {
  final Movie movie_poster; //getting it from the model
  const MovieDetails_poster({Key? key, required this.movie_poster})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          MoviePoster(poster: movie_poster.images[0].toString()),
          const SizedBox(width: 16.0),
          Expanded(
            child: movieDetailHeader(movie_header: movie_poster),
          ),
        ],
      ),
    );
  }
}

//Re-usable poster component
class MoviePoster extends StatelessWidget {
  final String poster;
  const MoviePoster({Key? key, required this.poster}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width / 4,
          height: 160,
          decoration: BoxDecoration(
            image:
                DecorationImage(image: NetworkImage(poster), fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}

//Re-usable Header component
class movieDetailHeader extends StatelessWidget {
  final Movie movie_header;
  const movieDetailHeader({Key? key, required this.movie_header})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${movie_header.year} . ${movie_header.genre}".toUpperCase(),
          style:
              const TextStyle(fontWeight: FontWeight.w400, color: Colors.cyan),
        ),
        Text(
          movie_header.title,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 32),
        ),
        Text.rich(
          TextSpan(
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w300,
            ),
            children: <TextSpan>[
              TextSpan(text: movie_header.plot),
              const TextSpan(
                text: "More...",
                style: TextStyle(color: Colors.indigoAccent),
              )
            ],
          ),
        )
      ],
    );
  }
}

//Re-Usable component
class MovieDetailsCast extends StatelessWidget {
  final Movie movie_cast;

  const MovieDetailsCast({Key? key, required this.movie_cast})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          MovieField(field: "Cast", value: movie_cast.actors),
          MovieField(field: "Directors", value: movie_cast.director),
          MovieField(field: "Awards", value: movie_cast.awards),
          MovieField(field: "Country", value: movie_cast.country),
          MovieField(field: "Language", value: movie_cast.language),
          MovieField(field: "Type", value: movie_cast.type)
        ],
      ),
    );
  }
}

//Re-Usable component
class MovieField extends StatelessWidget {
  final String field;
  final String value;

  const MovieField({Key? key, required this.field, required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$field : ",
          style: const TextStyle(
              color: Colors.black38, fontSize: 12, fontWeight: FontWeight.w300),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
                color: Colors.black, fontSize: 12, fontWeight: FontWeight.w300),
          ),
        )
      ],
    );
  }
}

//re-usable horizontal line
class HorizontalLine extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Container(
        height: 0.5,
        color: Colors.grey,
      ),
    );
  }
}

class MovieDetailsExtraPosters extends StatelessWidget {
  final List<String> posters;

  const MovieDetailsExtraPosters({Key? key, required this.posters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "More Movie Posters".toUpperCase(),
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        Container(
          height: 170,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
            itemCount: posters.length,
            itemBuilder: (context, index) => ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Container(
                width: MediaQuery.of(context).size.width / 4,
                height: 160,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(posters[index]), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
