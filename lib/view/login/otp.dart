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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: Container(
            width: width(context),
            height: height(context),
            decoration: const BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/png/otp_image.png'),
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: width(context) * 0.85,
                  child: const TextWidget(
                    text:
                        "Please Enter OTP\nsent your mobile number 7780356704",
                    color: Colors.black,
                    weight: FontWeight.w600,
                    align: TextAlign.center,
                    flow: TextOverflow.visible,
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.025,
                ),
                Form(
                  key: formKey,
                  child: const Pinput(
                    forceErrorState: true,
                    // errorText: 'Error',
                    pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                    // validator: (pin) {
                    //   if (pin == '2224') return null;
                    //   return snackbar(context, 'invalid OTP');
                    // },
                  ),
                ),
                SizedBox(
                  height: height(context) * 0.03,
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
                  bgColor: Colors.green[900],
                  borderSideColor: Colors.green[900],
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
                  height: height(context) * 0.15,
                )
              ],
            )));
  }
}
