import 'package:flutter/material.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/util/mediaproviders.dart';
import 'package:standup_india/util/navigator.dart';
import 'package:standup_india/widgets/media_list/media_list.dart';
import 'package:standup_india/widgets/utilviews/toggle_theme_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  PageController _pageController = PageController();
  int _page = 0;
  MediaType mediaType = MediaType.movie;

  final MovieProvider movieProvider = MovieProvider();
  final VideoProvider showProvider = VideoProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ToggleThemeButton(),
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {

            },
          )
        ],
        title: Text("Standup India"),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                padding: const EdgeInsets.all(0.0),
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                    const Color(0xff2b5876),
                    const Color(0xff4e4376),
                  ])),
                )),
            ListTile(
              title: Text("Search"),
              trailing: Icon(Icons.search),
              onTap: () => {

              }
            ),
            ListTile(
              title: Text("Favorites"),
              trailing: Icon(Icons.favorite),
              onTap: () => goToFavorites(context),
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Comics"),
              selected: mediaType == MediaType.movie,
              trailing: Icon(Icons.mic),
              onTap: () {
                _changeMediaType(MediaType.movie);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: Text("Videos"),
              selected: mediaType == MediaType.show,
              trailing: Icon(Icons.live_tv),
              onTap: () {
                _changeMediaType(MediaType.show);
                Navigator.of(context).pop();
              },
            ),
            Divider(
              height: 5.0,
            ),
            ListTile(
              title: Text("Close"),
              trailing: Icon(Icons.close),
              onTap: () => Navigator.of(context).pop(),
            )
          ],
        ),
      ),
      body: PageView(
        children: _getMediaList(),
        pageSnapping: true,
        controller: _pageController,
        onPageChanged: (int index) {
          setState(() {
            _page = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _getNavBarItems(),
        onTap: _navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void _changeMediaType(MediaType type) {
    if (mediaType != type) {
      setState(() {
        mediaType = type;
      });
    }
  }

  List<BottomNavigationBarItem> _getNavBarItems() {
    if (mediaType == MediaType.movie) {
      return [
        BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up), title: Text('Popular')),
        BottomNavigationBarItem(
            icon: Icon(Icons.update), title: Text('Upcoming')),
        BottomNavigationBarItem(
            icon: Icon(Icons.star), title: Text('Top Rated')),
      ];
    } else {
      return [
        BottomNavigationBarItem(
            icon: Icon(Icons.thumb_up), title: Text('Popular')),
        BottomNavigationBarItem(
            icon: Icon(Icons.live_tv), title: Text('On The Air')),
        BottomNavigationBarItem(
            icon: Icon(Icons.star), title: Text('Top Rated')),
      ];
    }
  }

  List<Widget> _getMediaList() {
    return (mediaType == MediaType.movie)
        ? <Widget>[
            MediaList( "comics", "popular", key: Key("movies-popular"),
            ),
            MediaList(  "comics", "upcoming", key: Key("movies-upcoming")),
            MediaList(  "comics", "top_rated", key: Key("movies-top_rated")),
          ]
        : <Widget>[
            MediaList( "videos", "popular", key: Key("shows-popular")),
            MediaList( "videos","on_the_air", key: Key("shows-on_the_air")),
            MediaList("videos", "top_rated", key: Key("shows-top_rated")),
          ];
  }

  void _navigationTapped(int page) {
    _pageController.animateToPage(page,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}
