import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/filled_textfield_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/textfield_widget.dart';

class VideosScreen extends StatefulWidget {
  const VideosScreen({Key? key}) : super(key: key);

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  var searchController = TextEditingController();
  var videoRecommendations = [
    {'url': 'https://www.youtube.com/watch?v=-F7gbZd0o1c'},
    {'url': 'https://youtu.be/VaB5avNpvRc'},
    {'url': 'https://www.youtube.com/watch?v=gwEmnXVhckw'},
    {'url': 'https://www.youtube.com/watch?v=TkTXT90kd24'}
  ];
  var videos = [
    {'url': 'https://www.youtube.com/watch?v=TkTXT90kd24'},
    {'url': 'https://www.youtube.com/watch?v=dPrL3vJNw8Q'},
    {'url': 'https://www.youtube.com/watch?v=6MIrkKRoIug'},
    {'url': 'https://www.youtube.com/watch?v=gwEmnXVhckw'},
  ];
  String? getChannelId(String? url) {
    if (url == null) return null;
    if (!url.contains("http") && (url.length == 11)) return url;
    url = url.trim();

    for (var exp in [
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube\.com\/watch\?v=([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(
          r"^https:\/\/(?:www\.|m\.)?youtube(?:-nocookie)?\.com\/embed\/([_\-a-zA-Z0-9]{11}).*$"),
      RegExp(r"^https:\/\/youtu\.be\/([_\-a-zA-Z0-9]{11}).*$")
    ]) {
      Match? match = exp.firstMatch(url);
      if (match != null && match.groupCount >= 1) return match.group(1);
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(context, title: 'Videos'.toUpperCase()),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        margin: const EdgeInsets.only(top: 32),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: height(context) * 0.08,
                child: TextFieldWidget(
                  textInputAction: TextInputAction.search,
                  onSubmitField: () {
                    setState(() {});
                  },
                  controller: searchController,
                  label: "Search",
                  style: fonts(
                      height(context) * 0.022, FontWeight.w500, Colors.black),
                  suffix: Container(
                    margin: EdgeInsets.all(height(context) * 0.01),
                    child: ClipOval(
                        child: Container(
                            color: Theme.of(context).primaryColor,
                            padding: const EdgeInsets.all(0),
                            child: const Icon(
                              Icons.search_rounded,
                              color: Colors.white,
                            ))),
                  ),
                ),
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Recommended for Farmers',
                    size: height(context) * 0.02,
                    weight: FontWeight.w800,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: TextWidget(
                      text: 'View All',
                      size: height(context) * 0.02,
                      weight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height(context) * 0.13,
                child: ListView.builder(
                  itemCount: videoRecommendations.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: index != 0 ? width(context) * 0.03 : 0,
                          right: index != videos.length - 1
                              ? width(context) * 0.03
                              : 0),
                      child: Image.network(
                        "https://img.youtube.com/vi/${getChannelId(videoRecommendations[index]['url'])}/maxresdefault.jpg",
                        height: height(context) * 0.13,
                      ),
                    );
                  }),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Nandi Krushi Farm Visit',
                    size: height(context) * 0.02,
                    weight: FontWeight.w800,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: TextWidget(
                      text: 'View All',
                      size: height(context) * 0.02,
                      weight: FontWeight.w500,
                      color: Colors.grey.shade500,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height(context) * 0.13,
                child: ListView.builder(
                  itemCount: videos.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: ((context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: index != 0 ? width(context) * 0.03 : 0,
                          right: index != videos.length - 1
                              ? width(context) * 0.03
                              : 0),
                      child: Image.network(
                        "https://img.youtube.com/vi/${getChannelId(videos[index]['url'])}/maxresdefault.jpg",
                        height: height(context) * 0.13,
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              SizedBox(
                width: double.infinity,
                child: TextWidget(
                  text: 'Request for your farm video',
                  size: height(context) * 0.02,
                  weight: FontWeight.w800,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              SizedBox(
                height: height(context) * 0.02,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Theme.of(context).primaryColor)),
                child: Stack(
                  children: [
                    const FilledTextFieldWidget(),
                    Positioned(
                      child: Icon(
                        Icons.near_me_rounded,
                        color: Theme.of(context).primaryColor,
                      ),
                      bottom: 4,
                      right: 4,
                    )
                  ],
                ),
                width: double.infinity,
                height: height(context) * 0.2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
