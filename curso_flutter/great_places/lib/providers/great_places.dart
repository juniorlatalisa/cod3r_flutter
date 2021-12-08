import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:great_places/models/place.dart';
import 'package:great_places/utils/db_util.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  Future<void> load() async {
    final dataList = await DbUtil.getData('places');
    _items = dataList
        .map((item) => Place(
              id: item['id'],
              title: item['title'],
              location: const PlaceLocation(latitude: 0, longitude: 0),
              image: File(item['image']),
            ))
        .toList();
    notifyListeners();
  }

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
    DbUtil.insert('places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
    notifyListeners();
    return newPlace;
  }
}
