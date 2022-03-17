import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';

class MyProductsScreen extends StatefulWidget {
  const MyProductsScreen({Key? key}) : super(key: key);

  @override
  State<MyProductsScreen> createState() => _MyProductsScreenState();
}

class _MyProductsScreenState extends State<MyProductsScreen> {
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
            'https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg',
        'stock': 'true',
        'date': '12-01-2022',
        'date': '12-01-2022'
      },
      {
        'name': 'Buffallo Milk',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://5.imimg.com/data5/BS/VQ/WG/SELLER-66548153/fresh-raw-buffalo-milk-500x500.jpeg',
        'stock': 'true',
        'date': '12-01-2022',
        'date': '12-01-2022'
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
            'https://resources.commerceup.io/?key=https%3A%2F%2Fprod-admin-images.s3.ap-south-1.amazonaws.com%2FpWVdUiFHtKGqyJxESltt%2Fproduct%2F30571001191.jpg&width=800&resourceKey=pWVdUiFHtKGqyJxESltt',
        'stock': 'true',
        'date': '12-01-2022',
        'date': '12-01-2022'
      },
      {
        'name': 'Lady Finger',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://freepngimg.com/thumb/ladyfinger/42370-2-lady-finger-png-free-photo.png',
        'stock': 'false',
        'date': '12-01-2022'
      },
      {
        'name': 'Tomatoes',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '50',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://dtgxwmigmg3gc.cloudfront.net/imagery/assets/derivations/icon/256/256/true/eyJpZCI6IjYyODZjZmMzNTNiOGRmMGIyNmY3NWUwZWUyZmM4MzAyIiwic3RvcmFnZSI6InB1YmxpY19zdG9yZSJ9?signature=c4d219eadabc82e33ea702d131d4ade62f664fbfe6510461a1542c306d771d43',
        'stock': 'true',
        'date': '12-01-2022',
        'date': '12-01-2022'
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
        'url': 'https://5.imimg.com/data5/AK/RA/MY-68428614/apple-500x500.jpg',
        'stock': 'true',
        'date': '12-01-2022'
      },
      {
        'name': 'Banana',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://media.istockphoto.com/photos/banana-bunch-picture-id173242750?b=1&k=20&m=173242750&s=170667a&w=0&h=oRhLWtbAiPOxFAWeo2xEeLzwmHHm8W1mtdNOS7Dddd4=',
        'stock': 'true',
        'date': '12-01-2022'
      },
      {
        'name': 'Pineapple',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '50',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://static.libertyprim.com/files/familles/ananas-large.jpg?1569271716',
        'stock': 'true',
        'date': '12-01-2022'
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
            'https://www.sitarafoods.com/images/Sitara/image-Bilona_Process_Cow_Ghee-1590845216734.jpg',
        'stock': 'true',
        'date': '12-01-2022'
      },
      {
        'name': 'Buffalo Ghee',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://www.sitarafoods.com/images/Sitara/image-Homemade_Buffalo_Ghee-1590845173697.jpg',
        'stock': 'true',
        'date': '12-01-2022'
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
            'https://kandrafoods.com/wp-content/uploads/2021/04/sunflower-oil-sunflower-oil-sunflower-oil-png-750_750.png',
        'stock': 'true',
        'date': '12-01-2022'
      },
      {
        'name': 'Seasme Oil',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://www.thespruceeats.com/thmb/7rqWJVxeoc4oQu5aQy9YV9cUlaE=/701x394/smart/filters:no_upscale()/GettyImages-594170121-576918fd5f9b58346ab17d5f.jpg',
        'stock': 'true',
        'date': '12-01-2022'
      },
      {
        'name': 'Olive Oil',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '50',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://static.toiimg.com/thumb/74281085.cms?width=680&height=512&imgsize=1402433',
        'stock': 'true',
        'date': '12-01-2022'
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
            'https://www.chenabgourmet.com/wp-content/uploads/2022/01/foxtail-millet-koral-198789_l.jpg',
        'stock': 'true',
        'date': '12-01-2022'
      },
      {
        'name': 'Pearl',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '38',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url':
            'https://i0.wp.com/post.healthline.com/wp-content/uploads/2020/09/bajra-pearl-millet-grain-1296x728-header.jpg?w=1155&h=1528',
        'stock': 'true',
        'date': '12-01-2022'
      },
      {
        'name': 'Barnyard',
        'description':
            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
        'price': '50',
        'units': '1 kg',
        'place': 'Paravada, Visakhapatnam.',
        'url': 'https://m.media-amazon.com/images/I/510UoDkL8eL.jpg',
        'stock': 'true',
        'date': '12-01-2022'
      }
    ]
  };
  List list = [];
  @override
  Widget build(BuildContext context) {
    list = products['vegetables']!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWithTitle(context, title: "My Products".toUpperCase()),
      body: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.sort_rounded),
              onPressed: () {},
              splashRadius: 12,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                padding: EdgeInsets.all(height(context) * 0.01),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(32),
                  ),
                ),
                child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: ((context, index) {
                    return Opacity(
                      opacity: list[index]['stock'] == "true" ? 1 : 0.5,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 6),
                        child: SizedBox(
                          height: height(context) * 0.19,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextWidget(
                                    text: list[index]['name'],
                                    weight: FontWeight.w800,
                                    size: height(context) * 0.024,
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextWidget(
                                        text:
                                            "Product posted on: ${list[index]['date']}",
                                        weight: FontWeight.w500,
                                        size: height(context) * 0.013,
                                        color: Colors.blue,
                                      ),
                                      IconButton(
                                        iconSize: height(context) * 0.02,
                                        onPressed: () {
                                          print("SHOW MENU");
                                        },
                                        icon: Icon(Icons.more_vert),
                                      ),
                                    ],
                                  ),
                                ],
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                TextWidget(
                                                  text: "Rs.",
                                                  size: height(context) * 0.019,
                                                  weight: FontWeight.bold,
                                                ),
                                                TextWidget(
                                                  text:
                                                      "${list[index]['price']}",
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
                                                  size: height(context) * 0.01,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                    OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          tapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          minimumSize: Size.zero, // Set this
                                          padding: EdgeInsets.zero, // and this
                                          side: BorderSide(
                                              width: 1,
                                              color:
                                                  list[index]['stock'] == "true"
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.red),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(100))),
                                      onPressed: () {},
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 2),
                                        child: TextWidget(
                                          text: list[index]['stock'] == "true"
                                              ? "In Stock".toUpperCase()
                                              : "Out Of Stock".toUpperCase(),
                                          size: height(context) * 0.014,
                                          weight: FontWeight.bold,
                                          color: list[index]['stock'] == "true"
                                              ? Theme.of(context).primaryColor
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      thickness: 1.5,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
