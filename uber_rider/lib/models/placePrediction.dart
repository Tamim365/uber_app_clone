import 'package:meta/meta.dart';
import 'package:flutter/foundation.dart';

class PlacePrediction {
  var secondary_text;
  var main_text;
  var place_id;
  PlacePrediction({this.secondary_text, this.main_text, this.place_id});
  PlacePrediction.fromJson(Map<String, dynamic> json) {
    place_id = json["place_id"];
    secondary_text = json["structured_formatting"]["secondary_text"];
    main_text = json["structured_formatting"]["main_text"];
  }
}
