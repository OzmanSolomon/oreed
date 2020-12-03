import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_delegate.dart';
import 'package:oreeed/Library/Language_Library/lib/easy_localization_provider.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/ShippingAddressModel.dart';
import 'package:oreeed/Services/CheckOutRepo.dart';
import 'package:oreeed/UI/GenralWidgets/ServerProcessLoader.dart';
import 'package:oreeed/UI/LoginOrSignup/widgets/DropDownList.dart';
import 'package:oreeed/UI/LoginOrSignup/widgets/TextFromField.dart';
import 'package:oreeed/providers/CartProvider.dart';
import 'package:oreeed/providers/CheckOutProvider.dart';
import 'package:oreeed/providers/CountryProvider.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Address extends StatefulWidget {
  final String id;
  Address(this.id);
  @override
  _AddressState createState() => _AddressState();
}

class _AddressState extends State<Address> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  Future<ApiResponse> _address;

  @override
  void initState() {
    super.initState();
    _address = CheckOutRepo().fetchAddressList(userId: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var checkProvider = Provider.of<CheckOutProvider>(context, listen: false);
    var data = EasyLocalizationProvider.of(context).data;

    void _bottomSheet() {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (builder) {
            return SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height + 200,
                child: Column(
                  /// Setting Category List
                  children: <Widget>[
                    Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Container(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 50),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "New Shipping Address Form",
                                  style: TextStyle(
                                      letterSpacing: 0.1,
                                      // fontWeight: FontWeight.w200,
                                      // fontSize: 25.0,
                                      color: Colors.black54,
                                      fontFamily: "Montserrat"),
                                ),
                                FittedBox(
                                  child: OutlineButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        "Cancel",
                                        style: TextStyle(
                                            letterSpacing: 0.1,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.blueGrey,
                                            fontFamily: "Montserrat"),
                                      )),
                                )
                              ],
                            ),
                          ),

                          /// TextFromField Email
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                          ),
                          TextFromField(
                            icon: Icons.person,
                            isEmail: false,
                            isPassword: false,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Pleas Fill in the name';
                              }
                              return null;
                            },
                            onChange: (value) {
                              checkProvider.setFirstName(value);
                            },
                            hintText:
                                AppLocalizations.of(context).tr('firstName'),
                            inputType: TextInputType.emailAddress,
                          ),

                          /// TextFromField Email
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 6.0),
                          ),
                          TextFromField(
                            icon: Icons.person,
                            isEmail: false,
                            isPassword: false,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return AppLocalizations.of(context)
                                    .tr('restName');
                              }
                              return null;
                            },
                            onChange: (value) {
                              checkProvider.setLastName(value);
                            },
                            hintText:
                                AppLocalizations.of(context).tr('restName'),
                            inputType: TextInputType.emailAddress,
                          ),

                          /// TextFromField Phone
                          Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
                          TextFromField(
                            keyBoardType: TextInputType.number,
                            icon: Icons.phone,
                            isEmail: false,
                            isNum: true,
                            isPassword: false,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return 'Please Fill In Your Phone Number';
                              }
                              if (value.length < 10) {
                                return 'Please Fill In a Valid Phone Number';
                              }
                              return null;
                            },
                            onChange: (value) {
                              checkProvider.setReceiverPhone(value);
                            },
                            hintText: AppLocalizations.of(context)
                                .tr('enterPhoneNumber'),
                            inputType: TextInputType.emailAddress,
                          ),

                          /// TextFromField Password
                          Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
                          TextFromField(
                            icon: Icons.location_on,
                            isPassword: false,
                            hintText: "street Address",
                            inputType: TextInputType.text,
                            isEmail: false,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please Enter Your street Address";
                              }
                              return null;
                            },
                            onChange: (value) {
                              checkProvider.setStreetAddress(value);
                            },
                          ),

                          /// TextFromField Password
                          Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
                          TextFromField(
                            icon: Icons.location_city,
                            isPassword: false,
                            hintText: "City Name",
                            inputType: TextInputType.text,
                            isEmail: false,
                            validator: (String value) {
                              if (value.isEmpty) {
                                return "Please Enter Your street Address";
                              }
                              return null;
                            },
                            onChange: (value) {
                              checkProvider.setCity(value);
                            },
                          ),

                          /// TextFromField Confirme Password
                          Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30.0),
                            child: Container(
                                height: 60.0,
                                alignment: AlignmentDirectional.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14.0),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 10.0,
                                          color: Colors.black12)
                                    ]),
                                padding: EdgeInsets.only(
                                    left: 20.0,
                                    right: 30.0,
                                    top: 0.0,
                                    bottom: 0.0),
                                child: TimeZoneDropDown()),
                          ),

                          /// TextFromField Confirme Password
                          // Padding(padding: EdgeInsets.symmetric(vertical: 6.0)),
                          // TextFromField(
                          //   icon: Icons.code,
                          //   isPassword: true,
                          //   hintText: "postCode",
                          //   // AppLocalizations.of(context).tr('cPassword'),
                          //   inputType: TextInputType.text,
                          //   isEmail: false,
                          //   validator: (String value) {
                          //     if (value.isEmpty) {
                          //       return 'Please ReEnter Your postCode';
                          //     }
                          //     return null;
                          //   },
                          //   onChange: (value) {
                          //     checkProvider.setPostCode(value);
                          //   },
                          // ),
                          /// TextFromField Confirme Password
                          Padding(
                            padding: EdgeInsets.all(12.0),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      splashColor: Colors.yellow,
                      onTap: () async {
                        checkProvider.setUserId(widget.id);
                        checkProvider.setCountryId("199");
                        checkProvider.setIsDefault("0");
                        var timeZone =
                            Provider.of<CountryProvider>(context, listen: false)
                                .currentTimeZone
                                .zoneId;
                        checkProvider.setZoneId(timeZone.toString());
                        if (_formKey.currentState.validate()) {
                          checkProvider.setPostCode("11111");
                          _formKey.currentState.save();
                          if (checkProvider.model.firstName != null &&
                              checkProvider.model.streetAddress != null) {
                            checkProvider.addNewShippingAddress(
                                scaffoldKey: _key);
                          }
                        }
                      },
                      child: buttonBlackBottom(),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 20.0)),
                  ],
                ),
              ),
            );
          });
    }

    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        key: _key,
        resizeToAvoidBottomPadding: true,
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 30.0, left: 10.0, right: 10.0, bottom: 15),
            child: Column(
              /// Setting Category List
              children: <Widget>[
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        AppLocalizations.of(context).tr('deliveryLocation'),
                        style: TextStyle(
                            letterSpacing: 0.1,
                            fontWeight: FontWeight.bold,
                            // fontSize: 25.0,
                            color: Colors.black54,
                            fontFamily: "Montserrat"),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Or"),
                      SizedBox(
                        width: 5,
                      ),
                      FittedBox(
                        child: OutlineButton(
                            onPressed: _bottomSheet,
                            child: Text(
                              "Add New Address",
                              style: TextStyle(
                                  letterSpacing: 0.1,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                  color: Colors.green,
                                  fontFamily: "Montserrat"),
                            )),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    // height: MediaQuery.of(context).size.height ,
                    child: FutureBuilder(
                        future:
                            _address, // here you provide your future. In your case Provider.of<PeopleModel>(context).fetchPeople()
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          var apiResponse = snapshot.data;
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                              return Container();
                              break;
                            case ConnectionState.waiting:
                              return Center(
                                  child: Container(
                                child: CircularProgressIndicator(),
                                height: 50,
                                width: 50,
                              ));
                              break;
                            case ConnectionState.active:
                              return Container();
                              break;
                            case ConnectionState.done:
                              if (apiResponse.code == 1) {
                                if (apiResponse.object != null &&
                                    apiResponse.object.isNotEmpty) {
                                  apiResponse.object.toSet().toList();
                                  return ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      itemCount: apiResponse.object.length,
                                      itemBuilder: (context, index) {
                                        return AddressLine(
                                            myAddresses:
                                                apiResponse.object[index]);
                                      });
                                } else {
                                  return Center(
                                      child: Container(
                                          child: CircularProgressIndicator(),
                                          height: 50,
                                          width: 50));
                                }
                              } else {
                                return Container(
                                  child: Center(
                                    child: Text(
                                        "You Don't Have Any previus address "),
                                  ),
                                );
                              }
                              break;
                            default:
                              return null;
                              break;
                          }
                        }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///ButtonBlack class
class buttonBlackBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(30.0),
      child: Container(
        height: 55.0,
        width: 600.0,
        child: Text(
          "Save Address",
          style: TextStyle(
              color: Colors.black,
              letterSpacing: 0.2,
              fontFamily: "Montserrat",
              fontSize: 18.0,
              fontWeight: FontWeight.w800),
        ),
        alignment: FractionalOffset.center,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 15.0)],
          borderRadius: BorderRadius.circular(30.0),
          gradient:
              LinearGradient(colors: [Color(0xffF7BE08), Color(0xffF7BE00)]),
        ),
      ),
    );
  }
}

