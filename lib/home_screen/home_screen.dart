import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:news_app/const.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/view_model/news_view_model.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsViewModel newsViewModel = NewsViewModel();
    double height = screenHeight(context);
    double width = screenWidth(context);
    final format = DateFormat('MMM dd, yyyy');
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          //for this center title appbar will be in the center
          title: Text(
            'News',
            style:
                GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/list.png',
                height: 30,
                width: 30,
              )),
        ),
        body: ListView(
          children: [
            SizedBox(
              height: height * 0.55,
              width: width,
              child: FutureBuilder<NewsChannelsHeadlinesModels>(
                  future: newsViewModel.fetchNewsChannelHeadlineApi(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SpinKitCircle(
                          size: 50,
                          color: Colors.blue,
                        ),
                      );
                    } else {
                      return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          itemCount: snapshot.data!.articles!.length,
                          itemBuilder: (context, index) {
                            DateTime dateTime = DateTime.parse(snapshot!
                                .data!.articles![index].publishedAt
                                .toString());
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: screenHeight(context) * 0.6,
                                    width: screenWidth(context) * 0.9,
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            screenHeight(context) * 0.02),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                          imageUrl: snapshot
                                              .data!.articles![index].urlToImage
                                              .toString(),
                                          fit: BoxFit.cover,
                                          placeholder: (context, url) =>
                                              Container(
                                                child: spinKit2,
                                              ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                                Icons.error_outline,
                                                color: Colors.red,
                                              )),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    child: Card(
                                      elevation: 5,
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Container(
                                        height: height * 0.22,
                                        alignment: Alignment.bottomCenter,
                                        padding: const EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: width * 0.7,
                                              child: Text(
                                                snapshot.data!.articles![index]
                                                    .title
                                                    .toString(),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.poppins(
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            const Spacer(),
                                            Container(
                                              padding: const EdgeInsets.all(15),
                                              width: width * 0.7,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data!
                                                        .articles![index]
                                                        .source!
                                                        .name
                                                        .toString(),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    format.format(dateTime),
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }
                  }),
            )
          ],
        ));
  }
}
