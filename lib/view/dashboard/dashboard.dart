import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:nandikrushi/reusable_widgets/app_bar.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  var carouselController = CarouselController();
  var currentPos = 0;
  var fresh_farms = [
    {
      'name': 'Brinjal',
      'description':
          'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
      'price': '49',
      'units': '1 kg',
      'place': 'Paravada, Visakhapatnam.',
      'url':
          'https://resources.commerceup.io/?key=https%3A%2F%2Fprod-admin-images.s3.ap-south-1.amazonaws.com%2FpWVdUiFHtKGqyJxESltt%2Fproduct%2F30571001191.jpg&width=800&resourceKey=pWVdUiFHtKGqyJxESltt'
    },
    {
      'name': 'Lady Finger',
      'description':
          'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
      'price': '38',
      'units': '1 kg',
      'place': 'Paravada, Visakhapatnam.',
      'url':
          'https://freepngimg.com/thumb/ladyfinger/42370-2-lady-finger-png-free-photo.png'
    },
    {
      'name': 'Tomatoes',
      'description':
          'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
      'price': '50',
      'units': '1 kg',
      'place': 'Paravada, Visakhapatnam.',
      'url':
          'https://dtgxwmigmg3gc.cloudfront.net/imagery/assets/derivations/icon/256/256/true/eyJpZCI6IjYyODZjZmMzNTNiOGRmMGIyNmY3NWUwZWUyZmM4MzAyIiwic3RvcmFnZSI6InB1YmxpY19zdG9yZSJ9?signature=c4d219eadabc82e33ea702d131d4ade62f664fbfe6510461a1542c306d771d43'
    }
  ];
  var natural_farms = [
    {
      'name': 'Cow Milk',
      'description':
          'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
      'price': '49',
      'units': '1 kg',
      'place': 'Paravada, Visakhapatnam.',
      'url':
          'https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg'
    },
    {
      'name': 'Buffallo Milk',
      'description':
          'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
      'price': '38',
      'units': '1 kg',
      'place': 'Paravada, Visakhapatnam.',
      'url':
          'https://5.imimg.com/data5/BS/VQ/WG/SELLER-66548153/fresh-raw-buffalo-milk-500x500.jpeg'
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appbar(context, actions: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.location_on_rounded),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      TextWidget(
                        text: 'Hyderabad',
                        size: 14,
                      ),
                      TextWidget(text: '-------------'),
                    ],
                  )
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.language_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_rounded),
              )
            ]),
            const SizedBox(
              height: 16,
            ),
            CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: 5,
                itemBuilder: (context, index, _) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: SizedBox(
                            width: width(context) * 0.9,
                            child: Image.asset(
                              'assets/png/globalagriculture.jpeg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: width(context) * 0.9,
                            height: double.infinity,
                            color: Colors.black.withOpacity(0.5),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Spacer(),
                              TextWidget(
                                text: 'We\'re Fresh.',
                                weight: FontWeight.w500,
                                color: Colors.white,
                                size: height(context) * 0.03,
                              ),
                              const Divider(
                                color: Colors.white,
                              ),
                              const TextWidget(
                                text: 'We believe in Truly food is a Medicine',
                                color: Colors.white,
                                size: 14,
                              ),
                              SizedBox(
                                height: height(context) * 0.02,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                options: CarouselOptions(
                    autoPlay: true,
                    height: height(context) * 0.2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPos = index;
                      });
                    })),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [1, 2, 3, 4, 5].map((url) {
                int index = [1, 2, 3, 4, 5].indexOf(url);
                return Container(
                  width: 5.0,
                  height: 5.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: currentPos == index
                        ? const Color.fromRGBO(0, 0, 0, 0.9)
                        : const Color.fromRGBO(0, 0, 0, 0.4),
                  ),
                );
              }).toList(),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: 'Cataloge',
                    weight: FontWeight.bold,
                    size: height(context) * 0.03,
                  ),
                  const TextWidget(
                    text: 'Our handpicked finest category to your choice',
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    height: height(context) * 0.3,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          width: width(context) * 0.35,
                          margin: index == 0
                              ? const EdgeInsets.only(right: 8)
                              : const EdgeInsets.symmetric(horizontal: 8),
                          height: height(context) * 0.3,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Image.asset(
                                  'assets/png/vegetables.png',
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: width(context) * 0.35,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(0.5),
                                        borderRadius:
                                            const BorderRadius.vertical(
                                                top: Radius.circular(16))),
                                    width: double.infinity,
                                    height: height(context) * 0.1,
                                    child: const Center(
                                        child: const TextWidget(
                                      text: 'Vegetables',
                                      weight: FontWeight.bold,
                                      color: Colors.white,
                                    )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.arrow_forward_rounded),
                      const SizedBox(
                        width: 12,
                      ),
                      TextWidget(
                        text: 'View All'.toUpperCase(),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              color: const Color(0xFFE2F2D5),
              width: double.infinity,
              height: height(context) * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: width(context) * 0.3 * (fresh_farms.length + 1),
                  height: height(context) * 0.3,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              TextWidget(
                                text: 'Fresh from\nour farms',
                                size: height(context) * 0.03,
                              ),
                              TextWidget(
                                text: 'Verified by Nandikrushi',
                                size: height(context) * 0.015,
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Icon(Icons.arrow_forward_rounded),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  TextWidget(
                                    text: 'View All'.toUpperCase(),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const VerticalDivider()
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          children: fresh_farms.map((e) {
                            return Row(
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      e['url']!,
                                      height: width(context) * 0.2,
                                      width: width(context) * 0.2,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextWidget(
                                      text: e['name'],
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    Spacer(),
                                    TextWidget(
                                      text: e['units'],
                                      weight: FontWeight.bold,
                                      size: 14,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextWidget(
                                      text: 'Rs. ${e['price']}',
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    Spacer(),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: Size.zero, // Set this
                                          padding: EdgeInsets.zero, // and this
                                          side: const BorderSide(width: 1),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.add,
                                              size: 14,
                                              color: Colors.black,
                                            ),
                                            const SizedBox(
                                              width: 6,
                                            ),
                                            TextWidget(
                                                text: "Add".toUpperCase(),
                                                weight: FontWeight.bold,
                                                size: height(context) * 0.014),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                const VerticalDivider(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: Theme.of(context).primaryColor,
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const TextWidget(
                    text: 'Do You Know?',
                    weight: FontWeight.w700,
                    color: Colors.white,
                  ),
                  const TextWidget(
                    text:
                        'A2 Milk got its name from the rich amount of A2 beta-casein protein present in the milk. It is one of the most nutritional form of milk available today. The Gir Cow breed from India is specifically known for producing high quality A2 Milk.',
                    color: Colors.white,
                    flow: TextOverflow.visible,
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
            Container(
              color: Colors.white,
              width: double.infinity,
              height: height(context) * 0.3,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  width: width(context) * 0.37 * (fresh_farms.length + 1),
                  height: height(context) * 0.3,
                  child: Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: 'Natural Store',
                                size: height(context) * 0.03,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextWidget(
                                text:
                                    'Subscribe for daily needs\nat your door step',
                                size: height(context) * 0.015,
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              TextWidget(
                                text: 'Daily | Weekly | Monthly',
                                size: height(context) * 0.015,
                                color: Colors.grey.shade600,
                              ),
                              const Spacer(),
                              Row(
                                children: [
                                  const Icon(Icons.arrow_forward_rounded),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  TextWidget(
                                    text: 'View All'.toUpperCase(),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const VerticalDivider()
                        ],
                      ),
                      Expanded(
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          children: natural_farms.map((e) {
                            return Row(
                              children: [
                                Column(
                                  children: [
                                    Image.network(
                                      e['url']!,
                                      height: width(context) * 0.2,
                                      width: width(context) * 0.2,
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextWidget(
                                      text: e['name'],
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    TextWidget(
                                      text: 'Nandikrushi Organic Store',
                                      size: height(context) * 0.012,
                                      color: Colors.grey.shade600,
                                    ),
                                    Spacer(),
                                    TextWidget(
                                      text: e['units'],
                                      weight: FontWeight.bold,
                                      size: 14,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    TextWidget(
                                      text: 'Rs. ${e['price']}',
                                      weight: FontWeight.bold,
                                      size: 18,
                                    ),
                                    Spacer(),
                                    Row(
                                      children: [
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                              tapTargetSize:
                                                  MaterialTapTargetSize
                                                      .shrinkWrap,
                                              minimumSize:
                                                  Size.zero, // Set this
                                              padding:
                                                  EdgeInsets.zero, // and this
                                              side: const BorderSide(width: 1),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          100))),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 2),
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.add,
                                                  size: 14,
                                                  color: Colors.black,
                                                ),
                                                const SizedBox(
                                                  width: 6,
                                                ),
                                                TextWidget(
                                                    text: "Add".toUpperCase(),
                                                    weight: FontWeight.bold,
                                                    size: height(context) *
                                                        0.014),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        FlatButton(
                                          color: Colors.tealAccent,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          minWidth: 0, // Set this
                                          height: 16,
                                          padding: EdgeInsets.zero, // and this

                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                          ),
                                          onPressed: () {},
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 2),
                                            child: const Icon(
                                              Icons.cached_rounded,
                                              size: 14,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                const VerticalDivider(),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              color: const Color(0xFFE2F2D5),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 32),
              child: Column(
                children: [
                  SizedBox(
                      height: height(context) * 0.06,
                      child: Image.asset('assets/png/logo.png')),
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
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: width(context),
                    child: TextWidget(
                      text: "an aggregator of natural farmers",
                      size: width(context) * 0.024,
                      weight: FontWeight.w600,
                      color: Colors.grey.shade800,
                      align: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    width: width(context),
                    child: TextWidget(
                      text: "v1.2.0+60",
                      size: width(context) * 0.024,
                      weight: FontWeight.w600,
                      color: Colors.grey.shade800,
                      align: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
