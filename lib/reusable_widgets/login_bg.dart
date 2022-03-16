import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/login/registration.dart';

class LoginBG extends StatefulWidget {
  final Widget? bottomWidget;
  const LoginBG({Key? key, this.bottomWidget}) : super(key: key);

  @override
  State<LoginBG> createState() => _LoginBGState();
}

class _LoginBGState extends State<LoginBG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFED8),
      body: SingleChildScrollView(
        child: Container(
          width: width(context),
          height: height(context),
          decoration: const BoxDecoration(
              image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/png/login_BG.png'),
          )),
          child: Container(
            width: width(context),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.all(width(context) * 0.05),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                          child: SizedBox(
                            width: width(context),
                            child: TextWidget(
                              text: 'SKIP LOGIN',
                              size: width(context) * 0.035,
                              weight: FontWeight.w600,
                              color: Colors.grey[900],
                              align: TextAlign.end,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: height(context) * 0.06,
                        ),
                        SizedBox(
                          width: width(context),
                          child: Text(
                            'Nandikrushi',
                            style: TextStyle(
                              fontFamily: 'Samarkan',
                              fontSize: width(context) * 0.08,
                              fontWeight: FontWeight.w500,
                              color: Colors.green[900],
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          width: width(context),
                          child: TextWidget(
                            text: 'WELCOME',
                            size: width(context) * 0.06,
                            weight: FontWeight.w600,
                            color: Colors.grey[900],
                            align: TextAlign.start,
                            lSpace: 1.2,
                          ),
                        ),
                        SizedBox(
                          width: width(context),
                          child: TextWidget(
                            text: "Let's get started",
                            size: width(context) * 0.025,
                            weight: FontWeight.w600,
                            color: Colors.grey[900],
                            align: TextAlign.start,
                            lSpace: 2.5,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    child: widget.bottomWidget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
