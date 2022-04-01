import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/basket/add_address.dart';
import 'package:nandikrushifarmer/view/basket/delivery_address_bs.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  List<List<String>> addresses = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarWithTitle(
          context,
          title: 'Address',
          suffix: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddAddressScreen(
                    onSaveAddress: (list) {
                      setState(() {
                        addresses.add(list);
                        Navigator.of(context).pop();
                      });
                    },
                  ),
                ),
              );
            },
            child: Container(
              height: double.infinity,
              margin: EdgeInsets.only(
                  right: width(context) * 0.05, top: height(context) * 0.005),
              child: Row(
                children: [
                  Icon(
                    Icons.add_rounded,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  TextWidget(
                    text: 'Add',
                    size: width(context) * 0.045,
                    color: Colors.blue.shade700,
                    weight: FontWeight.w700,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: Center(
          child: SizedBox(
            height: double.infinity,
            child: DeliveryAddressesList(
                addresses: addresses,
                onAddAddress: (list) {
                  setState(() {
                    addresses.add(list);
                    Navigator.of(context).pop();
                  });
                },
                onDeleteAddress: (item) {
                  setState(() {
                    addresses.removeAt(item);
                  });
                }),
          ),
        ));
  }
}