///ButtonBlack class
class AddressLine extends StatefulWidget {
  final MyAddresses myAddresses;
  // final bool isSelected;

  AddressLine({this.myAddresses});

  @override
  _AddressLineState createState() => _AddressLineState();
}

var alertStyle = AlertStyle(
  animationType: AnimationType.fromTop,
  isCloseButton: false,
  isOverlayTapDismiss: false,
  descStyle: TextStyle(fontWeight: FontWeight.bold),
  animationDuration: Duration(milliseconds: 400),
  alertBorder: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(0.0),
    side: BorderSide(
      color: Colors.grey,
    ),
  ),
  titleStyle: TextStyle(
    color: Colors.red,
  ),
);

class _AddressLineState extends State<AddressLine> {
  bool isDefault;

  @override
  void initState() {
    super.initState();

    setState(() {
      isDefault = widget.myAddresses.defaultAddress == 1 ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(builder: (context, cart, child) {
      return Card(
        elevation: 5,
        color: cart.myCurrentAddresses == widget.myAddresses
            ? Colors.grey
            : Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width - 22,
          margin: EdgeInsets.only(
              bottom: 2, top: isDefault ? 10 : 2, left: 10, right: 10),
          padding: EdgeInsets.only(left: 8, right: 8, top: 12, bottom: 6),
          child: ListTile(
            onTap: () {
              setState(() {
                cart.setDefaultAddress(widget.myAddresses);
              });
            },
            title: Column(
              children: [
                _addressRow(
                    ctx: context,
                    key: "Country",
                    value: widget.myAddresses.countryName),
                _addressRow(
                    ctx: context, key: "City", value: widget.myAddresses.city),
                _addressRow(
                    ctx: context,
                    key: "state",
                    value: widget.myAddresses.state),
                _addressRow(
                    ctx: context,
                    key: "street",
                    value: widget.myAddresses.street),
              ],
            ),
            subtitle: Visibility(
              visible: false,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: OutlineButton.icon(
                          onPressed: () {
                            showAlertDialog(
                                msg: "msg",
                                title: "title",
                                body: "Body",
                                type: AlertType.success);
                          },
                          icon: Icon(Icons.check),
                          label: Text("select"))),
                  Expanded(
                      child: OutlineButton.icon(
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (BuildContext context, _, __) {
                                    return OverLayWidgetWithLoader(false);
                                  }),
                            );
                            Future.delayed(Duration(seconds: 4))
                                .then((value) => {Navigator.pop(context)});
                          },
                          icon: Icon(Icons.check),
                          label: Text("default"))),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void showAlertDialog(
      {String msg, String title, String body, AlertType type}) {
    Alert(
      context: context,
      type: AlertType.warning,
      title: "RFLUTTER ALERT",
      desc: "Flutter is more awesome with RFlutter Alert.",
      buttons: [
        DialogButton(
          child: Text(
            "Done",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
        DialogButton(
          child: Text(
            "GRADIENT",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          gradient: LinearGradient(colors: [
            Color.fromRGBO(116, 116, 191, 1.0),
            Color.fromRGBO(52, 138, 199, 1.0)
          ]),
        )
      ],
    ).show();
  }

  Widget _addressRow({BuildContext ctx, String key, String value}) {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          Text(
            key,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(value),
        ],
      ),
    );
  }
}
