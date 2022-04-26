import 'dart:developer';
import 'dart:io';

import 'package:alt_sms_autofill/alt_sms_autofill.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nandikrushifarmer/model/user.dart';
import 'package:nandikrushifarmer/provider/theme_provider.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/filled_textfield_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/nandi_krushi_title.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushifarmer/view/login/nav_bar.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  PageController pageController = PageController(initialPage: 0);
  var acresInInt = 1.0;
  var checkBoxStates = [true, false, false, false, false, false];
  var user = User();
  String _comingSms = '';
  Future<void> initSmsListener() async {
    String? comingSms;
    try {
      comingSms = await AltSmsAutofill().listenForSms;
    } on PlatformException {
      comingSms = 'Failed to get Sms.';
    }
    if (!mounted) return;
    setState(() {
      _comingSms = comingSms ?? '';
      print("====>Message: ${_comingSms}");
    });
  }

  var formControllers = {
    'farmer_name': TextEditingController(),
    'house_number': TextEditingController(),
    'city': TextEditingController(),
    'mandal': TextEditingController(),
    'district': TextEditingController(),
    'state': TextEditingController(),
    'pincode': TextEditingController(),
    'email': TextEditingController(),
    'password': TextEditingController(),
    'c_password': TextEditingController(),
  };
  var checkBoxStatesText = [
    'Self Declared Natural Farmer',
    'PGS India Green',
    'PGS India Organic',
    'Organic FPO',
    'Organic FPC',
    'Other Certification +'
  ];
  Position? location = null;
  List<Placemark>? locationGeoCoded;

  Future<void> checkLocationPermissionAndGetLocation() async {
    var permissionGranted = await Geolocator.checkPermission();
    if (permissionGranted == LocationPermission.always ||
        permissionGranted == LocationPermission.whileInUse) {
      location = await Geolocator.getLastKnownPosition();
      var isLocationServiceEnabled =
          await Geolocator.isLocationServiceEnabled();
      if (isLocationServiceEnabled) {
        location = await Geolocator.getCurrentPosition();
        geocodeLocation();
      } else {
        Geolocator.openLocationSettings();
      }
    } else {
      var locationPermission = await Geolocator.requestPermission();
      checkLocationPermissionAndGetLocation();
    }
  }

  Future<void> geocodeLocation() async {
    locationGeoCoded =
        await placemarkFromCoordinates(location!.latitude, location!.longitude);
    print(locationGeoCoded);
    formControllers["pincode"]?.text = locationGeoCoded?.first.postalCode ?? "";
    formControllers["state"]?.text =
        locationGeoCoded?.first.administrativeArea ?? "";
    formControllers["district"]?.text =
        locationGeoCoded?.first.subAdministrativeArea ?? "";
    formControllers["city"]?.text = locationGeoCoded?.first.locality ?? "";
    formControllers["house_number"]?.text =
        locationGeoCoded?.first.street ?? "";
    formControllers["mandal"]?.text = locationGeoCoded?.first.subLocality ?? "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLocationPermissionAndGetLocation();
  }

  XFile? image;

  Future<void> getImages(ImageSource imageSource) async {
    ImagePicker _picker = ImagePicker();

    image = await _picker.pickImage(source: imageSource);
    Navigator.of(context).pop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    initSmsListener();
    checkBoxStatesText = SpotmiesTheme.appTheme == UserAppTheme.restaurant
        ? [
            'FSSAI',
            'Eating House License',
            'Fire Safety License',
            'Certificate of Environmental Clearance',
            'Other Certification +'
          ]
        : SpotmiesTheme.appTheme == UserAppTheme.store
            ? [
                'FSSAI',
                'Fire Safety License',
                'Certificate of Environmental Clearance',
                'Other Certification +'
              ]
            : [
                'Self Declared Natural Farmer',
                'PGS India Green',
                'PGS India Organic',
                'Organic FPO',
                'Organic FPC',
                'Other Certification +'
              ];
    return Scaffold(
      body: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: pageController,
        itemCount: 2,
        itemBuilder: (context, pageIndex) {
          return SingleChildScrollView(
            child: SizedBox(
              height: height(context) * 1.2,
              width: width(context),
              child: Stack(
                children: [
                  Positioned(
                    top: -(height(context) * 0.03),
                    left: width(context) * 0.48,
                    child: const Image(
                      image: AssetImage("assets/png/ic_farmer.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height(context) * 0.08),
                    padding:
                        EdgeInsets.symmetric(horizontal: width(context) * 0.1),
                    child: const NandiKrushiTitle(),
                  ),
                  Column(children: [
                    SizedBox(
                      height: height(context) * 0.15,
                    ),
                    TextWidget(
                      text: "Create Account".toUpperCase(),
                      color: const Color(0xFF006838),
                      weight: FontWeight.w900,
                      size: height(context) * 0.02,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(32),
                          ),
                        ),
                        child: Column(
                          children: pageIndex == 0
                              ? [
                                  SizedBox(
                                    height: height(context) *
                                        (image == null ? 0.02 : 0.04),
                                  ),
                                  image == null
                                      ? IconButton(
                                          iconSize: height(context) * 0.1,
                                          color: SpotmiesTheme.primaryColor,
                                          onPressed: () {
                                            showImagePickerSheet();
                                          },
                                          splashRadius: height(context) * 0.05,
                                          icon: const Icon(
                                              Icons.add_a_photo_rounded),
                                        )
                                      : Stack(
                                          children: [
                                            ClipOval(
                                                child: Image.file(
                                              File(image?.path ?? ""),
                                              height: height(context) * 0.17,
                                              width: height(context) * 0.17,
                                              fit: BoxFit.cover,
                                            )),
                                            Positioned(
                                              bottom: 0,
                                              right: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    color: SpotmiesTheme
                                                        .primaryColor,
                                                    shape: BoxShape.circle),
                                                child: IconButton(
                                                  onPressed: () {
                                                    showImagePickerSheet();
                                                  },
                                                  icon: Icon(
                                                    Icons.edit_rounded,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                  image == null
                                      ? TextWidget(
                                          text:
                                              "Add ${SpotmiesTheme.appTheme == UserAppTheme.farmer ? "Farmer" : SpotmiesTheme.appTheme == UserAppTheme.store ? "Store" : "Restaurant"} Image",
                                          color: Colors.grey,
                                          weight: FontWeight.bold,
                                          size: height(context) * 0.02,
                                        )
                                      : SizedBox(),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        horizontal: width(context) * 0.075,
                                        vertical: width(context) *
                                            (image == null ? 0.05 : 0.08)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextWidget(
                                          text:
                                              "${SpotmiesTheme.appTheme == UserAppTheme.farmer ? "Farmer" : SpotmiesTheme.appTheme == UserAppTheme.store ? "Store" : "Restaurant"} Information",
                                          color: Colors.grey.shade800,
                                          weight: FontWeight.bold,
                                          size: height(context) * 0.02,
                                        ),
                                        TextFieldWidget(
                                          controller:
                                              formControllers['farmer_name'],
                                          label:
                                              '${SpotmiesTheme.appTheme == UserAppTheme.farmer ? "Farmer" : SpotmiesTheme.appTheme == UserAppTheme.store ? "Store" : "Restaurant"} Name',
                                          hintSize: 20,
                                          style: fonts(20.0, FontWeight.w500,
                                              Colors.black),
                                        ),
                                        TextFieldWidget(
                                          controller: formControllers['email'],
                                          label: 'Email Address',
                                          hintSize: 20,
                                          style: fonts(20.0, FontWeight.w400,
                                              Colors.black),
                                        ),
                                        TextFieldWidget(
                                          controller:
                                              formControllers['password'],
                                          label: 'Create Password',
                                          obscureText: true,
                                          hintSize: 20,
                                          style: fonts(20.0, FontWeight.w400,
                                              Colors.black),
                                        ),
                                        TextFieldWidget(
                                          controller:
                                              formControllers['c_password'],
                                          label: 'Confirm Password',
                                          hintSize: 20,
                                          obscureText: true,
                                          style: fonts(20.0, FontWeight.w400,
                                              Colors.black),
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.03,
                                        ),
                                        TextWidget(
                                          text: "Location Details",
                                          color: Colors.grey.shade800,
                                          weight: FontWeight.bold,
                                          size: height(context) * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFieldWidget(
                                                controller:
                                                    formControllers['state'],
                                                label: 'State',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.05,
                                            ),
                                            Expanded(
                                              child: TextFieldWidget(
                                                controller:
                                                    formControllers['district'],
                                                label: 'District',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.03,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFieldWidget(
                                                controller:
                                                    formControllers['mandal'],
                                                label: 'Mandal',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.05,
                                            ),
                                            Expanded(
                                              child: TextFieldWidget(
                                                controller:
                                                    formControllers['city'],
                                                label: 'City/Vilage',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    15.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.03,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: TextFieldWidget(
                                                controller: formControllers[
                                                    'house_number'],
                                                label: 'H.No.',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    20.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width(context) * 0.05,
                                            ),
                                            Expanded(
                                              child: TextFieldWidget(
                                                textInputAction:
                                                    TextInputAction.done,
                                                controller:
                                                    formControllers['pincode'],
                                                label: 'Pincode',
                                                hintSize: 20,
                                                hintColor: Colors.grey.shade600,
                                                style: fonts(
                                                    20.0,
                                                    FontWeight.w500,
                                                    Colors.black),
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: height(context) * 0.015,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.bottomCenter,
                                      padding: EdgeInsets.only(
                                          bottom: height(context) * 0.03),
                                      child: ElevatedButtonWidget(
                                        onClick: () {
                                          var farmerName =
                                              formControllers['farmer_name']
                                                      ?.text ??
                                                  "";
                                          var houseNumber =
                                              formControllers['house_number']
                                                      ?.text ??
                                                  "";
                                          var mandal =
                                              formControllers['mandal']?.text ??
                                                  "";
                                          var city =
                                              formControllers['city']?.text ??
                                                  "";
                                          var district =
                                              formControllers['district']
                                                      ?.text ??
                                                  "";
                                          var state =
                                              formControllers['state']?.text ??
                                                  "";
                                          var pincode =
                                              formControllers['pincode']
                                                      ?.text ??
                                                  "";
                                          user = User.registerPartA(
                                              farmerName: farmerName,
                                              city: city,
                                              houseNumber: houseNumber,
                                              district: district,
                                              mandal: mandal,
                                              farmerImage: "IMAGE",
                                              pincode: pincode,
                                              state: state);

                                          log(user.toString());

                                          pageController.animateToPage(
                                              pageIndex + 1,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeInOut);
                                        },
                                        minWidth: width(context) * 0.85,
                                        height: height(context) * 0.06,
                                        borderRadius: 0,
                                        allRadius: true,
                                        bgColor: SpotmiesTheme.primaryColor,
                                        textColor: SpotmiesTheme.appTheme ==
                                                UserAppTheme.restaurant
                                            ? Colors.black
                                            : Colors.white,
                                        buttonName:
                                            (pageIndex == 1 ? "Submit" : "Next")
                                                .toUpperCase(),
                                        innerPadding: 0.02,
                                        textSize: width(context) * 0.045,
                                        // textStyle: FontWeight.bold,
                                        trailingIcon: Icon(
                                          pageIndex == 0
                                              ? Icons.arrow_forward
                                              : Icons.check_rounded,
                                          color: SpotmiesTheme.appTheme ==
                                                  UserAppTheme.restaurant
                                              ? Colors.black
                                              : Colors.white,
                                          size: width(context) * 0.045,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]
                              : [
                                  Container(
                                    padding:
                                        EdgeInsets.all(width(context) * 0.08),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SpotmiesTheme.appTheme ==
                                                UserAppTheme.farmer
                                            ? TextWidget(
                                                text:
                                                    "Cultivated Land Area (in acres)",
                                                color: Colors.grey.shade800,
                                                weight: FontWeight.bold,
                                                size: height(context) * 0.02,
                                              )
                                            : const SizedBox(),
                                        SizedBox(
                                          height: SpotmiesTheme.appTheme ==
                                                  UserAppTheme.farmer
                                              ? height(context) * 0.02
                                              : 0,
                                        ),
                                        SpotmiesTheme.appTheme ==
                                                UserAppTheme.farmer
                                            ? SliderTheme(
                                                data: SliderThemeData(
                                                    activeTickMarkColor:
                                                        SpotmiesTheme
                                                                    .appTheme ==
                                                                UserAppTheme
                                                                    .restaurant
                                                            ? Colors.black
                                                            : Colors.white,
                                                    inactiveTickMarkColor:
                                                        SpotmiesTheme
                                                                    .appTheme ==
                                                                UserAppTheme
                                                                    .restaurant
                                                            ? Colors.black
                                                            : Colors.white),
                                                child: Slider(
                                                    divisions: 30,
                                                    thumbColor:
                                                        const Color(0xFF006838),
                                                    activeColor:
                                                        const Color(0xFF006838),
                                                    inactiveColor:
                                                        const Color(0x16006838),
                                                    value: acresInInt,
                                                    max: 30,
                                                    min: 1,
                                                    label: (acresInInt)
                                                        .round()
                                                        .toString(),
                                                    // ignore: avoid_types_as_parameter_names
                                                    onChanged: (num) {
                                                      log("$num");
                                                      setState(() {
                                                        acresInInt = num;
                                                      });
                                                    }),
                                              )
                                            : const SizedBox(),
                                        SizedBox(
                                          height: height(context) * 0.02,
                                        ),
                                        TextWidget(
                                          text: "Select Certification Details",
                                          color: Colors.grey.shade800,
                                          weight: FontWeight.bold,
                                          size: height(context) * 0.02,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: ListView.builder(
                                          itemCount: checkBoxStatesText.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                setState(() {
                                                  for (int i = 0;
                                                      i <=
                                                          (checkBoxStatesText
                                                                  .length -
                                                              1);
                                                      i++) {
                                                    checkBoxStates[i] = false;
                                                  }
                                                  checkBoxStates[index] = true;
                                                });
                                              },
                                              child: Container(
                                                color: checkBoxStates[index]
                                                    ? SpotmiesTheme.primaryColor
                                                    : Colors.transparent,
                                                child: Column(
                                                  children: [
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Checkbox(
                                                              activeColor: SpotmiesTheme
                                                                          .appTheme ==
                                                                      UserAppTheme
                                                                          .restaurant
                                                                  ? Colors.green[
                                                                      900]
                                                                  : Colors
                                                                      .white,
                                                              checkColor:
                                                                  SpotmiesTheme
                                                                      .primaryColor,
                                                              value:
                                                                  checkBoxStates[
                                                                      index],
                                                              onChanged:
                                                                  (boolean) {
                                                                setState(() {
                                                                  for (int i =
                                                                          0;
                                                                      i <= 5;
                                                                      i++) {
                                                                    checkBoxStates[
                                                                            i] =
                                                                        false;
                                                                  }
                                                                  checkBoxStates[
                                                                          index] =
                                                                      boolean ??
                                                                          false;
                                                                });
                                                              }),
                                                          SizedBox(
                                                            width:
                                                                width(context) *
                                                                    0.6,
                                                            child: TextWidget(
                                                              text:
                                                                  checkBoxStatesText[
                                                                      index],
                                                              weight: FontWeight
                                                                  .w600,
                                                              color: checkBoxStates[
                                                                      index]
                                                                  ? SpotmiesTheme
                                                                              .appTheme ==
                                                                          UserAppTheme
                                                                              .restaurant
                                                                      ? Colors.green[
                                                                          900]
                                                                      : Colors
                                                                          .white
                                                                  : Colors
                                                                      .black,
                                                            ),
                                                          )
                                                        ]),
                                                    (SpotmiesTheme.appTheme ==
                                                                    UserAppTheme
                                                                        .farmer
                                                                ? index != 0
                                                                : true) &&
                                                            index != 5 &&
                                                            checkBoxStates[
                                                                index]
                                                        ? Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                                SizedBox(
                                                                  width: width(
                                                                          context) *
                                                                      0.1,
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    const TextWidget(
                                                                      text:
                                                                          "Reference Number",
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    SizedBox(
                                                                      width: width(
                                                                              context) *
                                                                          0.32,
                                                                      height: height(
                                                                              context) *
                                                                          0.05,
                                                                      child:
                                                                          const FilledTextFieldWidget(
                                                                        label:
                                                                            "",
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    const TextWidget(
                                                                      text:
                                                                          "Upload Certificate",
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        MaterialButton(
                                                                            padding:
                                                                                const EdgeInsets.all(0),
                                                                            color: Colors.white,
                                                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                                            onPressed: () {},
                                                                            child: const TextWidget(
                                                                              text: "Choose File",
                                                                            )),
                                                                        Icon(
                                                                          Icons
                                                                              .archive_rounded,
                                                                          color: Colors
                                                                              .white
                                                                              .withAlpha(150),
                                                                        ),
                                                                      ],
                                                                    )
                                                                  ],
                                                                )
                                                              ])
                                                        : const SizedBox()
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: height(context) * 0.03),
                                    child: ElevatedButtonWidget(
                                      onClick: () {
                                        if (pageIndex == 1) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const NavBar()));
                                        } else {
                                          var farmerName =
                                              formControllers['farmer_name']
                                                      ?.text ??
                                                  "";
                                          var houseNumber =
                                              formControllers['house_number']
                                                      ?.text ??
                                                  "";
                                          var mandal =
                                              formControllers['mandal']?.text ??
                                                  "";
                                          var city =
                                              formControllers['city']?.text ??
                                                  "";
                                          var district =
                                              formControllers['district']
                                                      ?.text ??
                                                  "";
                                          var state =
                                              formControllers['state']?.text ??
                                                  "";
                                          var pincode =
                                              formControllers['pincode']
                                                      ?.text ??
                                                  "";
                                          user = User.registerPartA(
                                              farmerName: farmerName,
                                              city: city,
                                              houseNumber: houseNumber,
                                              district: district,
                                              mandal: mandal,
                                              farmerImage: "IMAGE",
                                              pincode: pincode,
                                              state: state);

                                          log(user.toString());

                                          pageController.animateToPage(
                                              pageIndex + 1,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeInOut);
                                          Navigator.pushAndRemoveUntil(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const NavBar()),
                                              (route) => false);
                                        }
                                      },
                                      minWidth: width(context) * 0.85,
                                      height: height(context) * 0.06,
                                      borderRadius: 0,
                                      allRadius: true,
                                      bgColor: SpotmiesTheme.primaryColor,
                                      textColor: SpotmiesTheme.appTheme ==
                                              UserAppTheme.restaurant
                                          ? Colors.black
                                          : Colors.white,
                                      buttonName:
                                          (pageIndex == 1 ? "Submit" : "Next")
                                              .toUpperCase(),
                                      innerPadding: 0.02,
                                      textSize: width(context) * 0.045,
                                      // textStyle: FontWeight.bold,
                                      trailingIcon: Icon(
                                        pageIndex == 0
                                            ? Icons.arrow_forward
                                            : Icons.check_rounded,
                                        color: SpotmiesTheme.appTheme ==
                                                UserAppTheme.restaurant
                                            ? Colors.black
                                            : Colors.white,
                                        size: width(context) * 0.045,
                                      ),
                                    ),
                                  ),
                                ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void showImagePickerSheet() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: height(context) * 0.2,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: "Choose Profile Picture",
                  size: height(context) * 0.03,
                ),
                TextWidget(
                  text:
                      "Choose an image as a profile picture from one of the following sources",
                  flow: TextOverflow.visible,
                  color: Colors.grey,
                ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: SpotmiesTheme.primaryColor,
                            onPrimary: Colors.white),
                        onPressed: () {
                          getImages(ImageSource.gallery);
                        },
                        child: TextWidget(
                          text: "Gallery",
                          color: Colors.white,
                        ),
                      ),
                      flex: 3,
                    ),
                    Spacer(),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: SpotmiesTheme.primaryColor,
                            onPrimary: Colors.white),
                        onPressed: () {
                          getImages(ImageSource.camera);
                        },
                        child: TextWidget(text: "Camera", color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
