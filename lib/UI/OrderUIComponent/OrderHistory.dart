import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/MyOrdersModel.dart';
import 'package:oreeed/Services/OrdersRepo.dart';
import 'package:oreeed/UI/GenralWidgets/BackButton.dart';
import 'package:oreeed/UI/HomeUIComponent/OrdersHistory.dart';
import 'package:oreeed/UI/Products/GridView/VerticalGProductsList.dart';
import 'package:oreeed/Utiles/Constants.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';

class OrderHome extends StatefulWidget {
  @override
  _OrderHomeState createState() => _OrderHomeState();
}

class _OrderHomeState extends State<OrderHome> {
  Future<ApiResponse> _orders;

  User _user;
  bool liveSession = false;

  Future<void> initUSer() async {
    int flag = await DatabaseHelper().getUserCount();
    var _uservar = (await DatabaseHelper().getUserList())[0];
    if (flag > 0) {
      setState(() {
        _user = _uservar;
        liveSession = flag > 0;
        setState(() {
          print("&&&&&&&&&&&&&&&&&&&&&& User is ${_user.id}");
          _orders = OrdersRepo().fetchOrdersList(userId: int.parse(_user.id));
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initUSer();
  }

  @override
  void didChangeDependencies() {
    print("i am here _________________________________");
    // TODO: implement didChangeDependencies
    // initUSer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BackButtonBtn(
      child: Scaffold(
        appBar: AppBar(
          title: Text('My Orders '),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 8, right: 8),
          child: FutureBuilder(
              future: _orders,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                var apiResponse = snapshot.data;
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return isLoadinging(context: context, count: 6);
                    break;
                  case ConnectionState.waiting:
                    return isLoadinging(context: context, count: 6);
                    break;
                  case ConnectionState.active:
                    return isLoadinging(context: context, count: 6);
                    break;
                  case ConnectionState.done:
                    //print("#########################################");
                    print(apiResponse.object.toString());
                    if (apiResponse.code == 1) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: apiResponse.object.length,
                        itemBuilder: (context, index) {
                          return MySingleOrderView(apiResponse.object[index]);
                        },
                      );
                    } else {
                      return noItemCart();
                    }
                    break;
                  default:
                    return null;
                    break;
                }
              }),
        ),
      ),
    );
  }
}

class ItemModel {
  bool isExpanded;
  String header;
  BodyModel bodyModel;

  ItemModel({this.isExpanded: false, this.header, this.bodyModel});
}

class BodyModel {
  int price;
  int quantity;

  BodyModel({this.price, this.quantity});
}

class MySingleOrderView extends StatefulWidget {
  final MyOrders myOrder;
  MySingleOrderView(this.myOrder);
  @override
  _MySingleOrderViewState createState() => _MySingleOrderViewState();
}

