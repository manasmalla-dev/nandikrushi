import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nandikrushi/nav_items/profile_provider.dart';
import 'package:nandikrushi/onboarding/login_controller.dart';
import 'package:nandikrushi/onboarding/login_provider.dart';
import 'package:nandikrushi/reusable_widgets/text_widget.dart';
import 'package:nandikrushi/utils/custom_color_util.dart';
import 'package:nandikrushi/utils/login_utils.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController loginPageController = LoginController();
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);
    ProfileProvider profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    loginPageController
        .checkLocationPermissionAndGetLocation(context, profileProvider)
        .then((_) {});

    loginPageController.checkUser(
      isReturningUserFuture: context.isReturningUser,
      navigator: Navigator.of(context),
      onNewUser: (onCompleted) {
        onCompleted();
      },
      loginProvider: loginProvider,
    );

    return Scaffold(
      backgroundColor: ElevationOverlay.colorWithOverlay(
          Theme.of(context).colorScheme.surface,
          Theme.of(context).colorScheme.primary,
          3.0),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset("assets/images/logo.png"),
            // TextWidget(
            //   loginProvider.userAppTheme.key.toUpperCase(),
            //   size: 12,
            //   lSpace: loginProvider.userAppTheme.key.length > 10 ? 8 : 16,
            //   color: context.isDarkMode
            //       ? Theme.of(context).colorScheme.onBackground
            //       : Theme.of(context).colorScheme.primary,
            // )
          ],
        ),
      ),
    );
  }
}
