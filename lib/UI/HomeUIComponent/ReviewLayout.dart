import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:oreeed/Library/Expanded/ExpandedDetailReviews.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Services/ProductRepo.dart';
import 'package:oreeed/UI/BrandUIComponent/NoData.dart';
import 'package:timeago/timeago.dart' as timeago;

class ReviewsAll extends StatefulWidget {
  int index;
  double rating = 0.0;
  int totalRating = 0;
  ReviewsAll({this.index, this.rating, this.totalRating});
  @override
  _ReviewsAllState createState() => _ReviewsAllState();
}

class _ReviewsAllState extends State<ReviewsAll> {
  @override
  double rating = 3.5;
  int starCount = 5;
  Future<ApiResponse> _reviews;

  @override
  void initState() {
    super.initState();
    _reviews = ProductRepo().fetchReviewsList(widget.index);
  }

  /// Custom Text for Detail title
  static var _detailText = TextStyle(
      fontFamily: "Montserrat",
      color: Colors.black54,
      letterSpacing: 0.3,
      wordSpacing: 0.5);

  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).tr('reviewsAppBar')),
          centerTitle: true,
          leading: InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black87,
              )),
          elevation: 0.0,
        ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, left: 20.0),
                    child: Text(
                      AppLocalizations.of(context).tr('reviewsAppBar'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5.0, left: 20.0),
                    child: Row(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              StarRating(
                                size: 25.0,
                                starCount: 5,
                                rating: widget.rating,
                                color: Colors.yellow,
                              ),
                              SizedBox(width: 5.0),
                              Text('${widget.totalRating} Reviews')
                            ]),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  ListTile(
                    leading: Container(
                      height: 45.0,
                      width: 45.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/avatars/male.png"),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(
                          Radius.circular(50.0),
                        ),
                      ),
                    ),
                    title: Row(
                      children: <Widget>[
                        StarRating(
                          size: 20.0,
                          rating: rating,
                          starCount: starCount,
                          color: Colors.yellow,
                          onRatingChanged: (rating) {
                            setState(() {
                              this.rating = rating;
                            });
                          },
                        ),
                        SizedBox(width: 8.0),
                        Text(
                          AppLocalizations.of(context).tr('date'),
                          style: TextStyle(fontSize: 12.0),
                        )
                      ],
                    ),
                    subtitle: ExpansionTileReview(
                      title: Text(
                        AppLocalizations.of(context).tr('ratingReview'),
                        style: _detailText,
                      ),
                      children: [
                        SizedBox(height: 10.0),
                        Text(
                          AppLocalizations.of(context).tr('ratingReview2'),
                          style: _detailText,
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          AppLocalizations.of(context).tr('ratingReview'),
                          style: _detailText,
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder(
                      future:
                          _reviews, // here you provide your future. In your case Provider.of<PeopleModel>(context).fetchPeople()
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        var apiResponse = snapshot.data;
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return TryAgainLater();
                            break;
                          case ConnectionState.waiting:
                            return Container(
                              child: LoaderFetchingData(),
                              height: 50,
                            );
                            break;
                          case ConnectionState.active:
                            return Container(
                              child: LoaderFetchingData(),
                              height: 50,
                            );
                            break;
                          case ConnectionState.done:
                            if (apiResponse.code == 1) {
                              return Column(
                                children: List.generate(
                                  apiResponse.object.length,
                                  (index) => Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.0,
                                            right: 20.0,
                                            top: 15.0,
                                            bottom: 7.0),
                                        child: _line(),
                                      ),
                                      _Rating(
                                          rating: 5,
                                          date: "2020-08-08",
                                          details:
                                              "test from localt befor intrgration",
                                          image: "assets/avatars/male.png"),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return NoData();
                            }
                            break;
                          default:
                            return null;
                            break;
                        }
                      }),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 15.0, bottom: 7.0),
                    child: _line(),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 40.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _Rating({String date, String details, double rating, String image}) {
    return ListTile(
      leading: Container(
        height: 45.0,
        width: 45.0,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
      ),
      title: Row(
        children: <Widget>[
          StarRating(
            size: 20.0,
            rating: rating,
            starCount: 5,
            color: Colors.yellow,
          ),
          SizedBox(width: 8.0),
          Text(
            timeago.format(DateTime.parse(date), locale: 'en'),
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
      subtitle: Text(
        details,
        style: _detailText,
      ),
    );
  }

  Widget _buildRating(
      String date, String details, Function changeRating, String image) {
    return ListTile(
      leading: Container(
        height: 45.0,
        width: 45.0,
        decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
      ),
      title: Row(
        children: <Widget>[
          StarRating(
              size: 20.0,
              rating: rating,
              starCount: starCount,
              color: Colors.yellow,
              onRatingChanged: changeRating),
          SizedBox(width: 8.0),
          Text(
            date,
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
      subtitle: Text(
        details,
        style: _detailText,
      ),
    );
  }
}

Widget _line() {
  return Container(
    height: 0.9,
    width: double.infinity,
    color: Colors.black12,
  );
}
