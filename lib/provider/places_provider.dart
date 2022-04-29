import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

class PlacesProvider {
  static const apiKey = 'AIzaSyBLWoBcT6V-9UDaT6jujKggai-GW0v3uYI';
  late Prediction? instance;
  Future<Prediction?> init(context) async {
    instance = await PlacesAutocomplete.show(
      context: context,
      apiKey: apiKey,
      mode: Mode.overlay,
    );
    return instance;
  }
}
