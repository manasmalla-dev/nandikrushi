import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/nav_items/profile_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextWidget(
          'Videos',
          size: Theme.of(context).textTheme.titleMedium?.fontSize,
          color: Colors.grey[900],
          weight: FontWeight.w700,
        ),
      ),
      body: Consumer<ProfileProvider>(builder: (context, productProvider, _) {
        return Column(children: [
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Image(
                        image: AssetImage('assets/images/empty_basket.png')),
                    const SizedBox(
                      height: 20,
                    ),
                    TextWidget(
                      'Oops!',
                      weight: FontWeight.w800,
                      size: Theme.of(context).textTheme.titleLarge?.fontSize,
                      color: Colors.grey.shade800,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextWidget(
                      'We don\'t have any recommended videos for you at this moment',
                      weight: FontWeight.w600,
                      color: Colors.grey,
                      flow: TextOverflow.visible,
                      align: TextAlign.center,
                      size: Theme.of(context).textTheme.bodyMedium?.fontSize,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButtonWidget(
                        bgColor: Theme.of(context).primaryColor,
                        trailingIcon: Icons.ios_share_rounded,
                        buttonName: 'Recommend your Farm'.toUpperCase(),
                        textColor: Colors.white,
                        textStyle: FontWeight.w800,
                        borderRadius: 8,
                        innerPadding: 0.03,
                        onClick: () {
                          // productProvider.changeScreen(1);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]);
      }),
    );
  }
}
