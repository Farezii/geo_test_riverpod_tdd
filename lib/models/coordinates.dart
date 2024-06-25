import 'package:geo_test_riverpod/models/user_data.dart';

class Coordinates {
  Coordinates({
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  String toString() => 'Latitude: $latitude; Longitude: $longitude';
}

class DelimitatorCoordinates {
  DelimitatorCoordinates({
    required this.startingCoordinates,
    required this.endingCoordinates,
    required this.userData,
  });

  Coordinates startingCoordinates;
  Coordinates endingCoordinates;
  final UserData userData;
}
