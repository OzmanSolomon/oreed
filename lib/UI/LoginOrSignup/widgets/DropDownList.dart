import 'package:flutter/material.dart';
import 'package:oreed/Models/ApiResponse.dart';
import 'package:oreed/providers/CountryProvider.dart';
import 'package:provider/provider.dart';

// class CountriesDropDown extends StatefulWidget {
//   int flag;
//   CountriesDropDown({this.flag});
//
//   @override
//   _CountriesDropDownState createState() => _CountriesDropDownState();
// }
//
// class _CountriesDropDownState extends State<CountriesDropDown> {
//   Future<ApiResponse> _countries;
//   @override
//   void initState() {
//     super.initState();
//     _countries = CountryRepo().fetchCountryList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future:
//             _countries, // here you provide your future. In your case Provider.of<PeopleModel>(context).fetchPeople()
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           var apiResponse = snapshot.data;
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//               return Container();
//               break;
//             case ConnectionState.waiting:
//               return LoaderFetchingData();
//               break;
//             case ConnectionState.active:
//               return LoaderFetchingData();
//               break;
//             case ConnectionState.done:
//               if (apiResponse.code == 1) {
//                 return Center(
//                   child: DropdownButtonHideUnderline(
//                     child: FittedBox(
//                       child: DropdownButton(
//                           dropdownColor: Colors.white,
//                           value: Provider.of<CountryProvider>(context,
//                                   listen: false)
//                               .currentCountry,
//                           items: List.generate(
//                             apiResponse.object.length,
//                             (index) => DropdownMenuItem(
//                               child: FittedBox(
//                                   child: Text(
//                                       apiResponse.object[index].countriesName)),
//                               value: apiResponse.object[index],
//                             ),
//                           ),
//                           onChanged: (value) {
//                             Provider.of<CountryProvider>(context, listen: false)
//                                 .setCountry(value);
//                             Provider.of<CountryProvider>(context, listen: false)
//                                 .emptyTimeZonesList();
//                             Provider.of<CountryProvider>(context, listen: false)
//                                 .fetchTimeZoneList();
//                           }),
//                     ),
//                   ),
//                 );
//               } else {
//                 return NoData();
//               }
//               break;
//             default:
//               return null;
//               break;
//           }
//         });
//   }
// }

class TimeZoneDropDown extends StatefulWidget {
  @override
  _TimeZoneDropDownState createState() => _TimeZoneDropDownState();
}

class _TimeZoneDropDownState extends State<TimeZoneDropDown> {
  Future _address;
  @override
  void initState() {
    super.initState();
    _address = CountryProvider().fetchTimeZoneList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _address,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      var myTimeZone = snapshot.data;
      return myTimeZone == null || myTimeZone.isEmpty
          ? Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(radius: 12, child: CircularProgressIndicator()),
                  Icon(
                    Icons.details,
                    size: 20,
                  )
                ],
              ),
            )
          : myTimeZone.isNotEmpty
              ? Center(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        dropdownColor: Colors.white,
                        hint: Text('time Zone'),
                        value: myTimeZone.currentTimeZone,
                        items: myTimeZone.timeZoneList,
                        onChanged: (value) {
                          myTimeZone.setTimeZone(value);
                        }),
                  ),
                )
              : Container();
    });
  }
}
