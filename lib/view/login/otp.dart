import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:nandikrushi/controller/login_controller.dart';
import 'package:nandikrushi/provider/login_provider.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPPage extends StatefulWidget {
  final String? num;
  final String? vericationId;
  const OTPPage({
    Key? key,
    this.num,
    this.vericationId,
  }) : super(key: key);

  @override
  _OTPPageState createState() => _OTPPageState();
}

class _OTPPageState extends StateMVC<OTPPage> {
  late LoginProvider loginProvider;
  LoginPageController? loginPageController;
  _OTPPageState() : super(LoginPageController()) {
    loginPageController = controller as LoginPageController;
  }
  final formKey = GlobalKey<FormState>();
  var pinController = TextEditingController();
  @override
  void initState() {
    loginProvider = Provider.of<LoginProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    pinController.addListener(() {
      setState(() {});
    });
    return Consumer<LoginProvider>(builder: (context, data, child) {
      return Scaffold(
          backgroundColor: Colors.white,
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
            child: SizedBox(
              width: double.infinity,
              height: height(context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Image(
                    image: AssetImage("assets/png/otp_image.png"),
                  ),
                  SizedBox(
                    height: height(context) * 0.15,
                  ),
                  SizedBox(
                    width: width(context) * 0.9,
                    child: Column(
                      children: [
                        TextWidget(
                          text: "Please Enter OTP",
                          color: Colors.black,
                          weight: FontWeight.w500,
                          size: height(context) * 0.02,
                          align: TextAlign.center,
                          flow: TextOverflow.visible,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextWidget(
                              text: "sent your mobile number ",
                              color: Colors.black,
                              weight: FontWeight.w500,
                              size: height(context) * 0.018,
                              align: TextAlign.center,
                              flow: TextOverflow.visible,
                            ),
                            TextWidget(
                              text: data.phoneNumber,
                              color: Colors.black,
                              weight: FontWeight.w800,
                              size: height(context) * 0.025,
                              align: TextAlign.center,
                              flow: TextOverflow.visible,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  SizedBox(
                    width: width(context) * 0.8,
                    child: Form(
                      key: formKey,
                      child: Pinput(
                        length: 6,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        defaultPinTheme: PinTheme(
                          width: 48,
                          height: 60,
                          textStyle: fonts(height(context) * 0.02,
                              FontWeight.bold, Colors.black),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 2, color: Colors.grey.shade600),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                          ),
                        ),
                        controller: pinController,
                        forceErrorState: true,
                        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        onChanged: (pin) {
                          data.setOtp(pin.toString());
                        },
                        onSubmitted: (pin) {
                          loginPageController?.loginUserWithOtp(
                              pin, context, loginProvider);
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height(context) * 0.05,
                  ),
                  ElevatedButtonWidget(
                    onClick: () {
                      loginPageController?.loginUserWithOtp(
                          data.otp, context, loginProvider);
                      // data.getOtp
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //       builder: (_) => const RegistrationScreen()),
                      // );
                    },
                    minWidth: width(context) * 0.85,
                    height: height(context) * 0.06,
                    bgColor: pinController.text.length == 4
                        ? Colors.green[900]
                        : Colors.grey.shade400,
                    borderSideColor: pinController.text.length == 4
                        ? Colors.green[900]
                        : Colors.grey.shade400,
                    textColor: Colors.white,
                    buttonName: "VERIFY OTP",
                    textSize: width(context) * 0.04,
                    trailingIcon: Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: width(context) * 0.045,
                    ),
                  ),
                  SizedBox(
                    width: width(context) * 0.9,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const TextWidget(
                          text: "Didn't Recieve OTP?",
                          weight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                        TextButton(
                            onPressed: () {},
                            child: TextWidget(
                              text: "Resend".toUpperCase(),
                              weight: FontWeight.w800,
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
    });
  }
}
