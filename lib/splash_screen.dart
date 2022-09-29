import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/onboarding/login_controller.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/utils/custom_color_util.dart';
import 'package:nandikrushi_farmer/utils/login_utils.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log(context.isDarkMode);
    LoginController loginPageController = LoginController();
    LoginProvider loginProvider =
        Provider.of<LoginProvider>(context, listen: false);

    loginPageController.checkUser(
      isReturningUserFuture: context.isReturningUser,
      navigator: Navigator.of(context),
      onNewUser: (onCompleted) {
        loginPageController.getUserRegistrationData(context).then((_) {
          LoginProvider provider =
              Provider.of<LoginProvider>(context, listen: false);
          provider.fetchUserTypes(_);
          onCompleted();
        });
      },
      loginProvider: loginProvider,
    );

    return Scaffold(
      body: Container(
        color: context.isDarkMode
            ? Theme.of(context).colorScheme.background
            : Theme.of(context).backgroundColor.withOpacity(0.2),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset("assets/images/logo.png"),
              TextWidget(
                "Farmer".toUpperCase(),
                size: 12,
                lSpace: 16,
                color: context.isDarkMode
                    ? Theme.of(context).colorScheme.onBackground
                    : Theme.of(context).colorScheme.primary,
              )
            ],
          ),
        ),
      ),
    );
  }
}
