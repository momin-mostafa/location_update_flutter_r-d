import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'controller.dart';

class Notify {
  Future<void> setPreviousLocation(context) async {
    Geolocator.requestPermission().then((value) async {
      if (value == LocationPermission.denied ||
          value == LocationPermission.deniedForever ||
          value == LocationPermission.unableToDetermine) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location Permission Required')));

        return;
      }
      previousPosition = await Geolocator.getCurrentPosition();
    });
  }

  double distanceThreshold = 1000;

  final Geolocator geolocator = Geolocator();

  void notify(context) async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever ||
        permission == LocationPermission.unableToDetermine) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location Permission Required')));
      return;
    }

    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      StreamSubscription<Position> positionStream =
          Geolocator.getPositionStream().listen((Position position) {
        double distance = Geolocator.distanceBetween(previousPosition!.latitude,
            previousPosition!.longitude, position.latitude, position.longitude);

        if (distance >= distanceThreshold) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('yes moved.')));
          Get.find<Controller>().updateCounter();
          previousPosition = position;
        }
      });
    }
  }

  Position? previousPosition;
}
