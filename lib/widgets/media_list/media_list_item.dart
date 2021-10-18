import 'package:flutter/material.dart';
import 'package:standup_india/model/mediaitem.dart';
import 'package:standup_india/util/navigator.dart';
import 'package:standup_india/util/utils.dart';

class NumberFormatter{
  static String formatter(String currentBalance) {
    try{
      // suffix = {' ', 'k', 'M', 'B', 'T', 'P', 'E'};
      double value = double.parse(currentBalance);

      if(value < 1000){ // less than a thousand
        return value.toStringAsFixed(2);
      }else if(value >= 1000 && value < (1000*100*10)){ // less than a million
        double result = value/1000;
        return result.toStringAsFixed(2)+"k";
      }else if(value >= 1000000 && value < (1000000*10*100)){ // less than 100 million
        double result = value/1000000;
        return result.toStringAsFixed(2)+"M";
      }else if(value >= (1000000*10*100) && value < (1000000*10*100*100)){ // less than 100 billion
        double result = value/(1000000*10*100);
        return result.toStringAsFixed(2)+"B";
      }else if(value >= (1000000*10*100*100) && value < (1000000*10*100*100*100)){ // less than 100 trillion
        double result = value/(1000000*10*100*100);
        return result.toStringAsFixed(2)+"T";
      }
      return '';
    }catch(e){
      print(e);
    }
    return '';
  }
}

class MediaListItem extends StatelessWidget {
  MediaListItem(this.movie);

  final MediaItem movie;

  Widget _getTitleSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Text(
                    movie.title,
                    style: Theme
                        .of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text("",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 12.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    movie.lovedRatio.toString() + " Love Ratio",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 4.0,
                  ),
                ],
              ),
              Container(
                height: 4.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    NumberFormatter.formatter(movie.viewCount.toString()) + " views",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 4.0,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () => goToMovieDetails(context, movie),
        child: Column(
          children: <Widget>[
            Hero(
              child: FadeInImage.assetNetwork(
                placeholder: "assets/placeholder.png",
                image: movie.getBackDropUrl(),
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.0,
                fadeInDuration: Duration(milliseconds: 50),
              ),
              tag: "Movie-Tag-${movie.id}",
            ),
            _getTitleSection(context),
          ],
        ),
      ),
    );
  }
}
