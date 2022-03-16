import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/elevated_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/login/registration.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  final formKey = GlobalKey<FormState>();
  var pinController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    pinController.addListener(() {
      setState(() {});
    });
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
          child: Container(
            width: double.infinity,
            height: height(context),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
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
                            text: "7780356704",
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      defaultPinTheme: PinTheme(
                        width: 48,
                        height: 60,
                        textStyle: fonts(height(context) * 0.02,
                            FontWeight.bold, Colors.black),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Colors.grey.shade600),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      controller: pinController,
                      forceErrorState: true,
                      // errorText: 'Error',
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      // validator: (pin) {
                      //   if (pin == '2224') return null;
                      //   return snackbar(context, 'invalid OTP');
                      // },
                    ),
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.05,
                ),
                ElevatedButtonWidget(
                  onClick: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => const RegistrationScreen()),
                    );
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
                      TextWidget(
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
  }
}
