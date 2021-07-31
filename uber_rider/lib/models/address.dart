import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Address {
  var placeFormattedAddress;
  var placeName;
  var placeId;
  var latitude;
  var longitude;
  Address({
    this.placeFormattedAddress,
    this.placeName,
    this.placeId,
    this.latitude,
    this.longitude,
  });
}
