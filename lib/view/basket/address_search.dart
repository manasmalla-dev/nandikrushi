import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart' as gmw;
import 'package:http/http.dart';
import 'package:location/location.dart';
import 'package:nandikrushi/provider/places_provider.dart';
import 'package:nandikrushi/provider/theme_provider.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:nandikrushi/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi/view/basket/add_address.dart';
import 'package:uuid/uuid.dart';

class AddressSearchScreen extends StatefulWidget {
  final Function(List<String>) onSaveAddress;
  const AddressSearchScreen({Key? key, required this.onSaveAddress})
      : super(key: key);

  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  var searchController = TextEditingController();
  List<gmw.PlacesSearchResult> addresses = [];
  Position? userLocation;
  var isSearching = true;

  Future<Position?> getLocationAndPermission() async {
    bool _serviceEnabled;

    LocationPermission _permissionGranted;

    _serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await Location().requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await Geolocator.checkPermission();
    print(_permissionGranted);
    if (_permissionGranted == LocationPermission.denied) {
      _permissionGranted = await Geolocator.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    userLocation = await Geolocator.getCurrentPosition();
    print(userLocation);

    gmw.GoogleMapsPlaces _places =
        gmw.GoogleMapsPlaces(apiKey: PlacesProvider.apiKey);
    gmw.PlacesSearchResponse results = await _places
        .searchNearbyWithRadius(
            gmw.Location(
                lat: userLocation?.latitude ?? 0,
                lng: userLocation?.longitude ?? 0),
            searchController.text.isNotEmpty ? 20000 : 100000,
            keyword: searchController.text)
        .timeout(Duration(seconds: 10));
    addresses = results.results;
    setState(() {
      isSearching = false;
    });

    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getLocationAndPermission();
      //print(userLocation);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height(context) * 0.09,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[900],
            )),
        title: SizedBox(
          width: double.infinity,
          height: height(context) * 0.08,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: TextFieldWidget(
              onEdit: (_) {
                setState(() {
                  isSearching = true;
                  getLocationAndPermission();
                });
              },
              textInputAction: TextInputAction.search,
              onSubmitField: () {
                setState(() {
                  isSearching = true;
                  getLocationAndPermission();
                });
              },
              controller: searchController,
              label: "Search",
              style:
                  fonts(height(context) * 0.022, FontWeight.w500, Colors.black),
              suffix: Container(
                margin: EdgeInsets.all(height(context) * 0.01),
                child: ClipOval(
                    child: Container(
                        color: SpotmiesTheme.primaryColor,
                        padding: const EdgeInsets.all(0),
                        child: const Icon(
                          Icons.search_rounded,
                          color: Colors.white,
                        ))),
              ),
            ),
          ),
        ),
      ),
      body: !isSearching
          ? addresses.isNotEmpty
              ? ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: ((context, index) {
                    return InkWell(
                      onTap: () {
                        final sessionToken = Uuid().v4();
                        final request =
                            'https://maps.googleapis.com/maps/api/place/details/json?place_id=${addresses[index].placeId}&fields=address_component&key=${PlacesProvider.apiKey}&sessiontoken=$sessionToken';
                        get(Uri.parse(request)).then((value) {
                          List<dynamic> address =
                              jsonDecode(value.body)["result"]
                                  ["address_components"];
                          print(address);
                          var postalCode = address.firstWhere((value) {
                            List<dynamic> types = value["types"];
                            var isPCorPremise = types.contains("postal_code");
                            return isPCorPremise;
                          }, orElse: () {
                            return {"long_name": ""};
                          })["long_name"];
                          var premise = address.firstWhere((value) {
                            List<dynamic> types = value["types"];
                            var isPCorPremise = types.contains("premise");
                            return isPCorPremise;
                          }, orElse: () {
                            return {"long_name": ""};
                          })["long_name"];
                          address.retainWhere((value) {
                            List<dynamic> types = value["types"];
                            var isPCorPremise = types.contains("postal_code") ||
                                types.contains("premise");
                            print(isPCorPremise);
                            return !isPCorPremise;
                          });
                          var tempData = address
                              .map(
                                (e) => e["long_name"].toString(),
                              )
                              .toSet()
                              .toList();
                          tempData.insert(0, addresses[index].name);
                          var data = tempData.join(", ");
                          //print(data);
                          var geolocatedLocationAddress = {
                            "address": data.toString(),
                            "postal_code": postalCode.toString(),
                            "premise": premise.toString()
                          };
                          print(geolocatedLocationAddress);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => AddAddressScreen(
                                onSaveAddress: widget.onSaveAddress,
                                geolocatedLocationAddress:
                                    geolocatedLocationAddress,
                              ),
                            ),
                          );
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: width(context) * 0.02,
                            ),
                            Icon(
                              Icons.location_on,
                              color: SpotmiesTheme.primaryColor,
                            ),
                            SizedBox(
                              width: width(context) * 0.05,
                            ),
                            Flexible(
                              child: TextWidget(
                                text: addresses[index].name,
                                weight: FontWeight.w500,
                                flow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: addresses.length,
                )
              : SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset("assets/png/delivery_address.png"),
                      SizedBox(
                        height: height(context) * 0.03,
                      ),
                      TextWidget(
                        text: "Oops!",
                        weight: FontWeight.bold,
                        align: TextAlign.center,
                        size: height(context) * 0.05,
                        color: SpotmiesTheme.primaryColor,
                      ),
                      TextWidget(
                        text: "We didn't find that place...",
                        weight: FontWeight.w500,
                        align: TextAlign.center,
                        size: height(context) * 0.03,
                        color: SpotmiesTheme.primaryColor,
                      ),
                    ],
                  ),
                )
          : SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: SpotmiesTheme.primaryColor,
                  ),
                  SizedBox(
                    height: height(context) * 0.03,
                  ),
                  TextWidget(
                    text: "Loading...",
                    weight: FontWeight.bold,
                    align: TextAlign.center,
                    size: height(context) * 0.03,
                    color: SpotmiesTheme.primaryColor,
                  ),
                ],
              ),
            ),
    );
  }
}
