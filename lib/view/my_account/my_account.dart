import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/list_tile.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/utilities/launcher.dart';
import 'package:nandikrushifarmer/view/my_account/address_page.dart';
import 'package:nandikrushifarmer/view/my_account/signout_bs.dart';
import 'package:share_plus/share_plus.dart';

class MyAccount extends StatefulWidget {
  const MyAccount({Key? key}) : super(key: key);

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              profileAppBar(context),
              space(height: height(context) * 0.02),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    listTile(context,
                        title: "Wallet",
                        subtitle: "Balance: Rs.0.00",
                        leading: Icons.account_balance_wallet, ontap: () {
                      log('Wallet');
                    }),
                    div(context, 1.0),
                    listTileWithouST(context,
                        title: "Profile", leading: Icons.person, ontap: () {
                      log('Profile');
                    }),
                    listTileWithouST(context,
                        title: "Address",
                        leading: Icons.location_on, ontap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddressScreen()));
                      log('Address');
                    }),
                    listTileWithouST(context,
                        title: "Chat", leading: Icons.quickreply, ontap: () {
                      log('Chat');
                    }),
                    div(context, 0.5),
                    expListTile(context,
                        title: "Support",
                        leading: Icons.support_agent,
                        widget: [
                          listTileWithouST(context,
                              title: "Contact Us",
                              leading: Icons.call, ontap: () {
                            launchCaller();
                          }),
                          listTileWithouST(context,
                              title: "Email", leading: Icons.email, ontap: () {
                            launchEmail();
                          }),
                          listTileWithouST(context,
                              title: "Terms & Conditions",
                              leading: Icons.description, ontap: () {
                            log('Terms & Conditions');
                          }),
                          listTileWithouST(context,
                              title: "Privacy Policy",
                              leading: Icons.security, ontap: () {
                            log('Privacy Policy');
                          }),
                        ]),
                    div(context, 0.5),
                    listTileWithouTI(context,
                        title: "Share App", leading: Icons.share, ontap: () {
                      Share.share(
                          "Install and explore the Nandikrushi Famrer app to shop your edibles",
                          subject: 'Nandikrushi Farmer app');
                    }),
                    listTileWithouTI(context,
                        title: "Logout",
                        leading: Icons.power_settings_new, ontap: () {
                      signOut(context);
                    }),
                  ],
                ),
              ),
              space(height: height(context) * 0.01),
              Column(
                children: [
                  Opacity(
                    opacity: 0.5,
                    child: SizedBox(
                        height: height(context) * 0.06,
                        child: Image.asset('assets/png/logo.png')),
                  ),
                  Opacity(
                    opacity: 0.5,
                    child: SizedBox(
                      width: width(context),
                      child: Text(
                        'Nandikrushi',
                        style: TextStyle(
                          fontFamily: 'Samarkan',
                          fontSize: width(context) * 0.08,
                          fontWeight: FontWeight.w500,
                          color: Colors.green[900],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width(context),
                    child: TextWidget(
                      text: "an aggregator of natural farmers",
                      size: width(context) * 0.024,
                      weight: FontWeight.w600,
                      color: Colors.grey[500],
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: width(context),
                    child: TextWidget(
                      text: "v1.2.0+60",
                      size: width(context) * 0.024,
                      weight: FontWeight.w600,
                      color: Colors.grey[500],
                      align: TextAlign.center,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
