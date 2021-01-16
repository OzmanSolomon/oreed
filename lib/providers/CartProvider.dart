import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Models/ProductsModel.dart';
import 'package:oreeed/Models/ShippingAddressModel.dart';
import 'package:oreeed/Services/OrdersRepo.dart';
import 'package:oreeed/UI/BottomNavigationBar.dart';
import 'package:oreeed/UI/GenralWidgets/ServerProcessLoader.dart';
import 'package:oreeed/UI/GenralWidgets/ShowSnacker.dart';
import 'package:oreeed/Utiles/databaseHelper.dart';

class CartProvider with ChangeNotifier {
  // init values and params
  MyAddresses _currentAddress;
  List<Product> _inCart = [];
  double _total = 0.0;
  int _stage = 1;
  int _selectDeliveryMethod = 1;
  int _selectedPayMent = 1;

  List<Product> get getCart => _inCart;
  double get getTotalPrice => _total;
  MyAddresses get myCurrentAddresses => _currentAddress;
  int get stage => _stage;
  int get getDeliveryMethod => _selectDeliveryMethod;
  int get selectedPayMent => _selectedPayMent;

  void setDefaultAddress(MyAddresses myAddress) {
    _currentAddress = myAddress;
    notifyListeners();
  }

  void removeFromCart(int index) {
    updateTotalAccount(_inCart[index].productsQuantity *
        double.parse(
            _inCart[index].productsPrice ?? _inCart[index].flashPrice));
    _inCart.removeAt(index);
    notifyListeners();
  }

  void updateTotalAccount(double deletedPrice) {
    _total = _total - deletedPrice;
    notifyListeners();
  }

  void setDeliveryMthod(int index) {
    _selectDeliveryMethod = index;
    notifyListeners();
  }

  void setStage(int value) {
    _stage = value;
    notifyListeners();
  }

  void setPayMent(int value) {
    _selectedPayMent = value;
    notifyListeners();
  }

  void calculateTotalPrice() {
    _total = 0.0;
    _inCart.forEach((element) {
      _total += element.productsQuantity * double.parse(element.productsPrice);
    });
    notifyListeners();
  }

  addToCart({Product product}) {
    if (_inCart.contains(product)) {
      print("trying to add existing element to cart :");
      incrementQty(cartItem: product);
    } else {
      print("trying to add new element to cart :");
      product.productsQuantity = 1;
      _inCart.add(product);
      notifyListeners();
      print("after adding ${_inCart.length} :");
    }
    calculateTotalPrice();
  }

  delFromCart({Product cartItem}) {
    _inCart.remove(cartItem);
    calculateTotalPrice();
    notifyListeners();
  }

  incrementQty({Product cartItem}) {
    _inCart.forEach((item) {
      if (item == cartItem) {
        if (item.productsQuantity > 0) {
          item.productsQuantity = item.productsQuantity + 1;
          print(item.productsQuantity);
        }
      }
    });
    calculateTotalPrice();
    notifyListeners();
  }

  decrementQty({Product cartItem}) {
    _inCart.forEach((item) {
      if (item == cartItem) {
        if (item.productsQuantity > item.productsMinOrder) {
          item.productsQuantity = item.productsQuantity - 1;
        }
      }
    });
    calculateTotalPrice();
    notifyListeners();
  }

