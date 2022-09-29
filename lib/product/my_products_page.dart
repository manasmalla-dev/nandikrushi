import 'package:flutter/material.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/elevated_button.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:provider/provider.dart';

class MyProductsPage extends StatelessWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.sort_rounded,
                color: Colors.grey[900],
              ))
        ],
        title: TextWidget(
          'My Products',
          size: Theme.of(context).textTheme.titleMedium?.fontSize,
          color: Colors.grey[900],
          weight: FontWeight.w700,
        ),
      ),
      body: Consumer<ProductProvider>(builder: (context, productProvider, _) {
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
                      'Looks like you have not added any of your item to our huge database of products',
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
                      padding: const EdgeInsets.symmetric(horizontal: 42),
                      child: ElevatedButtonWidget(
                        bgColor: Theme.of(context).primaryColor,
                        trailingIcon: Icons.add_rounded,
                        buttonName: 'Add Product'.toUpperCase(),
                        textColor: Colors.white,
                        textStyle: FontWeight.w800,
                        borderRadius: 8,
                        innerPadding: 0.03,
                        onClick: () {
                          productProvider.changeScreen(1);
                          Navigator.of(context).pop();
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
