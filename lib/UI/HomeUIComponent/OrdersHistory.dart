import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:oreed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreed/Models/ApiResponse.dart';
import 'package:oreed/Models/MyOrdersModel.dart';
import 'package:oreed/Services/OrdersRepo.dart';
import 'package:oreed/UI/Products/GridView/VerticalGProductsList.dart';
import 'package:oreed/Utiles/databaseHelper.dart';
import 'package:oreed/providers/AuthProvider.dart';
import 'package:oreed/providers/CartProvider.dart';
import 'package:provider/provider.dart';

class OrdersHistory extends StatefulWidget {
  @override
  _OrdersHistoryState createState() => _OrdersHistoryState();
}

class _OrdersHistoryState extends State<OrdersHistory> {
  Future<ApiResponse> _orders;

  User _user;
  bool liveSession = false;
  @override
  void didChangeDependencies() {
    if (mounted) {
      initUSer();
      fetchOrders();
    }
    super.didChangeDependencies();
  }

  Future<void> initUSer() async {
    int flag = await DatabaseHelper().getUserCount();
    var _uservar = (await DatabaseHelper().getUserList())[0];
    if (flag > 0) {
      setState(() {
        _user = _uservar;
        liveSession = flag > 0;
      });
    }
  }

  void fetchOrders() {
    if (liveSession) {
      setState(() {
        print("&&&&&&&&&&&&&&&&&&&&&& User is ${_user.id}");
        _orders = OrdersRepo().fetchOrdersList(userId: int.parse(_user.id));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<AuthProvider>(context);
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: userData.loginCheck
          ? Consumer<CartProvider>(builder: (context, cart, _) {
              return Scaffold(
                appBar: AppBar(
                  iconTheme: IconThemeData(color: Color(0xFF6991C7)),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  title: Text(
                    "My Orders ",
                    style: TextStyle(
                        fontFamily: "Montserrat",
                        fontSize: 18.0,
                        color: Colors.black54,
                        fontWeight: FontWeight.w700),
                  ),
                  elevation: 0.0,
                ),
                body: SingleChildScrollView(
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
                            if (apiResponse.code == 1) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height - 200,
                                child: SingleChildScrollView(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      // padding: EdgeInsets.only(top: 10.0),
                                      scrollDirection: Axis.vertical,
                                      itemCount: apiResponse.object.length,
                                      itemBuilder: (context, index) {
                                        return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              100,
                                          child: new ExpansionTile(
                                            title: Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  100,
                                              height:
                                                  // MediaQuery.of(context).size.height -
                                                  100,
                                              child: new Text(
                                                apiResponse
                                                    .object[index].ordersId
                                                    .toString(),
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FontStyle.italic),
                                              ),
                                            ),
                                            children: <Widget>[
                                              new Column(
                                                children:
                                                    _buildExpandableContent(
                                                        apiResponse
                                                            .object[index]),
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                ),
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
              );
              // cart.getCart.length > 0
              //     ? Center(
              //         child: Container(
              //           height: MediaQuery.of(context).size.height - 90,
              //           child: Column(
              //             mainAxisSize: MainAxisSize.min,
              //             mainAxisAlignment: MainAxisAlignment.start,
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: <Widget>[
              //               Container(
              //                 height: MediaQuery.of(context).size.height - 176,
              //                 width: MediaQuery.of(context).size.width,
              //                 child: ListView.builder(
              //                   itemCount: cart.getCart.length,
              //                   itemBuilder: (context, position) {
              //                     ///
              //                     /// Widget for list view slide delete
              //                     ///
              //                     return Slidable(
              //                       delegate: new SlidableDrawerDelegate(),
              //                       actionExtentRatio: 0.25,
              //                       actions: <Widget>[
              //                         new IconSlideAction(
              //                           caption: AppLocalizations.of(context)
              //                               .tr('cartArchiveText'),
              //                           color: Colors.blue,
              //                           icon: Icons.archive,
              //                           onTap: () {
              //                             ///
              //                             /// SnackBar show if cart Archive
              //                             ///
              //                             Scaffold.of(context).showSnackBar(
              //                               SnackBar(
              //                                 content: Text(
              //                                     AppLocalizations.of(context)
              //                                         .tr('cartArchice')),
              //                                 duration: Duration(seconds: 2),
              //                                 backgroundColor: Colors.blue,
              //                               ),
              //                             );
              //                           },
              //                         ),
              //                       ],
              //                       secondaryActions: <Widget>[
              //                         new IconSlideAction(
              //                           key: Key(position.toString()),
              //                           caption: AppLocalizations.of(context)
              //                               .tr('cartDelete'),
              //                           color: Colors.red,
              //                           icon: Icons.delete,
              //                           onTap: () {
              //                             setState(() {
              //                               cart.getCart.removeAt(position);
              //                             });
              //
              //                             ///
              //                             /// SnackBar show if cart delet
              //                             ///
              //                             Scaffold.of(context)
              //                                 .showSnackBar(SnackBar(
              //                               content: Text(
              //                                   AppLocalizations.of(context)
              //                                       .tr('cartDeleted')),
              //                               duration: Duration(seconds: 2),
              //                               backgroundColor: Colors.redAccent,
              //                             ));
              //                           },
              //                         ),
              //                       ],
              //                       child: Padding(
              //                         padding: const EdgeInsets.only(
              //                             top: 1.0, left: 13.0, right: 13.0),
              //
              //                         /// Background Constructor for card
              //                         child: Container(
              //                           height: 158.0,
              //                           decoration: BoxDecoration(
              //                             color: Colors.white,
              //                             boxShadow: [
              //                               BoxShadow(
              //                                 color:
              //                                     Colors.black12.withOpacity(0.1),
              //                                 blurRadius: 3.5,
              //                                 spreadRadius: 0.4,
              //                               )
              //                             ],
              //                           ),
              //                           child: Column(
              //                             crossAxisAlignment:
              //                                 CrossAxisAlignment.start,
              //                             children: <Widget>[
              //                               Row(
              //                                 mainAxisAlignment:
              //                                     MainAxisAlignment.start,
              //                                 crossAxisAlignment:
              //                                     CrossAxisAlignment.start,
              //                                 children: <Widget>[
              //                                   Padding(
              //                                     padding: EdgeInsets.all(10.0),
              //
              //                                     /// Image item
              //                                     child: Container(
              //                                       decoration: BoxDecoration(
              //                                           color: Colors.white
              //                                               .withOpacity(0.1),
              //                                           boxShadow: [
              //                                             BoxShadow(
              //                                                 color: Colors
              //                                                     .black12
              //                                                     .withOpacity(
              //                                                         0.1),
              //                                                 blurRadius: 0.5,
              //                                                 spreadRadius: 0.1)
              //                                           ]),
              //                                       child: CachedNetworkImage(
              //                                         imageUrl:
              //                                             "http://oreeed.com/${cart.getCart[position].item.productsImage}",
              //                                         height: 130.0,
              //                                         width: 120.0,
              //                                         fit: BoxFit.cover,
              //                                       ),
              //                                     ),
              //                                   ),
              //                                   Flexible(
              //                                     child: Padding(
              //                                       padding:
              //                                           const EdgeInsets.only(
              //                                               top: 25.0,
              //                                               left: 10.0,
              //                                               right: 5.0),
              //                                       child: Column(
              //                                         /// Text Information Item
              //                                         crossAxisAlignment:
              //                                             CrossAxisAlignment
              //                                                 .start,
              //                                         mainAxisAlignment:
              //                                             MainAxisAlignment.start,
              //                                         children: <Widget>[
              //                                           Text(
              //                                             '${cart.getCart[position].item.productsName}',
              //                                             style: TextStyle(
              //                                               fontWeight:
              //                                                   FontWeight.w700,
              //                                               fontFamily:
              //                                                   "Montserrat",
              //                                               color: Colors.black87,
              //                                             ),
              //                                             overflow: TextOverflow
              //                                                 .ellipsis,
              //                                           ),
              //                                           Padding(
              //                                               padding:
              //                                                   EdgeInsets.only(
              //                                                       top: 10.0)),
              //                                           Text(
              //                                             '${cart.getCart[position].item.productsStatus}',
              //                                             style: TextStyle(
              //                                               color: Colors.black54,
              //                                               fontWeight:
              //                                                   FontWeight.w500,
              //                                               fontSize: 12.0,
              //                                             ),
              //                                           ),
              //                                           Padding(
              //                                             padding:
              //                                                 EdgeInsets.only(
              //                                                     top: 10.0),
              //                                           ),
              //                                           Text(
              //                                               '${cart.getCart[position].item.productsPrice}'),
              //                                           Padding(
              //                                             padding:
              //                                                 const EdgeInsets
              //                                                         .only(
              //                                                     top: 18.0,
              //                                                     left: 0.0),
              //                                             child: Container(
              //                                               width: 112.0,
              //                                               decoration:
              //                                                   BoxDecoration(
              //                                                 color:
              //                                                     Colors.white70,
              //                                                 border: Border.all(
              //                                                   color: Colors
              //                                                       .black12
              //                                                       .withOpacity(
              //                                                           0.1),
              //                                                 ),
              //                                               ),
              //                                               child: Row(
              //                                                 mainAxisAlignment:
              //                                                     MainAxisAlignment
              //                                                         .spaceAround,
              //                                                 children: <Widget>[
              //                                                   /// Decrease of value item
              //                                                   InkWell(
              //                                                     onTap: () {
              //                                                       setState(() {
              //                                                         Provider.of<CartProvider>(
              //                                                                 context,
              //                                                                 listen:
              //                                                                     false)
              //                                                             .decrementQty(
              //                                                                 cartItem:
              //                                                                     cart.getCart[position]);
              //                                                       });
              //                                                     },
              //                                                     child:
              //                                                         Container(
              //                                                       height: 30.0,
              //                                                       width: 30.0,
              //                                                       decoration:
              //                                                           BoxDecoration(
              //                                                         border:
              //                                                             Border(
              //                                                           right:
              //                                                               BorderSide(
              //                                                             color: Colors
              //                                                                 .black12
              //                                                                 .withOpacity(0.1),
              //                                                           ),
              //                                                         ),
              //                                                       ),
              //                                                       child: Center(
              //                                                         child: Text(
              //                                                             "-"),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                   Padding(
              //                                                     padding: const EdgeInsets
              //                                                             .symmetric(
              //                                                         horizontal:
              //                                                             18.0),
              //                                                     child: Text(
              //                                                       '${cart.getCart[position].qty}'
              //                                                           .toString(),
              //                                                     ),
              //                                                   ),
              //
              //                                                   /// Increasing value of item
              //                                                   InkWell(
              //                                                     onTap: () {
              //                                                       setState(() {
              //                                                         Provider.of<CartProvider>(
              //                                                                 context,
              //                                                                 listen:
              //                                                                     false)
              //                                                             .incrementQty(
              //                                                                 cartItem:
              //                                                                     cart.getCart[position]);
              //                                                       });
              //                                                     },
              //                                                     child:
              //                                                         Container(
              //                                                       height: 30.0,
              //                                                       width: 28.0,
              //                                                       decoration:
              //                                                           BoxDecoration(
              //                                                         border:
              //                                                             Border(
              //                                                           left:
              //                                                               BorderSide(
              //                                                             color: Colors
              //                                                                 .black12
              //                                                                 .withOpacity(0.1),
              //                                                           ),
              //                                                         ),
              //                                                       ),
              //                                                       child: Center(
              //                                                         child: Text(
              //                                                             "+"),
              //                                                       ),
              //                                                     ),
              //                                                   ),
              //                                                 ],
              //                                               ),
              //                                             ),
              //                                           ),
              //                                         ],
              //                                       ),
              //                                     ),
              //                                   ),
              //                                 ],
              //                               ),
              //                               Padding(
              //                                   padding:
              //                                       EdgeInsets.only(top: 8.0)),
              //                             ],
              //                           ),
              //                         ),
              //                       ),
              //                     );
              //                   },
              //                   scrollDirection: Axis.vertical,
              //                 ),
              //               ),
              //               Container(
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: <Widget>[
              //                     Padding(
              //                       padding: const EdgeInsets.only(left: 10.0),
              //
              //                       /// Total price of item buy
              //                       child: Text(
              //                         AppLocalizations.of(context)
              //                                 .tr('cartTotal') +
              //                             "SDG" +
              //                             cart.getTotalPrice.toString(),
              //                         style: TextStyle(
              //                             color:
              //                                 Color(0xff033766), //Colors.black,
              //                             fontWeight: FontWeight.w500,
              //                             fontSize: 15.5,
              //                             fontFamily: "Montserrat"),
              //                       ),
              //                     ),
              //                     InkWell(
              //                       onTap: () {
              //                         Navigator.of(context).push(
              //                           PageRouteBuilder(
              //                             pageBuilder: (_, __, ___) => CheckOut(),
              //                           ),
              //                         );
              //                       },
              //                       child: Padding(
              //                         padding: const EdgeInsets.only(right: 10.0),
              //                         child: Container(
              //                           height: 40.0,
              //                           width: 120.0,
              //                           decoration: BoxDecoration(
              //                             color: Color(0xffF7BE08),
              //                           ),
              //                           child: Center(
              //                             child: Text(
              //                               AppLocalizations.of(context)
              //                                   .tr('checkOut'),
              //                               style: TextStyle(
              //                                   color: Color(0xff033766),
              //                                   fontFamily: "Montserrat",
              //                                   fontWeight: FontWeight.w600),
              //                             ),
              //                           ),
              //                         ),
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //       )
              //     : noItemCart());
            })
          : Container(
              child: Center(
                child: Text("Not Log In "),
              ),
            ),
    );
  }

  _buildExpandableContent(MyOrders myOrder) {
    List<Widget> columnContent = [];
    if (myOrder.itemProduct.isNotEmpty) {
      myOrder.itemProduct.forEach((product) {
        columnContent.add(
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: new ListTile(
                title: new Text(
                  product.productsName,
                  style: new TextStyle(fontSize: 18.0, color: Colors.redAccent),
                ),
                leading: new Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: CachedNetworkImageProvider(
                            "http://oreeed.com/" + product.image),
                        fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
          ),
        );
      });
    }

    return columnContent;
  }
}

///
///
/// If no item cart this class showing
///
class noItemCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    return Container(
      width: 500.0,
      color: Colors.white,
      height: double.infinity,
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                  padding:
                      EdgeInsets.only(top: mediaQueryData.padding.top + 50.0)),
              Image.asset(
                "assets/imgIllustration/IlustrasiCart.png",
                height: 300.0,
              ),
              Padding(padding: EdgeInsets.only(bottom: 10.0)),
              Text(
                "You Don't Have Any Order",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.5,
                    color: Colors.black26.withOpacity(0.2),
                    fontFamily: "Montserrat"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
