import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nandikrushi_farmer/product/product_card.dart';
import 'package:nandikrushi_farmer/product/product_provider.dart';
import 'package:nandikrushi_farmer/reusable_widgets/text_widget.dart';
import 'package:nandikrushi_farmer/reusable_widgets/textfield_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' show rootBundle;

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with TickerProviderStateMixin {
  late TabController _controller;
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    ProductProvider productProvider = Provider.of(context, listen: false);
    _controller = TabController(
        length: productProvider.categories.length,
        vsync: this,
        initialIndex: 1);
    searchController = TextEditingController();
  }

  Color? getTabBarTextColor(int i) {
    return _controller.index == i
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onSurface;
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
        child: Material(
          child: CustomScrollView(
            slivers: [
              SliverList(
                  delegate: SliverChildListDelegate([
                const SizedBox(
                  height: 280,
                  child: MapsContainer(),
                ),
                Container(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  height: 2,
                ),
              ])),
              SliverAppBar(
                leading: const SizedBox(),
                toolbarHeight: 30,
                flexibleSpace: Center(
                  child: TabBar(
                    indicatorColor: Theme.of(context).colorScheme.primary,
                    controller: _controller,
                    isScrollable: true,
                    tabs: List.generate(
                      productProvider.categories.length,
                      (index) => Tab(
                        child: TextWidget(
                          productProvider.categories.entries
                              .toList()[index]
                              .key
                              .toUpperCase(),
                          weight: getTabBarTextFontWeight(0),
                          color: getTabBarTextColor(0),
                        ),
                      ),
                    ),
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
                      color: Theme.of(context).colorScheme.surfaceVariant,
                      alignment: Alignment.center,
                      width: 24,
                      child: RotatedBox(
                        quarterTurns: -1,
                        child: TextWidget(
                          productProvider.categories.entries
                              .toList()[_controller.index]
                              .key
                              .toUpperCase(),
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
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
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
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
                                productProvider.categories.entries
                                    .toList()
                                    .length,
                                (tabIndex) => ListView.builder(
                                      itemBuilder: (context, index) {
                                        var product = productProvider
                                            .categorizedProducts[productProvider
                                                .categories.entries
                                                .toList()[tabIndex]
                                                .key]
                                            ?.where((element) =>
                                                element["name"]
                                                    ?.toLowerCase()
                                                    .contains(searchController
                                                        .text
                                                        .toLowerCase()) ??
                                                true)
                                            .toList()[index];
                                        return ProductCard(
                                            type: CardType.product,
                                            productId:
                                                product?["product_id"] ?? "XYZ",
                                            productName:
                                                product?["name"] ?? "Name",
                                            productDescription:
                                                product?["description"] ??
                                                    "Description",
                                            imageURL: product?["url"] ??
                                                "https://img.etimg.com/thumb/msid-64411656,width-640,resizemode-4,imgsize-226493/cow-milk.jpg",
                                            price: double.tryParse(
                                                    product?["price"] ??
                                                        "00.00") ??
                                                00.00,
                                            units:
                                                product?["units"] ?? "1 unit",
                                            location: product?["place"] ??
                                                "Visakhapatnam");
                                      },
                                      itemCount: productProvider
                                          .categorizedProducts[productProvider
                                              .categories.entries
                                              .toList()[tabIndex]
                                              .key]
                                          ?.where((element) =>
                                              element["name"]
                                                  ?.toLowerCase()
                                                  .contains(searchController
                                                      .text
                                                      .toLowerCase()) ??
                                              true)
                                          .length,
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

class _MapsContainerState extends State<MapsContainer>
    with WidgetsBindingObserver {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(17.7410573, 83.3093624);
  final Map<String, LatLng> markerLocations = {
    "Spotmies": const LatLng(17.744257, 83.3106602),
    "Manas's Residence": const LatLng(17.7410573, 83.3093624)
  };
  late String _darkMapStyle;
  Future _loadMapStyles() async {
    _darkMapStyle =
        await rootBundle.loadString('assets/map_styles/dark_theme.json');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _loadMapStyles();
  }

  Future _setMapStyle() async {
    final controller = await mapController;
    final theme = WidgetsBinding.instance.window.platformBrightness;
    print(theme);
    if (theme == Brightness.dark) {
      controller.setMapStyle(_darkMapStyle);
    } else {
      controller.setMapStyle(null);
    }
  }

  @override
  void didChangePlatformBrightness() {
    // TODO: implement didChangePlatformBrightness
    super.didChangePlatformBrightness();
    setState(() {
      _setMapStyle();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    WidgetsBinding.instance.removeObserver(this);
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      _setMapStyle();
    });
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
