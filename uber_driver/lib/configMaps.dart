import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';

import 'Models/allUsers.dart';

String mapKey = "AIzaSyBU7G7vmeJ2MKnLqDLHj9ATpAupSDRpb0o";

User? firebaseUser;

Users? userCurrentInfo;

User? currentfirebaseUser;

StreamSubscription<Position>? homeTabPageStreamSubscription;
