import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_alternative_title_model.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/review_model.dart';
import 'package:movie_app/services/api_services.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;
  const MovieDetailPage({super.key, required this.movieId});
  
  

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
  
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  ApiServices apiServices = ApiServices();

  late Future<MovieDetailModel> movieDetail;
  late Future<MovieAlternativeTitleModel> movieAlternativeTitles;
  late Future<Result> movieRecommendationModel;
  late Future<ReviewResult> movieReviews;

  @override
  void initState() {
    fetchInitialData();
    super.initState();
  }

  fetchInitialData() {
    setState(() {
    movieDetail = apiServices.getMovieDetail(widget.movieId);
    movieAlternativeTitles = ApiServices().getAlternativeTitles(widget.movieId);
  
    });
    
    movieRecommendationModel =
        apiServices.getMovieRecommendations(widget.movieId);
    setState(() {});
    movieReviews = apiServices.getTopReviewsMovie(100);
    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    //print(widget.movieId);
    return Scaffold(
      
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.hasData) {

               final movie = snapshot.data;
               String genresText = movie!.genres.map((genre) => genre.name).join(', ');
             
              return Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: size.height * 0.4,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                    "$imageUrl${movie.posterPath}"),
                                fit: BoxFit.cover)),
                        child: SafeArea(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios,
                                    color: Colors.white),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 25, left: 10, right: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      
                      children: [
                        Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                       FutureBuilder(
                        future: movieAlternativeTitles,
                        builder: (context, snapshot) {
                          if(snapshot.hasData){
                            final movieAlternativeTitles = snapshot.data;
                            String altText = movieAlternativeTitles!.alternativeTitles.map((alternativeTitles)=>alternativeTitles.title).join(', ');
                            return Column(children: [
                              Padding(padding: const EdgeInsets.only(top: 10, left: 5, right: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Títulos alternativos: $altText',
                                  style: const TextStyle(
                            fontSize: 15,
                          ),)
                                ],
                              ),
                              )
                            ]);
                          }else{
                           print(snapshot.error);
                            return Text('Erro ao carregar os títulos alternativos.');
                          }
                        }),

                        const SizedBox(height: 15),
                        Row(
                          children: [
                            Text(
                              movie.releaseDate.year.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Text(
                              genresText,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                             Icon(Icons.person, color: Colors.grey, size: 17),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              movie.popularity.toString(),
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Icon(Icons.star, color: Colors.yellow, size: 17),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '${movie.voteAverage.toStringAsFixed(1)}/10',
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          movie.overview,
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  FutureBuilder(
                    future: movieRecommendationModel,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movie = snapshot.data;

                        return movie!.movies.isEmpty
                            ? const SizedBox()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "More like this",
                                    maxLines: 6,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  GridView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    scrollDirection: Axis.vertical,
                                    itemCount: movie.movies.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 1.5 / 2,
                                    ),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  MovieDetailPage(
                                                      movieId: movie
                                                          .movies[index].id),
                                            ),
                                          );
                                        },
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "$imageUrl${movie.movies[index].posterPath}",
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              );
                      }
                      return const Text("Something Went wrong");
                    },
                  ),
                ],
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
