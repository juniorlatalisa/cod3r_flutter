import 'package:flutter/foundation.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items => [..._items];

  int get count => _items.length;

  Place get(index) => _items[index];
}
