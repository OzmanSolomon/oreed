import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Services/BrandMenuCategoryRepo.dart';
import 'package:oreeed/UI/HomeUIComponent/Search.dart';
import 'package:oreeed/UI/Products/GridView/VerticalGProductsList.dart';

bool loadImage = true;

class brand extends StatefulWidget {
  @override
  _brandState createState() => _brandState();
}

class _brandState extends State<brand> {
  Future<ApiResponse> _categories;
  @override
  void initState() {
    super.initState();
    _categories = BrandMenuCategoryRepo().fetchCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    /// Component appbar
    var _appbar = AppBar(
      backgroundColor: Color(0xFFFFFFFF),
      elevation: 0.0,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: Text(
          AppLocalizations.of(context).tr('whishlist'),
          style: TextStyle(
              fontFamily: "Montserrat",
              fontSize: 20.0,
              color: Colors.black54,
              fontWeight: FontWeight.w700),
        ),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) => new searchAppbar(),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0, left: 20.0),
            child: Icon(
              Icons.search,
              size: 27.0,
              color: Colors.black54,
            ),
          ),
        )
      ],
    );

    var data = EasyLocalizationProvider.of(context).data;

    return EasyLocalizationProvider(
      data: data,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Scaffold(
          /// Calling variable appbar
          appBar: _appbar,
          body: _imageLoaded(context),
        ),
      ),
    );
  }

  /// Calling ImageLoaded animation for set layout
  Widget _imageLoaded(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FavoriteProductsList(
          title: AppLocalizations.of(context).tr('favorite'),
          router: "top_sales"),
    );
  }
}
