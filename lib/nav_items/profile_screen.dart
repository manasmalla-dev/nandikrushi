// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nandikrushi/nav_items/profile_address_workflow.dart';
import 'package:nandikrushi/nav_items/profile_provider.dart';
import 'package:nandikrushi/onboarding/login_controller.dart';
import 'package:nandikrushi/onboarding/login_provider.dart';
import 'package:nandikrushi/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi/reusable_widgets/loader_screen.dart';
import 'package:nandikrushi/reusable_widgets/material_you_clipper.dart';
import 'package:nandikrushi/reusable_widgets/snackbar.dart';
import 'package:nandikrushi/reusable_widgets/text_widget.dart';
import 'package:nandikrushi/reusable_widgets/textfield_widget.dart';
import 'package:nandikrushi/utils/firebase_storage_utils.dart';
import 'package:nandikrushi/utils/server.dart';
import 'package:nandikrushi/utils/size_config.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LoginController loginPageController = LoginController();
  @override
  void initState() {
    super.initState();
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    loginPageController.getDataFromProvider(profileProvider);
  }

  @override
  Widget build(BuildContext context) {
    void showImagePickerSheet(
        {required Function(XFile) onImageSelected,
        required BoxConstraints constraints}) {
      showModalBottomSheet(
          context: context,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return Consumer<ProfileProvider>(
                  builder: (context, profileProvider, _) {
                return Container(
                  height: getProportionateHeight(300, constraints),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        "Choose Profile Picture",
                        size: Theme.of(context).textTheme.titleLarge?.fontSize,
                        weight: FontWeight.bold,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      TextWidget(
                        "Choose an image as a profile picture from one of the following sources",
                        flow: TextOverflow.visible,
                        size: Theme.of(context).textTheme.bodyLarge?.fontSize,
                        weight:
                            Theme.of(context).textTheme.bodyLarge?.fontWeight,
                      ),
                      const Spacer(),
                      Row(
                        children: const [
                          Expanded(
                            flex: 3,
                            child: Icon(Icons.photo_library_rounded, size: 48),
                          ),
                          Spacer(),
                          Expanded(
                            flex: 3,
                            child: Icon(Icons.camera_alt_rounded, size: 48),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () async {
                                var pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {
                                  Navigator.of(context).pop();
                                  if (pickedImage != null) {
                                    onImageSelected(pickedImage);
                                  } else {
                                    Future.delayed(
                                        const Duration(milliseconds: 300), () {
                                      snackbar(context,
                                          "The image you selected is empty or you didn't select an image.");
                                    });
                                  }
                                });
                              },
                              child: const Text(
                                "Gallery",
                              ),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 3,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Theme.of(context).colorScheme.onPrimary,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              onPressed: () async {
                                var pickedImage = await ImagePicker()
                                    .pickImage(source: ImageSource.camera);
                                setState(() {
                                  Navigator.of(context).pop();
                                  if (pickedImage != null) {
                                    onImageSelected(pickedImage);
                                  } else {
                                    Future.delayed(
                                        const Duration(milliseconds: 300), () {
                                      snackbar(context,
                                          "The image you selected is empty or you didn't select an image.");
                                    });
                                  }
                                });
                              },
                              child: const Text("Camera"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
            });
          });
    }

    return Consumer<ProfileProvider>(builder: (context, profileProvider, _) {
      return Consumer<LoginProvider>(builder: (context, loginProvider, _) {
        var phoneNumberController = TextEditingController();
        return Stack(
          children: [
            LayoutBuilder(builder: (context, constraints) {
              return Scaffold(
                  appBar: AppBar(
                    toolbarHeight: kToolbarHeight,
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    automaticallyImplyLeading: false,
                    title: Row(
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.person_pin_rounded,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        TextWidget(
                          'Profile',
                          size:
                              Theme.of(context).textTheme.titleMedium?.fontSize,
                          weight: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.fontWeight,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ],
                    ),
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 32),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 16.0),
                        //   child: SizedBox(
                        //     height: 200,
                        //     child: Row(
                        //       children: [
                        //         Expanded(
                        //           child: Column(
                        //             crossAxisAlignment:
                        //                 CrossAxisAlignment.start,
                        //             children: const [
                        //               // Text(
                        //               //     loginProvider.userAppTheme.key),
                        //               // ListView.builder(
                        //               //     primary: false,
                        //               //     shrinkWrap: true,
                        //               //     itemBuilder: (context, index) {
                        //               //       loginProvider.availableUserTypes =
                        //               //           loginProvider.availableUserTypes
                        //               //                   .isEmpty
                        //               //               ? {
                        //               //                   "Farmers ": const Color(
                        //               //                       0xFF006838),
                        //               //                   "Organic Stores":
                        //               //                       const Color(
                        //               //                           0xFF00bba8),
                        //               //                   "Organic Restaurants":
                        //               //                       const Color(
                        //               //                           0xFFffd500),
                        //               //                 }
                        //               //               : loginProvider
                        //               //                   .availableUserTypes;
                        //               //       print(loginProvider
                        //               //           .availableUserTypes.keys);
                        //               //       print(
                        //               //           loginProvider.userAppTheme.key);
                        //               //       return Row(
                        //               //         mainAxisSize: MainAxisSize.min,
                        //               //         children: [
                        //               //           Flexible(
                        //               //             child: Radio<String>(
                        //               //               activeColor:
                        //               //                   Theme.of(context)
                        //               //                       .colorScheme
                        //               //                       .primary,
                        //               //               value: loginProvider
                        //               //                   .availableUserTypes.keys
                        //               //                   .toList()[index],
                        //               //               groupValue: loginProvider
                        //               //                   .userAppTheme.key,
                        //               //               onChanged: (_) {
                        //               //                 loginProvider
                        //               //                     .updateUserAppType(
                        //               //                         loginProvider
                        //               //                             .availableUserTypes
                        //               //                             .entries
                        //               //                             .elementAt(
                        //               //                                 index));
                        //               //               },
                        //               //             ),
                        //               //           ),
                        //               //           Text(
                        //               //             loginProvider
                        //               //                 .availableUserTypes.keys
                        //               //                 .toList()[index],
                        //               //             style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        //               //                 color: loginProvider
                        //               //                             .userAppTheme
                        //               //                             .key ==
                        //               //                         loginProvider
                        //               //                                 .availableUserTypes
                        //               //                                 .keys
                        //               //                                 .toList()[
                        //               //                             index]
                        //               //                     ? Theme.of(context)
                        //               //                         .colorScheme
                        //               //                         .primary
                        //               //                     : null,
                        //               //                 fontWeight: loginProvider
                        //               //                             .userAppTheme
                        //               //                             .key ==
                        //               //                         loginProvider
                        //               //                             .availableUserTypes
                        //               //                             .keys
                        //               //                             .toList()[index]
                        //               //                     ? FontWeight.w500
                        //               //                     : null),
                        //               //           ),
                        //               //         ],
                        //               //       );
                        //               //     },
                        //               //     itemCount: 3),
                        //             ],
                        //           ),
                        //         ),
                        //         Spacer(),
                        //         Flexible(
                        //             child: Stack(
                        //           clipBehavior: Clip.none,
                        //           children: [
                        //             Positioned(
                        //               width: 300,
                        //               height: 300,
                        //               top: -130,
                        //               child: ClipPath(
                        //                 clipBehavior:
                        //                     Clip.antiAliasWithSaveLayer,
                        //                 clipper: MaterialClipper(),
                        //                 child: GoogleMap(
                        //                   markers: {
                        //                     Marker(
                        //                       markerId: const MarkerId("Home"),
                        //                       position: LatLng(
                        //                           double.tryParse(profileProvider
                        //                                           .storeAddress[
                        //                                       "coordinates-x"] ??
                        //                                   "17.744062") ??
                        //                               17.744062,
                        //                           double.tryParse(profileProvider
                        //                                           .storeAddress[
                        //                                       "coordinates-y"] ??
                        //                                   "83.335216") ??
                        //                               83.335216),
                        //                     ),
                        //                   },
                        //                   onTap: (_) {},
                        //                   initialCameraPosition: CameraPosition(
                        //                     bearing: 0,
                        //                     target: LatLng(
                        //                         double.tryParse(profileProvider
                        //                                         .storeAddress[
                        //                                     "coordinates-x"] ??
                        //                                 "17.744062") ??
                        //                             17.744062,
                        //                         (double.tryParse(profileProvider
                        //                                         .storeAddress[
                        //                                     "coordinates-y"] ??
                        //                                 "83.335216") ??
                        //                             83.335216)),
                        //                     tilt: 0,
                        //                     zoom: 15,
                        //                   ),
                        //                   onMapCreated:
                        //                       (GoogleMapController controller) {
                        //                     //_controller.complete(controller);
                        //                   },
                        //                 ),
                        //               ),
                        //             ),
                        //             Positioned(
                        //               width: 300,
                        //               height: 300,
                        //               top: -130,
                        //               child: ClipPath(
                        //                 clipper: MaterialClipper(),
                        //                 clipBehavior:
                        //                     Clip.antiAliasWithSaveLayer,
                        //                 child: InkWell(
                        //                   splashColor: Colors.transparent,
                        //                   onTap: () {
                        //                     Navigator.of(context).push(
                        //                         MaterialPageRoute(
                        //                             builder: (context) =>
                        //                                 ProfileAddressWorkflow(
                        //                                   controller:
                        //                                       loginPageController,
                        //                                   constraints:
                        //                                       constraints,
                        //                                 )));
                        //                   },
                        //                   child: Container(
                        //                     color: Theme.of(context)
                        //                         .colorScheme
                        //                         .primary
                        //                         .withOpacity(0.5),
                        //                   ),
                        //                 ),
                        //               ),
                        //             ),
                        //             const Positioned(
                        //               top: 50,
                        //               left: 100,
                        //               child: Icon(
                        //                 Icons.edit_rounded,
                        //                 color: Colors.white,
                        //               ),
                        //             ),
                        //             Positioned(
                        //               bottom: 0,
                        //               child: Container(
                        //                 height: 120,
                        //                 width: 120,
                        //                 decoration: BoxDecoration(
                        //                   color: !(!(loginPageController
                        //                                       .profileImage !=
                        //                                   null ||
                        //                               profileProvider
                        //                                   .sellerImage
                        //                                   .isNotEmpty) ||
                        //                           loginPageController
                        //                                   .storeLogo !=
                        //                               null ||
                        //                           profileProvider
                        //                               .storeLogo.isNotEmpty)
                        //                       ? Theme.of(context)
                        //                           .colorScheme
                        //                           .primary
                        //                           .withOpacity(0.2)
                        //                       : Colors.transparent,
                        //                   borderRadius:
                        //                       BorderRadius.circular(20),
                        //                 ),
                        //                 child: Row(
                        //                   children: [
                        //                     loginProvider.isFarmer
                        //                         ? (loginPageController
                        //                                         .profileImage !=
                        //                                     null ||
                        //                                 profileProvider
                        //                                     .sellerImage
                        //                                     .isNotEmpty)
                        //                             ? Expanded(
                        //                                 child: Center(
                        //                                   child: SizedBox(
                        //                                     width: 120,
                        //                                     child: Stack(
                        //                                       children: [
                        //                                         Center(
                        //                                           child:
                        //                                               ClipOval(
                        //                                             child: loginPageController.profileImage !=
                        //                                                     null
                        //                                                 ? Image
                        //                                                     .file(
                        //                                                     File(loginPageController.profileImage?.path ??
                        //                                                         ""),
                        //                                                     height:
                        //                                                         96,
                        //                                                     width:
                        //                                                         96,
                        //                                                     fit:
                        //                                                         BoxFit.cover,
                        //                                                   )
                        //                                                 : Image
                        //                                                     .network(
                        //                                                     profileProvider.sellerImage,
                        //                                                     height:
                        //                                                         96,
                        //                                                     width:
                        //                                                         96,
                        //                                                     fit:
                        //                                                         BoxFit.cover,
                        //                                                   ),
                        //                                           ),
                        //                                         ),
                        //                                         Positioned(
                        //                                           bottom: 0,
                        //                                           right: 0,
                        //                                           child:
                        //                                               Container(
                        //                                             width: 32,
                        //                                             height: 32,
                        //                                             decoration: BoxDecoration(
                        //                                                 color: Theme.of(context)
                        //                                                     .colorScheme
                        //                                                     .primary,
                        //                                                 shape: BoxShape
                        //                                                     .circle),
                        //                                             child:
                        //                                                 IconButton(
                        //                                               onPressed:
                        //                                                   () {
                        //                                                 showImagePickerSheet(
                        //                                                     constraints:
                        //                                                         constraints,
                        //                                                     onImageSelected:
                        //                                                         (XFile profileImage) {
                        //                                                       setState(() {
                        //                                                         loginPageController.profileImage = profileImage;
                        //                                                       });
                        //                                                     });
                        //                                               },
                        //                                               icon: Icon(
                        //                                                   Icons
                        //                                                       .edit_rounded,
                        //                                                   color: Theme.of(context)
                        //                                                       .colorScheme
                        //                                                       .onPrimary,
                        //                                                   size:
                        //                                                       16),
                        //                                             ),
                        //                                           ),
                        //                                         ),
                        //                                       ],
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                               )
                        //                             : Expanded(
                        //                                 child: Center(
                        //                                   child: Column(
                        //                                     mainAxisSize:
                        //                                         MainAxisSize
                        //                                             .min,
                        //                                     children: [
                        //                                       IconButton(
                        //                                         iconSize: 75,
                        //                                         color: Theme.of(
                        //                                                 context)
                        //                                             .colorScheme
                        //                                             .primary,
                        //                                         onPressed: () {
                        //                                           showImagePickerSheet(
                        //                                               constraints:
                        //                                                   constraints,
                        //                                               onImageSelected:
                        //                                                   (XFile
                        //                                                       profileImage) {
                        //                                                 loginPageController.profileImage =
                        //                                                     profileImage;
                        //                                               });
                        //                                         },
                        //                                         splashRadius:
                        //                                             42,
                        //                                         icon: const Icon(
                        //                                             Icons
                        //                                                 .add_a_photo_rounded),
                        //                                       ),
                        //                                       TextWidget(
                        //                                         "Add ${loginProvider.isFarmer ? "Farmer" : "your"} Image",
                        //                                         color: Theme.of(
                        //                                                 context)
                        //                                             .colorScheme
                        //                                             .primary
                        //                                             .withOpacity(
                        //                                                 0.7),
                        //                                         weight: Theme.of(
                        //                                                 context)
                        //                                             .textTheme
                        //                                             .bodyLarge
                        //                                             ?.fontWeight,
                        //                                         size: Theme.of(
                        //                                                 context)
                        //                                             .textTheme
                        //                                             .bodyLarge
                        //                                             ?.fontSize,
                        //                                       )
                        //                                     ],
                        //                                   ),
                        //                                 ),
                        //                               )
                        //                         : const SizedBox(),
                        //                     !loginProvider.isFarmer
                        //                         ? !(loginPageController
                        //                                         .storeLogo !=
                        //                                     null ||
                        //                                 profileProvider
                        //                                     .storeLogo
                        //                                     .isNotEmpty)
                        //                             ? Expanded(
                        //                                 child: Center(
                        //                                   child: Column(
                        //                                     mainAxisSize:
                        //                                         MainAxisSize
                        //                                             .min,
                        //                                     children: [
                        //                                       IconButton(
                        //                                         iconSize: 75,
                        //                                         color: Theme.of(
                        //                                                 context)
                        //                                             .colorScheme
                        //                                             .primary,
                        //                                         onPressed: () {
                        //                                           showImagePickerSheet(
                        //                                               constraints:
                        //                                                   constraints,
                        //                                               onImageSelected:
                        //                                                   (XFile
                        //                                                       storeLogo) {
                        //                                                 loginPageController.storeLogo =
                        //                                                     storeLogo;
                        //                                               });
                        //                                         },
                        //                                         splashRadius:
                        //                                             42,
                        //                                         icon: const Icon(
                        //                                             Icons
                        //                                                 .add_a_photo_rounded),
                        //                                       ),
                        //                                       TextWidget(
                        //                                         "Add ${loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"} Logo",
                        //                                         color: Theme.of(
                        //                                                 context)
                        //                                             .colorScheme
                        //                                             .primary
                        //                                             .withOpacity(
                        //                                                 0.7),
                        //                                         weight: Theme.of(
                        //                                                 context)
                        //                                             .textTheme
                        //                                             .bodyLarge
                        //                                             ?.fontWeight,
                        //                                         size: Theme.of(
                        //                                                 context)
                        //                                             .textTheme
                        //                                             .bodyLarge
                        //                                             ?.fontSize,
                        //                                       )
                        //                                     ],
                        //                                   ),
                        //                                 ),
                        //                               )
                        //                             : Expanded(
                        //                                 child: Center(
                        //                                   child: SizedBox(
                        //                                     width: 96,
                        //                                     child: Stack(
                        //                                       children: [
                        //                                         Center(
                        //                                           child:
                        //                                               ClipOval(
                        //                                             child: loginPageController.storeLogo !=
                        //                                                     null
                        //                                                 ? Image
                        //                                                     .file(
                        //                                                     File(loginPageController.storeLogo?.path ??
                        //                                                         ""),
                        //                                                     height:
                        //                                                         96,
                        //                                                     width:
                        //                                                         96,
                        //                                                     fit:
                        //                                                         BoxFit.cover,
                        //                                                   )
                        //                                                 : Image
                        //                                                     .network(
                        //                                                     profileProvider.storeLogo,
                        //                                                     height:
                        //                                                         96,
                        //                                                     width:
                        //                                                         96,
                        //                                                     fit:
                        //                                                         BoxFit.cover,
                        //                                                   ),
                        //                                           ),
                        //                                         ),
                        //                                         Positioned(
                        //                                           bottom: 0,
                        //                                           right: 0,
                        //                                           child:
                        //                                               Container(
                        //                                             width: 32,
                        //                                             height: 32,
                        //                                             decoration: BoxDecoration(
                        //                                                 color: Theme.of(context)
                        //                                                     .colorScheme
                        //                                                     .primary,
                        //                                                 shape: BoxShape
                        //                                                     .circle),
                        //                                             child:
                        //                                                 IconButton(
                        //                                               onPressed:
                        //                                                   () {
                        //                                                 showImagePickerSheet(
                        //                                                     constraints:
                        //                                                         constraints,
                        //                                                     onImageSelected:
                        //                                                         (XFile storeLogo) {
                        //                                                       setState(() {
                        //                                                         loginPageController.storeLogo = storeLogo;
                        //                                                       });
                        //                                                     });
                        //                                               },
                        //                                               icon:
                        //                                                   Icon(
                        //                                                 Icons
                        //                                                     .edit_rounded,
                        //                                                 color: Theme.of(context)
                        //                                                     .colorScheme
                        //                                                     .onPrimary,
                        //                                                 size:
                        //                                                     16,
                        //                                               ),
                        //                                             ),
                        //                                           ),
                        //                                         ),
                        //                                       ],
                        //                                     ),
                        //                                   ),
                        //                                 ),
                        //                               )
                        //                         : const SizedBox()
                        //                   ],
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         )),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                          ),
                          child: Form(
                            key: loginPageController.registrationFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(
                                  "Your Information",
                                  color: Colors.grey.shade800,
                                  weight: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontWeight,
                                  size: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.fontSize,
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'first_name'],
                                        label: "First Name",
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid first name");
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'last_name'],
                                        label: "Last Name",
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid last name");
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                TextFieldWidget(
                                  controller: loginPageController
                                      .registrationPageFormControllers['email'],
                                  label: 'Email Address',
                                  validator: (value) {
                                    if (!(value?.contains("@") ?? false) &&
                                        !(value?.contains(".") ?? false)) {
                                      return snackbar(context,
                                          "Please enter a valid email address");
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'password'],
                                        label: 'Create Password',
                                        obscureText: true,
                                        validator: (value) {
                                          if (value?.isEmpty ?? false) {
                                            return snackbar(context,
                                                "Please enter a valid password");
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: 24),
                                    Expanded(
                                      child: TextFieldWidget(
                                        controller: loginPageController
                                                .registrationPageFormControllers[
                                            'c_password'],
                                        label: 'Confirm Password',
                                        obscureText: true,
                                        validator: (value) {
                                          if ((value?.isEmpty ?? false) &&
                                              value ==
                                                  loginPageController
                                                      .registrationPageFormControllers[
                                                          'password']
                                                      ?.text
                                                      .toString()) {
                                            return snackbar(context,
                                                "Oops! Passwords mismatch");
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),

                                // Padding(
                                //   padding:
                                //       const EdgeInsets.symmetric(vertical: 8.0),
                                //   child: Divider(
                                //     color: Theme.of(context)
                                //         .colorScheme
                                //         .primary
                                //         ?.withOpacity(0.5),
                                //   ),
                                // ),
                                SizedBox(
                                  height: 32,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.delete_rounded,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            ?.withOpacity(0.5),
                                      ),
                                      Text(
                                        "Delete account",
                                        style: Theme.of(context)
                                            .textTheme
                                            .button
                                            ?.copyWith(
                                                color: Theme.of(context)
                                                    .colorScheme
                                                    .primary
                                                    ?.withOpacity(0.5)),
                                      )
                                    ],
                                  ),
                                )
                                // const SizedBox(
                                //   height: 32,
                                // ),
                                // TextWidget(
                                //   "Location Details",
                                //   color: Colors.grey.shade800,
                                //   weight: Theme.of(context)
                                //       .textTheme
                                //       .titleMedium
                                //       ?.fontWeight,
                                //   size: Theme.of(context)
                                //       .textTheme
                                //       .titleMedium
                                //       ?.fontSize,
                                // ),
                                // const SizedBox(
                                //   height: 16,
                                // ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          child: ElevatedButtonWidget(
                              onClick: () async {
                                // var formValidatedState = loginPageController
                                //         .registrationFormKey.currentState
                                //         ?.validate() ??
                                //     false;

                                // if (formValidatedState) {
                                //   if (!(loginPageController.profileImage !=
                                //               null ||
                                //           profileProvider
                                //               .sellerImage.isNotEmpty) &&
                                //       loginProvider.isFarmer) {
                                //     formValidatedState = false;
                                //     snackbar(
                                //         context,
                                //         "Please upload ${loginProvider.isFarmer ? "the Farmer" : loginProvider.userAppTheme.key.contains("Store") ? "your" : "your"} image");
                                //   }
                                //   if (!loginProvider.isFarmer) {
                                //     if (!(loginPageController.storeLogo !=
                                //             null ||
                                //         profileProvider.storeLogo.isNotEmpty)) {
                                //       formValidatedState = false;
                                //       snackbar(context,
                                //           "Please upload the ${loginProvider.userAppTheme.key.contains("Store") ? "Store" : "Restaurant"}'s logo");
                                //     }
                                //   }

                                //   if (formValidatedState) {
                                //     var formValidatedState = loginPageController
                                //             .registrationFormSecondPageKey
                                //             .currentState
                                //             ?.validate() ??
                                //         true;

                                //     if (!loginProvider.isFarmer ||
                                //         loginPageController.landInAcres > 1) {
                                //       if (formValidatedState &&
                                //           loginPageController
                                //               .userCertification.isNotEmpty) {
                                //         if ((loginPageController
                                //                     .userCertification
                                //                     .isNotEmpty &&
                                //                 loginPageController
                                //                     .userCertificates
                                //                     .where((element) =>
                                //                         element.isNotEmpty)
                                //                     .isNotEmpty) ||
                                //             loginPageController
                                //                     .registrationFormSecondPageKey
                                //                     .currentState ==
                                //                 null) {
                                //           profileProvider.showLoader();

                                //           Map<String, String> userAddress = {
                                //             "coordinates-x":
                                //                 (loginPageController.location
                                //                             ?.latitude ??
                                //                         0)
                                //                     .toString(),
                                //             "coordinates-y":
                                //                 (loginPageController.location
                                //                             ?.longitude ??
                                //                         0)
                                //                     .toString(),
                                //             "houseNumber": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "house_number"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             "city": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "city"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             "mandal": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "mandal"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             "district": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "district"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             "state": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "state"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             "pincode": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "pincode"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 ""
                                //           };

                                //           var sellerImageURL =
                                //               loginPageController
                                //                           .profileImage !=
                                //                       null
                                //                   ? await uploadFilesToCloud(
                                //                       loginPageController
                                //                           .profileImage,
                                //                       cloudLocation:
                                //                           "profile_pics")
                                //                   : profileProvider.sellerImage;
                                //           var storeLogoURL = "";
                                //           if (!loginProvider.isFarmer) {
                                //             storeLogoURL =
                                //                 loginPageController.storeLogo !=
                                //                         null
                                //                     ? await uploadFilesToCloud(
                                //                         loginPageController
                                //                             .storeLogo,
                                //                         cloudLocation: "logo")
                                //                     : profileProvider.storeLogo;
                                //           }
                                //           List<String> certificatesURLs = [];
                                //           if (loginPageController
                                //               .userCertificates
                                //               .where(
                                //                   (element) => element.isEmpty)
                                //               .isNotEmpty) {
                                //             await Future.forEach<XFile>(
                                //                 loginPageController
                                //                     .userCertificates
                                //                     .firstWhere((element) =>
                                //                         element.isNotEmpty),
                                //                 (element) async {
                                //               String urlData =
                                //                   await uploadFilesToCloud(
                                //                       element,
                                //                       cloudLocation:
                                //                           "legal_docs",
                                //                       fileType: ".jpg");
                                //               certificatesURLs.add(urlData);
                                //             });
                                //           }
                                //           print(userAddress);
                                //           Map<String, String> body = {
                                //             "user_id": profileProvider
                                //                 .userIdForAddress,

                                //             "email": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "email"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             "telephone": FirebaseAuth.instance
                                //                     .currentUser?.phoneNumber
                                //                     ?.replaceFirst("+91", "") ??
                                //                 phoneNumberController.text,
                                //             "password": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "password"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             "confirm": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "password"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             "seller_type": loginProvider
                                //                 .userAppTheme.key
                                //                 .toString(),

                                //             "additional_documents":
                                //                 loginPageController
                                //                     .userCertification,
                                //             "upload_document": certificatesURLs
                                //                 .toString(), //TODO: Check with backend on how to parse data
                                //             "store_address":
                                //                 userAddress.toString(),
                                //             "language": (loginProvider
                                //                         .languages.entries
                                //                         .toList()
                                //                         .indexOf(loginProvider
                                //                             .usersLanguage) +
                                //                     1)
                                //                 .toString(),

                                //             "certificate_id": loginPageController
                                //                     .registrationPageFormControllers[
                                //                         "reg_number"]
                                //                     ?.text
                                //                     .toString() ??
                                //                 "",
                                //             // "agree": "1"
                                //           };
                                //           if (!loginProvider.isFarmer) {
                                //             body.addEntries([
                                //               MapEntry(
                                //                   "store_name",
                                //                   loginPageController
                                //                           .registrationPageFormControllers[
                                //                               "storeName"]
                                //                           ?.text
                                //                           .toString() ??
                                //                       ""),
                                //               MapEntry(
                                //                 "store_logo",
                                //                 storeLogoURL.toString(),
                                //               )
                                //             ]);
                                //           } else {
                                //             body.addEntries([
                                //               MapEntry("seller_storename",
                                //                   "${loginPageController.registrationPageFormControllers["first_name"]?.text.toString() ?? "XYZ"} ${loginPageController.registrationPageFormControllers["last_name"]?.text.toString() ?? "XYZ"}"),
                                //               MapEntry(
                                //                 "store_logo",
                                //                 sellerImageURL,
                                //               ),
                                //             ]);
                                //             body.addAll({
                                //               "firstname": loginPageController
                                //                       .registrationPageFormControllers[
                                //                           "first_name"]
                                //                       ?.text
                                //                       .toString() ??
                                //                   "",
                                //               "lastname": loginPageController
                                //                       .registrationPageFormControllers[
                                //                           "last_name"]
                                //                       ?.text
                                //                       .toString() ??
                                //                   "",
                                //               "land": loginPageController
                                //                   .landInAcres
                                //                   .toString(),
                                //               "seller_image":
                                //                   sellerImageURL.toString(),
                                //               "additional_comments":
                                //                   "Farmer is the backbone of India",
                                //             });
                                //           }
                                //           print(body);
                                //           var response = await Server()
                                //               .postFormData(
                                //                   body: body,
                                //                   url: loginProvider.isFarmer
                                //                       ? "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/updateparticularuser"
                                //                       : loginProvider.isStore
                                //                           ? "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/storeregistration/updateparticularorganicstore"
                                //                           : "https://nkweb.sweken.com/index.php?route=extension/account/purpletree_multivendor/api/restaurantregistration/updateparticularorganicrestaurant")
                                //               .catchError((e) {
                                //             log("64$e");
                                //           });
                                //           print("response - $response");
                                //           if (response?.statusCode == 200) {
                                //             print(response?.body);
                                //             var decodedResponse = jsonDecode(response
                                //                     ?.body
                                //                     .replaceFirst(
                                //                         '<b>Notice</b>: Undefined index: customer_group_id in\n<b>/home4/swekenco/public_html/nkweb/catalog/controller/extension/account/purpletree_multivendor/api/updateparticularuser.php</b>',
                                //                         '')
                                //                     .replaceFirst(
                                //                         "<b>Notice</b>: Undefined index: customer_group_id in<b>/home4/swekenco/public_html/nkweb/catalog/controller/extension/account/purpletree_multivendor/api/updateparticularuser.php</b>",
                                //                         "") ??
                                //                 '{"message": {},"success": false}');
                                //             log(response?.body ?? "");
                                //             var statusCodeBody = false;
                                //             if (decodedResponse["success"] !=
                                //                 null) {
                                //               statusCodeBody =
                                //                   decodedResponse["success"];
                                //             } else {
                                //               statusCodeBody =
                                //                   decodedResponse["status"];
                                //             }
                                //             if (statusCodeBody) {
                                //               log("Successful update");
                                //               snackbar(context,
                                //                   "Successfully updated your profile",
                                //                   isError: false);
                                //               Navigator.of(context).pop();
                                //               profileProvider.showLoader();
                                //               profileProvider
                                //                   .getProfile(
                                //                     loginProvider:
                                //                         loginProvider,
                                //                     userID: profileProvider
                                //                         .userIdForAddress,
                                //                     showMessage: (_) {
                                //                       snackbar(context, _);
                                //                     },
                                //                   )
                                //                   .then((value) =>
                                //                       profileProvider
                                //                           .hideLoader());
                                //             } else {
                                //               snackbar(context,
                                //                   "Failed to update, error: ${decodedResponse["message"]}");
                                //               profileProvider.hideLoader();
                                //             }
                                //           } else {
                                //             print(response?.body);
                                //             snackbar(context,
                                //                 "Oops! Couldn't update your profile: ${response?.statusCode}");
                                //             profileProvider.hideLoader();
                                //             Navigator.of(context).pop();
                                //           }
                                //         } else {
                                //           snackbar(context,
                                //               "Please upload a valid certificate");
                                //         }
                                //       } else {
                                //         snackbar(context,
                                //             "Please select a certification type");
                                //       }
                                //     } else {
                                //       snackbar(context,
                                //           "Please select your cultivated land in acres with the slider");
                                //     }
                                //   }
                                // }
                              },
                              height: getProportionateHeight(64, constraints),
                              borderRadius: 12,
                              bgColor: Theme.of(context).colorScheme.primary,
                              textColor:
                                  Theme.of(context).colorScheme.onPrimary,
                              buttonName: "Update".toUpperCase(),
                              innerPadding: 0.02,
                              trailingIcon: Icons.arrow_forward),
                        ),
                        SizedBox(
                          height: 120,
                        ),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            'assets/images/farmer_ploughing.png',
                            width: 300,
                          ),
                        )
                      ],
                    ),
                  ));
            }),
            profileProvider.shouldShowLoader
                ? const LoaderScreen()
                : const SizedBox(),
          ],
        );
      });
    });
  }
}
