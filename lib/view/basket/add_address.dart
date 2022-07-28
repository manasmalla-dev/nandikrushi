import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushi/reusable_widgets/app_bar.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:nandikrushi/reusable_widgets/textfield_widget.dart';

class AddAddressScreen extends StatefulWidget {
  final Map<String, String> geolocatedLocationAddress;
  final Function(List<String>) onSaveAddress;
  const AddAddressScreen(
      {Key? key,
      required this.onSaveAddress,
      this.geolocatedLocationAddress = const {}})
      : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  var formControllers = {
    'house_number': TextEditingController(),
    'landmark': TextEditingController(),
    'full_address': TextEditingController(),
    'pincode': TextEditingController(),
    'alternate_mobile_number': TextEditingController(),
  };
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.geolocatedLocationAddress.isNotEmpty) {
      formControllers["house_number"]?.text =
          widget.geolocatedLocationAddress["premise"] ?? "";
      formControllers["full_address"]?.text =
          widget.geolocatedLocationAddress["address"] ?? "";
      formControllers["pincode"]?.text =
          widget.geolocatedLocationAddress["postal_code"] ?? "";
    }
  }

  var chipSelection = 0;
  var otherController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWithTitle(context, title: 'Add Address'),
      body: SingleChildScrollView(
        child: SizedBox(
          height: height(context) * 0.85,
          child: Column(
            children: [
              SizedBox(
                height: height(context) * 0.42,
                child: Image.network(
                  "https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: width(context) * 0.05,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: width(context) * 0.07,
                    vertical: height(context) * 0.02),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            controller: formControllers['house_number'],
                            label: 'House / Flat No.',
                            hintSize: 16,
                            hintColor: Colors.grey.shade600,
                            style: fonts(18.0, FontWeight.w500, Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: width(context) * 0.05,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            controller: formControllers['landmark'],
                            label: 'Landmark',
                            hintSize: 16,
                            hintColor: Colors.grey.shade600,
                            style: fonts(18.0, FontWeight.w500, Colors.black),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    TextFieldWidget(
                      controller: formControllers['full_address'],
                      label: 'Address',
                      hintSize: 16,
                      style: fonts(18.0, FontWeight.w500, Colors.black),
                    ),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextFieldWidget(
                            controller: formControllers['pincode'],
                            label: 'Pincode',
                            hintSize: 16,
                            showCounter: false,
                            maxLength: 6,
                            hintColor: Colors.grey.shade600,
                            style: fonts(18.0, FontWeight.w500, Colors.black),
                          ),
                        ),
                        SizedBox(
                          width: width(context) * 0.05,
                        ),
                        Expanded(
                          child: TextFieldWidget(
                            textInputAction: TextInputAction.done,
                            controller:
                                formControllers['alternate_mobile_number'],
                            label: 'Alternative Contact',
                            hintSize: 16,
                            maxLength: 10,
                            showCounter: true,
                            hintColor: Colors.grey.shade600,
                            style: fonts(18.0, FontWeight.w500, Colors.black),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        chipSelection = 0;
                      });
                    },
                    child: Chip(
                      backgroundColor: chipSelection == 0
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.5),
                      avatar: const Icon(
                        Icons.home_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: const TextWidget(
                        text: 'Home',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        chipSelection = 1;
                      });
                    },
                    child: Chip(
                      backgroundColor: chipSelection == 1
                          ? Theme.of(context).primaryColor
                          : Theme.of(context).primaryColor.withOpacity(0.5),
                      avatar: const Icon(
                        Icons.work_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      label: const TextWidget(
                        text: 'Office',
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            chipSelection = 2;
                          });
                        },
                        child: Chip(
                          backgroundColor: chipSelection == 2
                              ? Theme.of(context).primaryColor
                              : Theme.of(context).primaryColor.withOpacity(0.5),
                          avatar: const Icon(
                            Icons.place_rounded,
                            size: 16,
                            color: Colors.white,
                          ),
                          label: const TextWidget(
                            text: 'Other',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        height: 24,
                        width: chipSelection == 2 ? 80 : 0,
                        child: TextFieldWidget(
                          controller: otherController,
                          textInputAction: TextInputAction.done,
                          hint: 'Other',
                          hintSize: 10,
                          hintColor: Colors.grey.shade600,
                          style: fonts(10.0, FontWeight.w500, Colors.black),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: ElevatedButtonWidget(
                    onClick: () {
                      var checkingControllersNull = true;
                      List<String> addressList = [];
                      for (var controller in formControllers.values) {
                        log('CHECKING: ${controller.text.isEmpty}');
                        if (controller.text.isEmpty) {
                          checkingControllersNull = false;
                        } else {
                          addressList.add(controller.text);
                        }
                      }
                      log(checkingControllersNull.toString());
                      var shouldCheckOtherController = chipSelection == 2
                          ? otherController.text.isNotEmpty
                          : true;
                      log(shouldCheckOtherController.toString());
                      if (checkingControllersNull &&
                          shouldCheckOtherController) {
                        addressList.insert(
                            0,
                            chipSelection == 0
                                ? "Home"
                                : chipSelection == 1
                                    ? "Store"
                                    : otherController.text.toString());
                        widget.onSaveAddress(addressList);
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      }
                    },
                    minWidth: width(context) * 0.9,
                    height: height(context) * 0.06,
                    // borderRadius: 16,
                    bgColor: Colors.green[900],
                    textColor: Colors.white,
                    borderRadius: width(context) * 0.03,
                    allRadius: true,
                    buttonName: 'Save'.toUpperCase(),
                    textSize: width(context) * 0.04,
                    trailingIcon: Icon(
                      Icons.check_rounded,
                      color: Colors.white,
                      size: width(context) * 0.045,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
