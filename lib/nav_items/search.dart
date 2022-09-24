import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nandikrushi_farmer/product/product_card.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/reusable_widgets/textfield_widget.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  var tabs = ["A2 Milk", "Vegetables", "Fruits", "Ghee", "Oil", "Millets"];
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
    return _controller.index == i ? FontWeight.w800 : FontWeight.w600;
  }

  @override
  Widget build(BuildContext context) {
    _controller.addListener(
      () {
        setState(() {});
      },
    );
    return Consumer<ProductProvider>(builder: (context, productProvider, _) {
      return SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverList(
                delegate: SliverChildListDelegate([
              const SizedBox(
                height: 280,
                child: MapsContainer(),
              ),
              Container(
                color: Colors.grey,
                height: 2,
              ),
            ])),
            SliverAppBar(
              toolbarHeight: 30,
              backgroundColor: Colors.white,
              flexibleSpace: Center(
                child: TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  controller: _controller,
                  isScrollable: true,
                  tabs: [
                    Tab(
                      child: TextWidget(
                        tabs[0].toUpperCase(),
                        weight: getTabBarTextFontWeight(0),
                        color: getTabBarTextColor(0),
                      ),
                    ),
                    Tab(
                      child: TextWidget(
                        tabs[1].toUpperCase(),
                        weight: getTabBarTextFontWeight(1),
                        color: getTabBarTextColor(1),
                      ),
                    ),
                    Tab(
                      child: TextWidget(
                        tabs[2].toUpperCase(),
                        weight: getTabBarTextFontWeight(2),
                        color: getTabBarTextColor(2),
                      ),
                    ),
                    Tab(
                      child: TextWidget(
                        tabs[3].toUpperCase(),
                        weight: getTabBarTextFontWeight(3),
                        color: getTabBarTextColor(3),
                      ),
                    ),
                    Tab(
                      child: TextWidget(
                        tabs[4].toUpperCase(),
                        weight: getTabBarTextFontWeight(4),
                        color: getTabBarTextColor(4),
                      ),
                    ),
                    Tab(
                      child: TextWidget(
                        tabs[5].toUpperCase(),
                        weight: getTabBarTextFontWeight(5),
                        color: getTabBarTextColor(5),
                      ),
                    ),
                  ],
                ),
              ),
              floating: false,
              pinned: true,
            ),
            SliverFillRemaining(
              child: Row(
                children: [
                  Container(
                    height: double.infinity,
                    color: Colors.grey.shade200,
                    alignment: Alignment.center,
                    width: 24,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: TextWidget(
                        tabs[_controller.index].toUpperCase(),
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 72,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24.0),
                          child: TextFieldWidget(
                            onChanged: (_) {
                              setState(() {});
                            },
                            onSubmitField: () {
                              setState(() {});
                            },
                            textInputAction: TextInputAction.search,
                            controller: searchController,
                            label: "Search",
                            style: Theme.of(context).textTheme.titleMedium,
                            suffix: Container(
                              margin: const EdgeInsets.all(12),
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
                          children: List.generate(
                              tabs.length,
                              (tabIndex) => ListView.builder(
                                    itemBuilder: (context, index) {
                                      return ProductCard(
                                          type: CardType.product,
                                          productName:
                                              productProvider.categorizedProducts[tabs[tabIndex]]
                                                      ?[index]["name"] ??
                                                  "Name",
                                          productDescription:
                                              productProvider.categorizedProducts[tabs[tabIndex]]
                                                      ?[index]["description"] ??
                                                  "Description",
                                          imageURL: productProvider.categorizedProducts[tabs[tabIndex]]
                                                  ?[index]["url"] ??
                                              "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                                          price: double.tryParse(productProvider.categorizedProducts[tabs[tabIndex]]?[index]["price"] ?? "00.00") ??
                                              00.00,
                                          units: productProvider.categorizedProducts[tabs[tabIndex]]
                                                  ?[index]["units"] ??
                                              "1 unit",
                                          location: productProvider.categorizedProducts[tabs[tabIndex]]?[index]["place"] ?? "Visakhapatnam");
                                    },
                                    itemCount: productProvider
                                        .categorizedProducts[tabs[tabIndex]]
                                        ?.length,
                                    primary: false,
                                    shrinkWrap: true,
                                  )),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class MapsContainer extends StatefulWidget {
  const MapsContainer({Key? key}) : super(key: key);

  @override
  State<MapsContainer> createState() => _MapsContainerState();
}

class _MapsContainerState extends State<MapsContainer> {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(17.7410573, 83.3093624);
  final Map<String, LatLng> markerLocations = {
    "Spotmies": const LatLng(17.744257, 83.3106602),
    "Manas's Residence": const LatLng(17.7410573, 83.3093624)
  };

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _markers.clear();
      for (final office in markerLocations.entries) {
        final marker = Marker(
          markerId: MarkerId(office.key),
          position: LatLng(office.value.latitude, office.value.longitude),
          infoWindow: InfoWindow(
            title: office.key,
            snippet: "${office.value.latitude},${office.value.longitude}",
          ),
        );
        _markers[office.key] = marker;
      }
    });
  }

  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 16,
      ),
      markers: _markers.values.toSet(),
    );
  }
}
