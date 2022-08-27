import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/onboarding/login_bg.dart';
import 'package:nandikrushi_farmer/onboarding/login_controller.dart';
import 'package:nandikrushi_farmer/onboarding/login_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/utils/size_config.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
  final String phoneNumber;
  const OTPScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool canResendSMS = false;
  LoginController loginPageController = LoginController();
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(minutes: 2), () {
      setState(() {
        canResendSMS = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(builder: (context, data, _) {
      return LayoutBuilder(builder: (context, constraints) {
        return constraints.maxWidth < 600
            ? Scaffold(
                appBar: AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: Colors.grey[900],
                        ))),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("assets/images/otp_image.png"),
                          height: getProportionateHeight(325, constraints),
                        ),
                        SizedBox(
                          height: getProportionateHeight(125, constraints),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextWidget(
                              "Please enter the OTP",
                              color: Colors.black,
                              weight: FontWeight.w500,
                              size: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.fontSize,
                              align: TextAlign.center,
                              flow: TextOverflow.visible,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                TextWidget(
                                  "sent to your mobile number",
                                  color: Colors.black,
                                  weight: FontWeight.w500,
                                  size: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.fontSize,
                                  align: TextAlign.center,
                                  height: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.height,
                                  flow: TextOverflow.visible,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                TextWidget(
                                  widget.phoneNumber,
                                  color: Colors.black,
                                  weight: FontWeight.w800,
                                  size: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.fontSize,
                                  align: TextAlign.center,
                                  flow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: getProportionateHeight(48, constraints),
                        ),
                        Form(
                          key: loginPageController.otpFormKey,
                          child: Pinput(
                            length: 6,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            defaultPinTheme: PinTheme(
                              width: 48,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 2, color: Colors.grey.shade600),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                            controller:
                                loginPageController.otpTextEditController,
                            forceErrorState: true,
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            onChanged: (pin) {
                              setState(() {});
                              //data.setOtp(pin.toString());
                            },
                            onSubmitted: (pin) {
                              /*loginPageController?.loginUserWithOtp(
                                    pin, context, loginProvider);*/
                            },
                          ),
                        ),
                        SizedBox(
                          height: getProportionateHeight(48, constraints),
                        ),
                        ElevatedButtonWidget(
                          onClick: () {
                            /*loginPageController?.loginUserWithOtp(
                                  data.otp, context, loginProvider);*/
                            // data.getOtp
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //       builder: (_) => const RegistrationScreen()),
                            // );
                          },
                          height: getProportionateHeight(64, constraints),
                          bgColor: loginPageController
                                      .otpTextEditController.text.length ==
                                  6
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade400,
                          borderSideColor: loginPageController
                                      .otpTextEditController.text.length ==
                                  6
                              ? Theme.of(context).primaryColor
                              : Colors.grey.shade500,
                          textColor: Colors.white,
                          buttonName: "VERIFY OTP",
                          borderRadius: 12,
                          trailingIcon: Icons.arrow_forward,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextWidget(
                              "Didn't Recieve OTP?",
                              size:
                                  Theme.of(context).textTheme.button?.fontSize,
                              weight: FontWeight.w500,
                              color: Colors.grey,
                            ),
                            TextButton(
                              onPressed: () {
                                if (canResendSMS) {
                                  canResendSMS = false;
                                  //RESEND OTP
                                }
                              },
                              child: TextWidget(
                                "Resend".toUpperCase(),
                                weight: FontWeight.w700,
                                color: canResendSMS
                                    ? Colors.grey.shade900
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                appBar: PreferredSize(
                  preferredSize: const Size.fromHeight(80),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(top: 32),
                    child: AppBar(
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.grey[900],
                        ),
                      ),
                    ),
                  ),
                ),
                body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Row(children: [
                    const Image(
                      image: AssetImage("assets/images/otp_image.png"),
                    ),
                    SizedBox(
                      width: getProportionateWidth(32, constraints),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          WelcomeToNandikrushi(
                            constraints: constraints,
                            bottomSpacing: 128,
                          ),
                          TextWidget(
                            "Please enter the OTP sent to your mobile number",
                            color: Colors.grey.shade900,
                            weight: FontWeight.w500,
                            size: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.fontSize,
                            align: TextAlign.start,
                            height:
                                Theme.of(context).textTheme.bodyLarge?.height,
                            flow: TextOverflow.visible,
                          ),
                          SizedBox(
                            height: getProportionateHeight(12, constraints),
                          ),
                          TextWidget(
                            "+91 ${widget.phoneNumber.substring(0, 5)} ${widget.phoneNumber.substring(5, 10)}",
                            color: Colors.black,
                            weight: FontWeight.w800,
                            size: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize,
                            align: TextAlign.start,
                            flow: TextOverflow.visible,
                          ),
                          SizedBox(
                            height: getProportionateHeight(48, constraints),
                          ),
                          Form(
                            key: loginPageController.otpFormKey,
                            child: Pinput(
                              length: 6,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              followingPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                              ),
                              submittedPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                              ),
                              focusedPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2,
                                      color: Theme.of(context).primaryColor),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                              ),
                              defaultPinTheme: PinTheme(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade600),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                ),
                              ),
                              controller:
                                  loginPageController.otpTextEditController,
                              forceErrorState: true,
                              pinputAutovalidateMode:
                                  PinputAutovalidateMode.onSubmit,
                              onChanged: (pin) {
                                setState(() {});
                                //data.setOtp(pin.toString());
                              },
                              onSubmitted: (pin) {
                                /*loginPageController?.loginUserWithOtp(
                                      pin, context, loginProvider);*/
                              },
                            ),
                          ),
                          SizedBox(
                            height: getProportionateHeight(48, constraints),
                          ),
                          ElevatedButtonWidget(
                            onClick: () {
                              /*loginPageController?.loginUserWithOtp(
                                    data.otp, context, loginProvider);*/
                              // data.getOtp
                              // Navigator.of(context).push(
                              //   MaterialPageRoute(
                              //       builder: (_) => const RegistrationScreen()),
                              // );
                            },
                            height: getProportionateHeight(64, constraints),
                            bgColor: loginPageController
                                        .otpTextEditController.text.length ==
                                    6
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade400,
                            borderSideColor: loginPageController
                                        .otpTextEditController.text.length ==
                                    6
                                ? Theme.of(context).primaryColor
                                : Colors.grey.shade500,
                            textColor: Colors.white,
                            buttonName: "VERIFY OTP",
                            borderRadius: 12,
                            trailingIcon: Icons.arrow_forward,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextWidget(
                                "Didn't Recieve OTP?",
                                size: Theme.of(context)
                                    .textTheme
                                    .button
                                    ?.fontSize,
                                weight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                              TextButton(
                                onPressed: () {
                                  if (canResendSMS) {
                                    canResendSMS = false;
                                    //RESEND OTP
                                  }
                                },
                                child: TextWidget(
                                  "Resend".toUpperCase(),
                                  weight: FontWeight.w700,
                                  color: canResendSMS
                                      ? Colors.grey.shade900
                                      : Colors.grey,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ]),
                ),
              );
      });
    });
  }
}