class _MySingleOrderViewState extends State<MySingleOrderView> {
  @override
  Widget build(BuildContext context) {
    return widget.myOrder.itemProduct.isNotEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionPanelList(
              animationDuration: Duration(seconds: 1),
              children: [
                ExpansionPanel(
                  body: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
                    child: widget.myOrder.itemProduct.isEmpty
                        ? Container()
                        : OrderCard(widget.myOrder.itemProduct),
                  ),
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                EdgeInsets.only(top: 20, left: 10, bottom: 5),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "Date :",
                                    style: _txtCustom.copyWith(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "  2020-08-25",
                                    style: _txtCustom.copyWith(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 5, left: 10, bottom: 5),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "Order ID :",
                                    style: _txtCustom.copyWith(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "  5as8-5a3s-58s1",
                                    style: _txtCustom.copyWith(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: 5, left: 10, bottom: 15),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "Status :",
                                    style: _txtCustom.copyWith(
                                        color: Colors.black54,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "  New",
                                    style: _txtCustom.copyWith(
                                        color: Colors.green,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  isExpanded: widget.myOrder.isSeen == 1,
                )
              ],
              expansionCallback: (int item, bool status) {
                setState(() {
                  if (widget.myOrder.isSeen == 1) {
                    widget.myOrder.isSeen = 0;
                  } else {
                    widget.myOrder.isSeen = 1;
                  }
                });
              },
            ),
          )
        : noItemCart();
  }

  String getStatus(int statsId) {
    print("$statsId");
    switch (statsId) {
      case 1:
        return "Sent";
        break;
      case 2:
        return "Processing";
        break;
      case 3:
        return "Shipped";
        break;
      case 4:
        return "History";
        break;
      default:
        return "New";
        break;
    }
  }

  Color getStatusClr(int statsId) {
    print("$statsId");
    switch (statsId) {
      case 1:
        return Colors.green;
        break;
      case 2:
        return Colors.blueGrey;
        break;
      case 3:
        return appBlue;
        break;
      case 4:
        return Colors.black;
        break;
      default:
        return Colors.green;
        break;
    }
  }
}

class OrderCard extends StatefulWidget {
  final List<OrderItem> itemProduct;
  OrderCard(this.itemProduct);
  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool _showDetail = true;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            Container(
              height: 40,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: OutlineButton(
                      onPressed: () {
                        setState(() {
                          _showDetail = false;
                        });
                      },
                      child: Text("Order Track"),
                      color: _showDetail ? Colors.grey : Colors.white,
                      highlightedBorderColor:
                          _showDetail ? Colors.grey : Colors.white,
                    ),
                  ),
                  Expanded(
                    child: OutlineButton(
                      onPressed: () {
                        setState(() {
                          _showDetail = true;
                        });
                      },
                      child: Text("Detail"),
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _showDetail,
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    /// Get data in PromotionDetail.dart (ListItem folder)
                    widget.itemProduct.length,
                    (position) => Padding(
                      padding: EdgeInsets.only(
                          top: position == 0 ? 12.0 : 5,
                          bottom: position == 0 ? 12.0 : 5),
                      child: Card(
                        elevation: 2,
                        child: ListTile(
                          subtitle: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'PRICE: ${(widget.itemProduct[position].productsPrice).toStringAsFixed(2)}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  // fontSize: 18,
                                ),
                              ),
                              Text(
                                'QUANTITY:  ${widget.itemProduct[position].productsQuantity}',
                                style: TextStyle(
                                  color: Colors.grey[700],
                                  // fontSize: 18,
                                ),
                              )
                            ],
                          ),
                          title: Text(
                            'Item: ${widget.itemProduct[position].productsName}',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 18,
                            ),
                          ),
                          leading: Container(
                            height: 50,
                            width: 65,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  'http://staging.oreeed.com/${widget.itemProduct[position].image}'),
                              fit: BoxFit.fitHeight,
                            )),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !_showDetail,
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: 800.0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20.0, left: 25.0, right: 25.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 20.0)),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                _bigCircleNotYet,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _bigCircle,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _bigCircle,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _smallCircle,
                                _bigCircle,
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                qeueuItem(
                                  icon: "assets/img/bag.png",
                                  txtHeader: AppLocalizations.of(context)
                                      .tr('txtHeader1'),
                                  txtInfo: AppLocalizations.of(context)
                                      .tr('txtInfo1'),
                                  time: "11:0",
                                  paddingValue: 55.0,
                                ),
                                Padding(padding: EdgeInsets.only(top: 50.0)),
                                qeueuItem(
                                  icon: "assets/img/courier.png",
                                  txtHeader: AppLocalizations.of(context)
                                      .tr('txtHeader2'),
                                  txtInfo: AppLocalizations.of(context)
                                      .tr('txtInfo2'),
                                  time: "9:50",
                                  paddingValue: 16.0,
                                ),
                                Padding(padding: EdgeInsets.only(top: 50.0)),
                                qeueuItem(
                                  icon: "assets/img/payment.png",
                                  txtHeader: AppLocalizations.of(context)
                                      .tr('txtHeader3'),
                                  txtInfo: AppLocalizations.of(context)
                                      .tr('txtInfo3'),
                                  time: "8:20",
                                  paddingValue: 55.0,
                                ),
                                Padding(padding: EdgeInsets.only(top: 50.0)),
                                qeueuItem(
                                  icon: "assets/img/order.png",
                                  txtHeader: AppLocalizations.of(context)
                                      .tr('txtHeader4'),
                                  txtInfo: AppLocalizations.of(context)
                                      .tr('txtInfo4'),
                                  time: "8:00",
                                  paddingValue: 19.0,
                                ),
                              ],
                            ),
                          ],
                        ), /////
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 48.0, bottom: 30.0, left: 0.0, right: 25.0),
                          child: Container(
                            height: 130.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    blurRadius: 4.5,
                                    spreadRadius: 1.0,
                                  )
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Image.asset("assets/img/house.png"),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)
                                          .tr('delivery'),
                                      style: _txtCustom.copyWith(
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 5.0)),
                                    Text(
                                      "Khartoum, El-Maamoura.",
                                      style: _txtCustom.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          color: Colors.black38),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Padding(padding: EdgeInsets.only(top: 2.0)),
                                    Text(
                                      "Queen's Tower, 5th floor, Apartment No. 53",
                                      style: _txtCustom.copyWith(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0,
                                          color: Colors.black38),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
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

var _txtCustom = TextStyle(
  color: Colors.black54,
  fontSize: 15.0,
  fontWeight: FontWeight.w500,
  fontFamily: "Gotik",
);

/// Create Big Circle for Data Order Not Success
var _bigCircleNotYet = Padding(
  padding: const EdgeInsets.only(top: 8.0),
  child: Container(
    height: 20.0,
    width: 20.0,
    decoration: BoxDecoration(
      color: Colors.lightGreen,
      shape: BoxShape.circle,
    ),
  ),
);

/// Create Circle for Data Order Success
var _bigCircle = Padding(
  padding: const EdgeInsets.only(top: 8.0),
  child: Container(
    height: 20.0,
    width: 20.0,
    decoration: BoxDecoration(
      color: Colors.lightGreen,
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 14.0,
      ),
    ),
  ),
);

