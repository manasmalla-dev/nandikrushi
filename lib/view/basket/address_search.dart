import 'package:flutter/material.dart';
import 'package:nandikrushi/reusable_widgets/app_config.dart';
import 'package:nandikrushi/reusable_widgets/text_wid.dart';
import 'package:nandikrushi/reusable_widgets/textfield_widget.dart';

class AddressSearchScreen extends StatefulWidget {
  const AddressSearchScreen({Key? key}) : super(key: key);

  @override
  State<AddressSearchScreen> createState() => _AddressSearchScreenState();
}

class _AddressSearchScreenState extends State<AddressSearchScreen> {
  var searchController = TextEditingController();
  var addresses = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height(context) * 0.09,
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.grey[900],
            )),
        title: SizedBox(
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
              style:
                  fonts(height(context) * 0.022, FontWeight.w500, Colors.black),
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
      ),
      body: ListView.separated(
        itemBuilder: ((context, index) {
          return Container();
        }),
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemCount: addresses.where((element) => true).length,
      ),
    );
  }
}
