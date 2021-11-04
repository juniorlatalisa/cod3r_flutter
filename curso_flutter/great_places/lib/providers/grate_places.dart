import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  int get count => _items.length;

  Place get(index) => _items[index];

  Place add(String title, File image, double latitude, double longitude) {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title,
      location: PlaceLocation(latitude: latitude, longitude: longitude),
      image: image,
    );
    _items.add(newPlace);
    notifyListeners();
    return newPlace;
  }
}