/// Create Small Circle
var _smallCircle = Padding(
  padding: const EdgeInsets.only(top: 8.0),
  child: Container(
    height: 3.0,
    width: 3.0,
    decoration: BoxDecoration(
      color: Colors.lightGreen,
      shape: BoxShape.circle,
    ),
  ),
);

class order extends StatefulWidget {
  @override
  _orderState createState() => _orderState();
}

class _orderState extends State<order> {
  static var _txtCustom = TextStyle(
    color: Colors.black54,
    fontSize: 15.0,
    fontWeight: FontWeight.w500,
    fontFamily: "Gotik",
  );

  /// Create Big Circle for Data Order Not Success
  var _bigCircleNotYet = Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: appBlue,
        shape: BoxShape.circle,
      ),
    ),
  );

  /// Create Circle for Data Order Success
  var _bigCircle = Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      height: 20.0,
      width: 20.0,
      decoration: BoxDecoration(
        color: appBlue,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 14.0,
        ),
      ),
    ),
  );

  /// Create Small Circle
  var _smallCircle = Padding(
    padding: const EdgeInsets.only(top: 8.0),
    child: Container(
      height: 3.0,
      width: 3.0,
      decoration: BoxDecoration(
        color: appBlue,
        shape: BoxShape.circle,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            AppLocalizations.of(context).tr('trackMyOrder'),
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20.0,
                color: Colors.black54,
                fontFamily: "Gotik"),
          ),
          centerTitle: true,
          iconTheme: IconThemeData(color: Color(0xFF6991C7)),
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            width: 800.0,
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 25.0, right: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    AppLocalizations.of(context).tr('dateOrder'),
                    style: _txtCustom,
                  ),
                  Padding(padding: EdgeInsets.only(top: 7.0)),
                  Text(
                    AppLocalizations.of(context).tr('orderID'),
                    style: _txtCustom,
                  ),
                  Padding(padding: EdgeInsets.only(top: 30.0)),
                  Text(
                    AppLocalizations.of(context).tr('order'),
                    style: _txtCustom.copyWith(
                        color: Colors.black54,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          _bigCircleNotYet,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _bigCircle,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _bigCircle,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _smallCircle,
                          _bigCircle,
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          qeueuItem(
                            icon: "assets/img/bag.png",
                            txtHeader:
                                AppLocalizations.of(context).tr('txtHeader1'),
                            txtInfo:
                                AppLocalizations.of(context).tr('txtInfo1'),
                            time: "11:0",
                            paddingValue: 55.0,
                          ),
                          Padding(padding: EdgeInsets.only(top: 50.0)),
                          qeueuItem(
                            icon: "assets/img/courier.png",
                            txtHeader:
                                AppLocalizations.of(context).tr('txtHeader2'),
                            txtInfo:
                                AppLocalizations.of(context).tr('txtInfo2'),
                            time: "9:50",
                            paddingValue: 16.0,
                          ),
                          Padding(padding: EdgeInsets.only(top: 50.0)),
                          qeueuItem(
                            icon: "assets/img/payment.png",
                            txtHeader:
                                AppLocalizations.of(context).tr('txtHeader3'),
                            txtInfo:
                                AppLocalizations.of(context).tr('txtInfo3'),
                            time: "8:20",
                            paddingValue: 55.0,
                          ),
                          Padding(padding: EdgeInsets.only(top: 50.0)),
                          qeueuItem(
                            icon: "assets/img/order.png",
                            txtHeader:
                                AppLocalizations.of(context).tr('txtHeader4'),
                            txtInfo:
                                AppLocalizations.of(context).tr('txtInfo4'),
                            time: "8:00",
                            paddingValue: 19.0,
                          ),
                        ],
                      ),
                    ],
                  ), /////
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 48.0, bottom: 30.0, left: 0.0, right: 25.0),
                    child: Container(
                      height: 130.0,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12.withOpacity(0.1),
                              blurRadius: 4.5,
                              spreadRadius: 1.0,
                            )
                          ]),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Image.asset("assets/img/house.png"),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                AppLocalizations.of(context).tr('delivery'),
                                style: _txtCustom.copyWith(
                                    fontWeight: FontWeight.w700),
                              ),
                              Padding(padding: EdgeInsets.only(top: 5.0)),
                              Text(
                                AppLocalizations.of(context).tr('homeWork'),
                                style: _txtCustom.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.0,
                                    color: Colors.black38),
                              ),
                              Padding(padding: EdgeInsets.only(top: 2.0)),
                              Text(
                                AppLocalizations.of(context).tr('houseNo'),
                                style: _txtCustom.copyWith(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0,
                                    color: Colors.black38),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Constructor Data Orders
class qeueuItem extends StatelessWidget {
  @override
  static var _txtCustomOrder = TextStyle(
    color: Colors.black45,
    fontSize: 13.5,
    fontWeight: FontWeight.w600,
    fontFamily: "Gotik",
  );

  String icon, txtHeader, txtInfo, time;
  double paddingValue;

  qeueuItem(
      {this.icon, this.txtHeader, this.txtInfo, this.time, this.paddingValue});

  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 13.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 8.0,
                    right: mediaQueryData.padding.right + paddingValue),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(txtHeader, style: _txtCustomOrder),
                    Text(
                      txtInfo,
                      style: _txtCustomOrder.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0,
                          color: Colors.black38),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: _txtCustomOrder..copyWith(fontWeight: FontWeight.w400),
              )
            ],
          ),
        ],
      ),
    );
  }
}
