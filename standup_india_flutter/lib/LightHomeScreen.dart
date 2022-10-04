import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:standup_india_flutter/widgets/listprice1_item_widget.dart';

import 'ComicVideosListScreen.dart';
import 'CommonImageView.dart';
import 'color_constant.dart';
import 'image_constant.dart';
import 'math_utils.dart';

class LightHomeScreen extends StatelessWidget {
  Future<List<dynamic>> fetch() async {
    var result = await http
        .get(Uri.parse("https://boiling-badlands-67720.herokuapp.com"));
    return jsonDecode(result.body);
  }

  Future<List<dynamic>> fetchVideosLatest() async {
    var result = await http
        .get(Uri.parse("https://boiling-badlands-67720.herokuapp.com/videosByPublishedTime"));
    return jsonDecode(result.body);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("StandUp India"),
      ),
      body: FutureBuilder<Widget>(
        future: body(context),
        // a previously-obtained Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            children = <Widget>[snapshot.data!];
            return children[0];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = <Widget>[
              const CircularProgressIndicator(),
            ];
          }
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          );
        },
      ),
    );
  }

  @override
  Future<Widget> body(BuildContext context) async {
    bool isDark = true;
    var data = await fetch();
    var videosLatest = await fetchVideosLatest();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: getVerticalSize(55),
              width: size.width,
              margin: getMargin(
                top: 16,
                left: 24,
                right: 24,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: getHorizontalSize(20),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context)
                          //   =>LightSearchTypeKeywordScreen()),
                          // );
                        },
                        child: Padding(
                          padding: getPadding(
                            top: 15,
                            bottom: 14,
                          ),
                          child: SvgPicture.asset(
                            ImageConstant.imgSearchGray900,
                            color: isDark ? Colors.white : Colors.black,
                            height: getVerticalSize(
                              22.00,
                            ),
                            width: getHorizontalSize(
                              21.00,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: getHorizontalSize(20),
                      ),
                      InkWell(
                        onTap: () {
                          // onTap  Navigator.push(
                          //     context,
                          //     MaterialPageRoute(builder: (context)
                          //     =>LightNotificationMusicScreen()),
                          //   );
                        },
                        child: Padding(
                          padding: getPadding(
                            top: 14,
                            right: 0,
                            bottom: 14,
                          ),
                          child: SvgPicture.asset(
                            ImageConstant.imgUser22X17,
                            color: isDark ? Colors.white : Colors.black,
                            height: getVerticalSize(
                              22.00,
                            ),
                            width: getHorizontalSize(
                              17.00,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: size.width,
                child: SingleChildScrollView(
                  child: Container(
                    margin: getMargin(
                      top: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: double.infinity,
                            margin: getMargin(
                              top: 32,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: getPadding(right: 20, left: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Trending Now",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: getFontSize(
                                              24,
                                            ),
                                            fontFamily: 'Urbanist',
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          left: 0,
                                          bottom: 6,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context)
                                            //   =>LightTrendingNowScreen()),
                                            // );
                                          },
                                          child: Text(
                                            "See All",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: ColorConstant.greenA700,
                                              fontSize: getFontSize(
                                                16,
                                              ),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: getVerticalSize(
                                    270.00,
                                  ),
                                  child: FadeInLeft(
                                    child: ListView.builder(
                                      padding: getPadding(
                                          top: 32,
                                          right: 20,
                                          left: 20,
                                          bottom: 20),
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: 6,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ComicVideosList(comic: data[index]['title']),
                                              ),
                                            );
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getHorizontalSize(
                                                    24.00,
                                                  ),
                                                ),
                                                child: CommonImageView(
                                                  url: videosLatest[index]
                                                      ['thumbnail'],
                                                  height: getSize(
                                                    180.00,
                                                  ),
                                                  width: getSize(
                                                    240.00,
                                                  ),
                                                ),
                                              ),
                                                  Expanded(
                                                  child:
                                              Container(
                                                width: getHorizontalSize(
                                                  180.00,
                                                ),

                                                margin: getMargin(
                                                  top: 5,
                                                ),
                                                child: Text(
                                                  videosLatest[index]['title'],
                                                  maxLines: 4,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: getFontSize(
                                                        12,
                                                      ),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.20,
                                                      color: Colors.white),
                                                )),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      getPadding(top: 32, right: 20, left: 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Popular Artists",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            24,
                                          ),
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          left: 0,
                                          bottom: 6,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context)
                                            //   =>LightPopularArtistsScreen()),
                                            // );
                                          },
                                          child: Text(
                                            "See All",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: ColorConstant.greenA700,
                                              fontSize: getFontSize(
                                                16,
                                              ),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: getVerticalSize(
                                    270.00,
                                  ),
                                  child: FadeInLeft(
                                    child: ListView.builder(
                                      padding: getPadding(
                                          top: 32,
                                          right: 20,
                                          left: 20,
                                          bottom: 20),
                                      scrollDirection: Axis.horizontal,
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: 4,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ComicVideosList(comic: data[index]['title']),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            padding: getPadding(
                                              right: 0,
                                              left: 12,
                                            ),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                    getHorizontalSize(
                                                      80.00,
                                                    ),
                                                  ),
                                                  child: CommonImageView(
                                                    url: data[index]['posterPath'],
                                                    height: getSize(
                                                      160.00,
                                                    ),
                                                    width: getSize(
                                                      160.00,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: getPadding(
                                                    top: 8,
                                                  ),
                                                  child: Text(
                                                    data[index]['title'],
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize: getFontSize(
                                                        18,
                                                      ),
                                                      fontFamily: 'Urbanist',
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      letterSpacing: 0.20,
                                                      color: Colors.white
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: getPadding(
                                    top: 32,
                                    right: 20,
                                    left: 20,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Text(
                                        "Top Charts",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                          fontSize: getFontSize(
                                            24,
                                          ),
                                          fontFamily: 'Urbanist',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Padding(
                                        padding: getPadding(
                                          left: 0,
                                          bottom: 6,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            // Navigator.push(
                                            //   context,
                                            //   MaterialPageRoute(builder: (context)
                                            //   =>LightChartsScreen()),
                                            // );
                                          },
                                          child: Text(
                                            "See All",
                                            overflow: TextOverflow.ellipsis,
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              color: ColorConstant.greenA700,
                                              fontSize: getFontSize(
                                                16,
                                              ),
                                              fontFamily: 'Urbanist',
                                              fontWeight: FontWeight.w700,
                                              letterSpacing: 0.20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: getVerticalSize(
                                    270.00,
                                  ),
                                  child: ListView.builder(
                                    padding: getPadding(
                                        top: 32,
                                        right: 20,
                                        left: 20,
                                        bottom: 20),
                                    scrollDirection: Axis.horizontal,
                                    physics: BouncingScrollPhysics(),
                                    itemCount: 4,
                                    itemBuilder: (context, index) {
                                      return Listprice1ItemWidget();
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
