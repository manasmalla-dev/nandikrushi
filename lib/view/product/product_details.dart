import 'package:flutter/material.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_bar.dart';
import 'package:nandikrushifarmer/reusable_widgets/app_config.dart';
import 'package:nandikrushifarmer/reusable_widgets/rating_widget.dart';
import 'package:nandikrushifarmer/reusable_widgets/text_wid.dart';
import 'package:nandikrushifarmer/view/search/search.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  var addedProductQuantity = 0;
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
        'status': 'accepted',
        'date': '12-01-2022',
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
        'status': 'accepted',
        'date': '12-01-2022',
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
        'status': 'pending',
        'date': '12-01-2022',
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
        'status': 'accepted',
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
        'status': 'cancelled',
        'date': '12-01-2022',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
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
        'status': 'accepted',
        'date': '12-01-2022'
      }
    ]
  };
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            appBarWithTitle(
              context,
              title: 'Brinjal',
              suffix: Container(
                width: 50,
                child: Stack(
                  children: [
                    Positioned(
                      top: 12,
                      child: Icon(
                        Icons.shopping_basket_outlined,
                        color: Colors.black,
                        size: 32,
                      ),
                    ),
                    Positioned(
                      top: 4,
                      right: 12,
                      child: ClipOval(
                        child: Container(
                          width: 16,
                          height: 16,
                          color: Colors.red,
                          child: Center(
                            child: TextWidget(
                              text: '1',
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width(context) * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height(context) * 0.2,
                      alignment: Alignment.center,
                      child: Image.network(
                          'https://resources.commerceup.io/?key=https%3A%2F%2Fprod-admin-images.s3.ap-south-1.amazonaws.com%2FpWVdUiFHtKGqyJxESltt%2Fproduct%2F30571001191.jpg&width=800&resourceKey=pWVdUiFHtKGqyJxESltt'),
                    ),
                    TextWidget(
                      text: 'Brinjal',
                      weight: FontWeight.w800,
                      size: height(context) * 0.035,
                    ),
                    TextWidget(
                      text: 'Vegetables',
                    ),
                    TextWidget(
                      text: '1 Kg',
                      weight: FontWeight.w700,
                      color: Colors.grey,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        TextWidget(
                          text: "Rs.",
                          size: height(context) * 0.027,
                          weight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        TextWidget(
                          text: "34",
                          size: height(context) * 0.03,
                          weight: FontWeight.w800,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    Row(
                      children: [
                        FixedRatingStar(),
                        FixedRatingStar(),
                        FixedRatingStar(),
                        FixedRatingStar(
                          value: 0.5,
                        ),
                        FixedRatingStar(
                          value: 0,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    Row(
                      children: [
                        addedProductQuantity == 0
                            ? OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  minimumSize: Size.zero,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 5),
                                  side: const BorderSide(width: 1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    addedProductQuantity += 1;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 2),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
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
                              )
                            : Row(
                                children: [
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.all(5),
                                      side: const BorderSide(width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        addedProductQuantity += 1;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: const Icon(
                                        Icons.add,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width(context) * 0.05,
                                  ),
                                  TextWidget(
                                      text: "$addedProductQuantity",
                                      weight: FontWeight.bold,
                                      size: height(context) * 0.02),
                                  SizedBox(
                                    width: width(context) * 0.05,
                                  ),
                                  OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      minimumSize: Size.zero,
                                      padding: EdgeInsets.all(5),
                                      side: const BorderSide(width: 1),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        addedProductQuantity -= 1;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: const Icon(
                                        Icons.remove_rounded,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                        SizedBox(
                          width: width(context) * 0.05,
                        ),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              minimumSize: Size.zero, // Set this
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 5), // and this
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
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    TextWidget(
                      text: 'Product Description',
                      weight: FontWeight.w800,
                    ),
                    TextWidget(
                        text:
                            'Deep purple and oval shaped bottle brinjals are glossy skinned vegetables with a white and ....',
                        flow: TextOverflow.visible),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    TextWidget(
                      text: 'Farmer Details',
                      weight: FontWeight.w800,
                      size: 18,
                    ),
                    TextWidget(
                      text: 'Farmer Name: Rahul Varma',
                      weight: FontWeight.w500,
                    ),
                    TextWidget(
                      text: 'Location : Paravada, Visakhapatnam. ',
                      weight: FontWeight.w500,
                    ),
                    Row(
                      children: [
                        TextWidget(
                          text: 'Certification : ',
                          weight: FontWeight.w500,
                        ),
                        TextWidget(
                          text: 'Self Declared National Farmer.',
                          weight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height(context) * 0.01,
                    ),
                    Divider(
                      thickness: 1,
                    ),
                    TextWidget(
                      text: 'More Farmer Products'.toUpperCase(),
                      weight: FontWeight.w800,
                      size: 16,
                    ),
                    SizedBox(
                      height: (height(context) * 0.16 + 24) *
                          (products['fruits']?.length ?? 0),
                      child: ProductList(
                        shouldDisableScroll: true,
                        list: products['fruits'] ?? [],
                        padding: 0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FixedRatingStar extends StatelessWidget {
  final double value;
  const FixedRatingStar({Key? key, this.value = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return value == 0
        ? Icon(
            Icons.star_outline_rounded,
            color: Colors.grey,
            size: height(context) * 0.025,
          )
        : value == 1
            ? Icon(
                Icons.star_rounded,
                color: Colors.amber,
                size: height(context) * 0.025,
              )
            : Icon(
                Icons.star_half_rounded,
                color: Colors.amber,
                size: height(context) * 0.025,
              );
  }
}
