import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/product/add_addresses.dart';
import 'package:nandikrushi_farmer/product/confirm_order_screen.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

showAddressesBottomSheet(
    BuildContext context, ProfileProvider pp, ThemeData themeData,
    {bool isOrderWorkflow = true}) {
  showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Consumer<ProfileProvider>(
              builder: (context, profileProvider, _) {
            return Container(
              height: 600,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.circular(16)),
              child: profileProvider.userAddresses.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Image(
                                image: AssetImage(
                                    'assets/images/delivery_address.png')),
                            const SizedBox(
                              height: 20,
                            ),
                            TextWidget(
                              'No Addresses Available',
                              weight: FontWeight.w800,
                              size: themeData.textTheme.titleLarge?.fontSize,
                              color: Colors.grey.shade800,
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            TextWidget(
                              'Your selected city is Hyderabad.\nPlease add an address by tapping below.',
                              weight: FontWeight.w600,
                              color: Colors.grey,
                              flow: TextOverflow.visible,
                              align: TextAlign.center,
                              size: themeData.textTheme.bodyMedium?.fontSize,
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 42),
                              child: ElevatedButtonWidget(
                                bgColor: themeData.colorScheme.primary,
                                trailingIcon: Icons.add_rounded,
                                buttonName: 'Add Address'.toUpperCase(),
                                textColor: Colors.white,
                                textStyle: FontWeight.w800,
                                borderRadius: 8,
                                innerPadding: 0.03,
                                onClick: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) =>
                                          const AddAddressesScreen()));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextWidget(
                            isOrderWorkflow
                                ? 'Delivery Address'
                                : "Your Addresses",
                            weight: FontWeight.w800,
                            size: themeData.textTheme.titleLarge?.fontSize,
                          ),
                          isOrderWorkflow
                              ? Opacity(
                                  opacity: 0.7,
                                  child: TextWidget(
                                    'Choose the delivery address for this order',
                                    flow: TextOverflow.visible,
                                    align: TextAlign.center,
                                    size: themeData
                                        .textTheme.bodyMedium?.fontSize,
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(
                            height: 16,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            separatorBuilder: (context, _) {
                              return const Divider();
                            },
                            itemCount: profileProvider.userAddresses.length,
                            itemBuilder: (context, item) {
                              return InkWell(
                                onTap: () {
                                  isOrderWorkflow
                                      ? Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ConfirmOrderScreen(
                                                    addressID: profileProvider
                                                                .userAddresses[
                                                            item]["address_id"] ??
                                                        "",
                                                  )))
                                      : () {};
                                },
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemBuilder: ((context, index) {
                                          var data = [
                                            profileProvider.userAddresses[item]
                                                ["address_title"],
                                            profileProvider.userAddresses[item]
                                                ["address_1"],
                                            profileProvider.userAddresses[item]
                                                ["address_2"],
                                            profileProvider.userAddresses[item]
                                                ["postcode"],
                                            profileProvider.userAddresses[item]
                                                ["city"]
                                          ];
                                          return index == 0
                                              ? Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 6),
                                                  child: TextWidget(
                                                    data[index],
                                                    weight: FontWeight.w800,
                                                    size: 20,
                                                  ),
                                                )
                                              : addressRow(
                                                  data[index] ?? "", 16);
                                        }),
                                        itemCount: 5,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: IconButton(
                                        onPressed: () {},
                                        icon: const Icon(Icons.edit_rounded),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12),
                                      child: IconButton(
                                        onPressed: () {},
                                        color:
                                            Theme.of(context).colorScheme.error,
                                        icon: const Icon(Icons.delete_rounded),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Center(
                            child: TextWidget(
                              '-------------- or --------------',
                              color: Colors.grey,
                              flow: TextOverflow.visible,
                              align: TextAlign.center,
                              size: themeData.textTheme.bodyMedium?.fontSize,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButtonWidget(
                            bgColor:
                                Theme.of(context).colorScheme.surfaceVariant,
                            trailingIcon: Icons.add_rounded,
                            buttonName: 'Add Address'.toUpperCase(),
                            textColor:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                            textStyle: FontWeight.w800,
                            borderRadius: 8,
                            onClick: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) =>
                                      const AddAddressesScreen()));
                            },
                          )
                        ],
                      ),
                    ),
            );
          });
        });
      });
}

Widget addressRow(String addres, double size) {
  // var title = '';
  // switch (index) {
  //   case 0:
  //     title = 'House/Flat No.';
  //     break;
  //   case 1:
  //     title = 'Landmark';
  //     break;
  //   case 2:
  //     title = 'Address';
  //     break;
  //   case 3:
  //     title = 'Pincode';
  //     break;
  //   case 4:
  //     title = 'Contact';
  //     break;
  //   case 5:
  //     title = 'A. Contact';
  //     break;
  //   default:
  // }
  return Row(
    children: [
      // TextWidget(
      //   '$title:',
      //   weight: FontWeight.bold,
      //   size: size,
      // ),
      Expanded(
        child: TextWidget(
          addres,
          size: size,
          flow: TextOverflow.visible,
        ),
      )
    ],
  );
}
