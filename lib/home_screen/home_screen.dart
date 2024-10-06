import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/const.dart';
import 'package:news_app/models/news_channel_headlines_model.dart';
import 'package:news_app/view_model/news_view_model.dart';

class Home_Screen extends StatelessWidget {
  const Home_Screen({super.key});

  @override
  Widget build(BuildContext context) {
    NewsViewModel newsViewModel = NewsViewModel();
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
              height: screenHeight(context) * 0.55,
              width: screenWidth(context),
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
                            return Container(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    height: screenHeight(context) * 0.6,
                                    width: screenWidth(context) * 0.9,
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
                                  )
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
