import 'package:flutter/foundation.dart';
import 'package:uber/models/address.dart';

class AppData extends ChangeNotifier {
  Address? pickUpLocation;
  void updatePickUpLocationAddress(Address pickUpAddress) {
    pickUpLocation = pickUpAddress;
    notifyListeners();
  }
}
