import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/reusable_widgets/textfield_widget.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  late TabController _controller;

  late TextEditingController searchController;
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 6, vsync: this, initialIndex: 1);
    searchController = TextEditingController();
  }

  Color getTabBarTextColor(int i) {
    return _controller.index == i
        ? Theme.of(context).primaryColor
        : Colors.black;
  }

  FontWeight getTabBarTextFontWeight(int i) {
    return _controller.index == i ? FontWeight.w900 : FontWeight.w700;
  }

  var tabs = ["A2 Milk", "Vegetables", "Fruits", "Ghee", "Oil", "Millets"];
  var products = {
    'a2-milk': [
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
    ],
    'vegetables': [
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
    ],
    'fruits': [
      {
        'name': 'Apple',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '49',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url': 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple-500x500.jpg'
      },
      {
        'name': 'Banana',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://media.istockphoto.com/photos/banana-bunch-picture-id173242750?b=1&k=20&m=173242750&s=170667a&w=0&h=oRhLWtbAiPOxFAWeo2xEeLzwmHHm8W1mtdNOS7Dddd4='
      },
      {
        'name': 'Pineapple',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '50',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://static.libertyprim.com/files/familles/ananas-large.jpg?1569271716'
      }
    ],
    'ghee': [
      {
        'name': 'Cow Ghee',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '49',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://www.sitarafoods.com/images/Sitara/image-Bilona_Process_Cow_Ghee-1590845216734.jpg'
      },
      {
        'name': 'Buffalo Ghee',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://www.sitarafoods.com/images/Sitara/image-Homemade_Buffalo_Ghee-1590845173697.jpg'
      },
    ],
    'oil': [
      {
        'name': 'Sunflower Oil',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '49',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://kandrafoods.com/wp-content/uploads/2021/04/sunflower-oil-sunflower-oil-sunflower-oil-png-750_750.png'
      },
      {
        'name': 'Seasme Oil',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://www.thespruceeats.com/thmb/7rqWJVxeoc4oQu5aQy9YV9cUlaE=/701x394/smart/filters:no_upscale()/GettyImages-594170121-576918fd5f9b58346ab17d5f.jpg'
      },
      {
        'name': 'Olive Oil',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '50',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://static.toiimg.com/thumb/74281085.cms?width=680&height=512&imgsize=1402433'
      }
    ],
    'millets': [
      {
        'name': 'Foxtail',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '49',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://www.chenabgourmet.com/wp-content/uploads/2022/01/foxtail-millet-koral-198789_l.jpg'
      },
      {
        'name': 'Pearl',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/09/bajra-pearl-millet-grain-1296x728-header.jpg?w=1155&h=1528'
      },
      {
        'name': 'Barnyard',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '50',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url': 'https://m.media-amazon.com/images/I/510UoDkL8eL.jpg'
      }
    ]
  };
  @override
  Widget build(BuildContext context) {
    _controller.addListener(
      () {
        setState(() {});
      },
    );
    return Column(
      children: [
        SizedBox(
          height: height(context) * 0.3,
          child: Image.network(
            "https://media.wired.com/photos/59269cd37034dc5f91bec0f1/191:100/w_1280,c_limit/GoogleMapTA.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          color: Colors.grey,
          height: 2,
        ),
        Expanded(
          child: Row(
            children: [
              Container(
                height: height(context) * 0.71,
                color: Colors.grey.shade200,
                alignment: Alignment.center,
                width: width(context) * 0.05,
                child: RotatedBox(
                  quarterTurns: -1,
                  child: TextWidget(
                    text: tabs[_controller.index].toUpperCase(),
                    weight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                  child: Column(
                children: [
                  TabBar(
                    indicatorColor: Theme.of(context).primaryColor,
                    controller: _controller,
                    isScrollable: true,
                    tabs: [
                      Tab(
                        child: TextWidget(
                          text: tabs[0].toUpperCase(),
                          weight: getTabBarTextFontWeight(0),
                          color: getTabBarTextColor(0),
                        ),
                      ),
                      Tab(
                        child: TextWidget(
                          text: tabs[1].toUpperCase(),
                          weight: getTabBarTextFontWeight(1),
                          color: getTabBarTextColor(1),
                        ),
                      ),
                      Tab(
                        child: TextWidget(
                          text: tabs[2].toUpperCase(),
                          weight: getTabBarTextFontWeight(2),
                          color: getTabBarTextColor(2),
                        ),
                      ),
                      Tab(
                        child: TextWidget(
                          text: tabs[3].toUpperCase(),
                          weight: getTabBarTextFontWeight(3),
                          color: getTabBarTextColor(3),
                        ),
                      ),
                      Tab(
                        child: TextWidget(
                          text: tabs[4].toUpperCase(),
                          weight: getTabBarTextFontWeight(4),
                          color: getTabBarTextColor(4),
                        ),
                      ),
                      Tab(
                        child: TextWidget(
                          text: tabs[5].toUpperCase(),
                          weight: getTabBarTextFontWeight(5),
                          color: getTabBarTextColor(5),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: height(context) * 0.08,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: TextFieldWidget(
                        textInputAction: TextInputAction.search,
                        onSubmitField: () {
                          setState(() {});
                        },
                        controller: searchController,
                        label: "Search",
                        style: fonts(height(context) * 0.022, FontWeight.w500,
                            Colors.black),
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
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        ProductList(
                          list: (products['a2-milk']?.where((element) =>
                                      element['name']?.toLowerCase().contains(
                                          searchController.text
                                              .toLowerCase()) ??
                                      true)
                                  // as Iterable<Map<String, String>>?
                                  )?.toList() ??
                              [],
                        ),
                        ProductList(
                          list: (products['vegetables']?.where((element) =>
                                      element['name']?.toLowerCase().contains(
                                          searchController.text
                                              .toLowerCase()) ??
                                      true)
                                  // as Iterable<Map<String, String>>?
                                  )?.toList() ??
                              [],
                        ),
                        ProductList(
                          list: (products['fruits']?.where((element) =>
                                      element['name']?.toLowerCase().contains(
                                          searchController.text
                                              .toLowerCase()) ??
                                      true)
                                  // as Iterable<Map<String, String>>?
                                  )?.toList() ??
                              [],
                        ),
                        ProductList(
                          list: (products['ghee']?.where((element) =>
                                      element['name']?.toLowerCase().contains(
                                          searchController.text
                                              .toLowerCase()) ??
                                      true)
                                  // as Iterable<Map<String, String>>?
                                  )?.toList() ??
                              [],
                        ),
                        ProductList(
                          list: (products['oil']?.where((element) =>
                                      element['name']?.toLowerCase().contains(
                                          searchController.text
                                              .toLowerCase()) ??
                                      true)
                                  // as Iterable<Map<String, String>>?
                                  )?.toList() ??
                              [],
                        ),
                        ProductList(
                          list: (products['millets']?.where((element) =>
                                      element['name']?.toLowerCase().contains(
                                          searchController.text
                                              .toLowerCase()) ??
                                      true)
                                  // as Iterable<Map<String, String>>?
                                  )?.toList() ??
                              [],
                        ),
                      ],
                    ),
                  ),
                ],
              )),
            ],
          ),
        )
      ],
    );
  }
}

class ProductList extends StatelessWidget {
  final List list;
  const ProductList({Key? key, required this.list}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: ((context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
          child: SizedBox(
            height: height(context) * 0.16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: list[index]['name'],
                  weight: FontWeight.w800,
                  size: height(context) * 0.024,
                ),
                TextWidget(
                  text: list[index]['description'],
                ),
                SizedBox(
                  height: height(context) * 0.018,
                ),
                Flexible(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height(context) * 0.08,
                        width: height(context) * 0.08,
                        child: Image.network(
                          list[index]['url'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  TextWidget(
                                    text: "Rs.",
                                    size: height(context) * 0.019,
                                    weight: FontWeight.bold,
                                  ),
                                  TextWidget(
                                    text: "${list[index]['price']}",
                                    size: height(context) * 0.024,
                                    weight: FontWeight.w800,
                                  ),
                                ],
                              ),
                              TextWidget(
                                text: list[index]['units'],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 8,
                                  ),
                                  TextWidget(
                                    text: list[index]['place'],
                                    size: 10,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: Size.zero, // Set this
                                padding: EdgeInsets.zero, // and this
                                side: const BorderSide(width: 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
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
                          const SizedBox(
                            height: 12,
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                minimumSize: Size.zero, // Set this
                                padding: EdgeInsets.zero, // and this
                                side: BorderSide(
                                    width: 1,
                                    color: Theme.of(context).primaryColor),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onPressed: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0, vertical: 2),
                              child: TextWidget(
                                text: "Contact".toUpperCase(),
                                size: height(context) * 0.014,
                                weight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