  void placeOrder({GlobalKey<ScaffoldState> scaffoldKey, User user}) async {
    var _myProducts = [];
    _inCart.forEach((item) => _myProducts.add(item.toMap()));
    _inCart.clear();
    Navigator.of(scaffoldKey.currentContext).push(
      PageRouteBuilder(
          opaque: false,
          pageBuilder: (BuildContext context, _, __) {
            return OverLayWidgetWithLoader(false);
          }),
    );
    //print("############################################");
    print("User: ${user.toMap()}");
    //print("############################################");
    print("Total: $_total");
    //print("############################################");
    print("Address: ${_currentAddress.toMap()}");
    //print("############################################");
    print("Cart Items: ${_myProducts}");
    print("$_selectDeliveryMethod");

    try {
      FullOrder myOrder = new FullOrder(
          total: _total,
          itemList: _myProducts,
          shippingMethod: "cod",
          user: user,
          userAddress: _currentAddress);

      OrdersRepo().placeOrder(fullOrder: myOrder).then((apiResponse) {
        Navigator.pop(scaffoldKey.currentContext);
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              ShowSnackBar(
                  context: scaffoldKey.currentContext,
                  msg: apiResponse.msg,
                  bgColor: Colors.grey.withOpacity(0.9),
                  textColor: Colors.black,
                  height: 25);
              Navigator.of(scaffoldKey.currentContext).push(
                PageRouteBuilder(
                    pageBuilder: (_, __, ___) => new BottomNavigationBarPage(),
                    transitionDuration: Duration(milliseconds: 750),

                    /// Set animation with opacity
                    transitionsBuilder:
                        (_, Animation<double> animation, __, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: child,
                      );
                    }),
              );
              break;
            default:
              ShowSnackBar(
                  context: scaffoldKey.currentContext,
                  msg: apiResponse.msg,
                  bgColor: Colors.grey.withOpacity(0.9),
                  textColor: Colors.black,
                  height: 25);
              break;
          }
        } else {
          ShowSnackBar(
              context: scaffoldKey.currentContext,
              msg: apiResponse.msg,
              bgColor: Colors.grey.withOpacity(0.9),
              textColor: Colors.black,
              height: 25);
        }
      });
    } catch (Exception) {
      //print("######################################################");
      print("Exception : ${Exception}");
      ShowSnackBar(
          context: scaffoldKey.currentContext,
          msg: AppLocalizations.of(scaffoldKey.currentContext)
              .tr('serverNoTalk'),
          bgColor: Colors.grey.withOpacity(0.9),
          textColor: Colors.black,
          height: 25);
    }
  }

  /// Card Popup if success payment
  _showDialog(BuildContext ctx) {
    /// Custom Text Header for Dialog after user succes payment
    var _txtCustomHead = TextStyle(
      color: Colors.black54,
      fontSize: 23.0,
      fontWeight: FontWeight.w600,
      fontFamily: "Montserrat",
    );

    /// Custom Text Description for Dialog after user succes payment
    var _txtCustomSub = TextStyle(
      color: Colors.black38,
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      fontFamily: "Montserrat",
    );
    showDialog(
      context: ctx,
      barrierDismissible: true,
      child: SimpleDialog(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0, right: 60.0, left: 60.0),
            color: Colors.white,
            child: Image.asset(
              "assets/img/checklist.png",
              height: 110.0,
              color: Colors.lightGreen,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                AppLocalizations.of(ctx).tr('yuppy'),
                style: _txtCustomHead,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.of(ctx).push(PageRouteBuilder(
                  pageBuilder: (_, __, ___) => new BottomNavigationBarPage(),
                  transitionDuration: Duration(milliseconds: 750),

                  /// Set animation with opacity
                  transitionsBuilder:
                      (_, Animation<double> animation, __, Widget child) {
                    return Opacity(
                      opacity: animation.value,
                      child: child,
                    );
                  }));
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 40.0),
                child: Text(
                  AppLocalizations.of(ctx).tr('paymentReceive'),
                  style: _txtCustomSub,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  Product item;
  int qty;

  CartItem({
    this.item,
    this.qty,
  });

  Map<String, dynamic> toMap() {
    var _attributes = [];
    item.attributes.forEach((item) => _attributes.add(item.toMap()));
    print("###&&&&&&&&&&&&&&&& item ${item.attributes.length}");
    print("###&&&&&&&&&&&&&&&& _attributes $_attributes");
    Map<String, dynamic> map = {
      "customers_basket_quantity": qty,
      "products_id": item.productsId,
      "price": item.productsPrice,
      "final_price": item.productsPrice,
      "products_name": item.productsName,
      "attributes": _attributes,
    };
    return map;
  }
}

class FullOrder {
  List itemList;
  double total;
  User user;
  MyAddresses userAddress;
  String shippingMethod;

  FullOrder(
      {this.itemList,
      this.total,
      this.user,
      this.userAddress,
      this.shippingMethod});

  Map<String, dynamic> toMap() => {
        "language_id": 1,
        "products": itemList,
        "currency_code": "SDG",
        "guest_status": 0,
        "customers_id": user.id,
        "customers_telephone": user.phone,
        "email": user.email,
        "delivery_firstname": user.firstName,
        "delivery_lastname": userAddress.lastname,
        "delivery_street_address": userAddress.street,
        "delivery_suburb": "delivery_suburb",
        "delivery_city": userAddress.city,
        "delivery_postcode": userAddress.postcode,
        "delivery_zone": userAddress.zoneCode,
        "delivery_country": userAddress.countryName,
        "billing_firstname": userAddress.firstname,
        "billing_lastname": userAddress.lastname,
        "billing_street_address": userAddress.street,
        "billing_suburb": "billing_suburb",
        "billing_city": userAddress.city,
        "billing_postcode": userAddress.postcode,
        "billing_country": userAddress.countryName,
        "payment_method": "cod",
        "cc_type": "cc_type",
        "cc_owner": "cc_owner",
        "cc_number": "cc_number",
        "cc_expires": "cc_expires",
        "totalPrice": total,
        "shipping_cost": 1,
        "shipping_method": shippingMethod,
        "orders_date_finished": "2020-09-30",
        "comments": "no comments ",
        "delivery_phone": user.phone,
        "billing_phone": user.phone,
        "currency_value": "SDG",
        "total_tax": 1,
        "is_coupon_applied": 0
      };
}
