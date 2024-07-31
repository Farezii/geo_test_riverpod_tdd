import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Coordinates {
  Coordinates({
    required this.latitude, // horizontal lines
    required this.longitude, // vertical lines
    required this.runData,
    String? id,
  }) : id = id ?? uuid.v4();

  final double latitude;
  final double longitude;
  final String id;
  final RunData runData;

  @override
  String toString() =>
      'Latitude: $latitude; Longitude: $longitude. Run ${runData.id} by ${runData.email}. ID: $id';
}

class RunData {
  RunData({
    required this.email,
    String? id,
  }) : id = id ?? uuid.v4();

  final String email;
  final String id;

  @override
  String toString() =>
      'Run $id by $email.';
}
