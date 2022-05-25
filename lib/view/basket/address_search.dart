import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart' as gmw;
import 'package:location/location.dart';
import 'package:nandikrushi/provider/places_provider.dart';
import 'package:nandikrushi/provider/theme_provider.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:nandikrushi/reusable_widgets/textfield_widget.dart';

class AddressSearchScreen extends StatefulWidget {
  final Function(List<String>) onSaveAddress;
  const AddressSearchScreen({Key? key, required this.onSaveAddress})
      : super(key: key);

  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  var searchController = TextEditingController();
  var addresses = [];
  LocationData? userLocation;
  var isSearching = true;

  Future<LocationData?> getLocationAndPermission() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    userLocation = await location.getLocation();

    gmw.GoogleMapsPlaces _places =
        gmw.GoogleMapsPlaces(apiKey: PlacesProvider.apiKey);
    gmw.PlacesSearchResponse results = await _places.searchNearbyWithRadius(
        gmw.Location(userLocation?.latitude ?? 0, userLocation?.longitude ?? 0),
        searchController.text.isNotEmpty ? 2500 : 100000,
        keyword: searchController.text);
    addresses = results.results;
    setState(() {
      isSearching = !isSearching;
    });
    return null;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
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
              textInputAction: TextInputAction.search,
              onSubmitField: () {
                setState(() {
                  isSearching = !isSearching;
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
                    return Padding(
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
                          TextWidget(
                            text: addresses[index].name,
                            weight: FontWeight.w500,
                          ),
                        ],
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
