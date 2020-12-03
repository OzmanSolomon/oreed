import 'package:flutter/material.dart';
import 'package:oreeed/Models/ApiResponse.dart';
import 'package:oreeed/Models/CountryModel.dart';
import 'package:oreeed/Models/TimeZone.dart';
import 'package:oreeed/Services/CountryRepo.dart';
import 'package:oreeed/providers/CountryProvider.dart';
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
  List<DropdownMenuItem<TimeZone>> dropdownTimeZones;
  bool _isLoadingTimeZone = false;
  Country _selectedCountry;
  Country get currentCountry => _selectedCountry;
  TimeZone _selectedTimeZone;


  void fetchTimeZoneList() async {
    _isLoadingTimeZone = true;
    try {
      String countryId = currentCountry == null
          ? "199"
          : currentCountry.countriesId.toString();
      CountryRepo().fetchTimeZoneList(countryId).then((apiResponse) {
        if (apiResponse != null) {
          switch (apiResponse.code) {
            case 1:
              dropdownTimeZones = [];
              for (TimeZone timeZone in apiResponse.object) {
                dropdownTimeZones.add(
                  DropdownMenuItem(
                    child: Text(timeZone.zoneName),
                    value: timeZone,
                  ),
                );
              }
              _isLoadingTimeZone = false;
              if (this.mounted) {
                setState(() {});
              }
              break;
            default:
              break;
          }
        } else {}
      });
    } catch (Exception) {
      _isLoadingTimeZone = false;

      print("Exception:$Exception");
      setState(() {});
    }
  }

  void setTimeZone(TimeZone timeZone) {
    _selectedTimeZone = timeZone;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchTimeZoneList();
  }

  @override
  Widget build(BuildContext context) {
    return _isLoadingTimeZone || dropdownTimeZones == null
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
        : dropdownTimeZones.isNotEmpty
            ? Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                      dropdownColor: Colors.white,
                      hint: Text('time Zone'),
                      value: _selectedTimeZone,
                      items: dropdownTimeZones,
                      onChanged: (value) {
                        setTimeZone(value);
                        Provider.of<CountryProvider>(context, listen: false)
                            .setTimeZone(value);
                      }),
                ),
              )
            : Container();
  }
}
