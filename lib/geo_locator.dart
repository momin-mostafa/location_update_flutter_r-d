// import 'package:geolocator/geolocator.dart';

// void trackLocation(double distance) async {
//   var geolocator = Geolocator();
//   // var locationOptions =
//   //     Position(accuracy: LocationAccuracy.high, distanceFilter: 10);

//   var distance = 500.0; // meters

//   var currentLocation = await Geolocator.getCurrentPosition();
//   var destinationLocation = await _calculateDestinationLocation(
//       currentLocation.latitude, currentLocation.longitude, distance);

//   // var destinationLocation = Geolocator.distanceBetween(
//   //     currentLocation.latitude,
//   //     currentLocation.longitude,
//   //     currentLocation.latitude + 50,
//   //     currentLocation.longitude + 50);

//   Future<Position> calculateDestinationLocation(double latitude,
//       double longitude, double distance, double bearing) async {
//     var geolocator = Geolocator();
//     var offsetLocation = await geolocator.computeOffset(
//         Position(latitude, longitude), distance, bearing);
//     // return Position(offsetLocation.latitude, offsetLocation.longitude);
//   }

//   // var offset = Geolocation.

//   var locationStream = Geolocator.getPositionStream();

//   locationStream.listen((position) async {
//     var distanceInMeters = Geolocator.distanceBetween(
//         position.latitude,
//         position.longitude,
//         destinationLocation.latitude,
//         destinationLocation.longitude);

//     if (distanceInMeters >= distance) {
//       // Notify user that they have moved 500 meters away from their current location
//       print('You have moved 500 meters away from your current location');
//     }
//   });
// }

// // Future<Position> _calculateDestinationLocation(
// //     double latitude, double longitude, double distance) async {
// //   // // var geolocator = Geolocator();
// //   // var bearing = 0.0;
//   // var destinationLocation =
//   //     Geolocator.distanceBetween(latitude, longitude, latitude, longitude + 1);

// //   // return geolocator.computeOffset(
// //   //     LatLng(latitude, longitude), distance, bearing);
// // }

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class Notify {
  Future<void> init() async {
    Geolocator.requestPermission().then((value) async {
      previousPosition = await Geolocator.getCurrentPosition();
    });
  }

  // set the distance threshold to 50 meters
  double distanceThreshold = 500;

// initialize the geolocator
  final Geolocator geolocator = Geolocator();

  notify(context) async {
// set up a location stream to listen for location changes
    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream().listen((Position position) {
      // calculate the distance between the current position and the previous position
      double distance = Geolocator.distanceBetween(previousPosition!.latitude,
          previousPosition!.longitude, position.latitude, position.longitude);

      // check if the user has moved 50 meters
      if (distance >= distanceThreshold) {
        // notify the user
        // for example, you can use the Flutter Local Notifications package to display a notification
        // or you can use the Fluttertoast package to display a toast message
        // here is an example using the Fluttertoast package:
        // Fluttertoast.showToast(
        //     msg: "You have moved 50 meters!",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.grey[600],
        //     textColor: Colors.white,
        //     fontSize: 16.0);
        // log('message', name: 'location');

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('yes moved.')));

        // update the previous position to the current position
        previousPosition = position;
      }
    });
  }

// store the previous position
  Position? previousPosition;
}
