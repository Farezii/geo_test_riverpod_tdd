// Soon to be unimplemented
import 'package:flutter_test/flutter_test.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/coordinates_provider.dart';

import 'container_manip.dart';

void main() {
  group('Provider tests', () {
    RunData runData = RunData(
      email: 'teste@teste.teste',
      id: '-124122414',
    );

    List<Coordinates> mockCoordinatesSquare = [
      Coordinates(latitude: 1.0, longitude: 4.0, runData: runData),
      Coordinates(latitude: 1.0, longitude: 3, runData: runData),
      Coordinates(latitude: 1.0, longitude: 2.0, runData: runData),
      Coordinates(latitude: 1.0, longitude: 1.0, runData: runData),
      Coordinates(latitude: 2.0, longitude: 4.0, runData: runData),
      Coordinates(latitude: 2.0, longitude: 3, runData: runData),
      Coordinates(latitude: 2.0, longitude: 2.0, runData: runData),
      Coordinates(latitude: 2.0, longitude: 1.0, runData: runData),
      Coordinates(latitude: 3.0, longitude: 4.0, runData: runData),
      Coordinates(latitude: 3.0, longitude: 3, runData: runData),
      Coordinates(latitude: 3.0, longitude: 2.0, runData: runData),
      Coordinates(latitude: 3.0, longitude: 1.0, runData: runData),
      Coordinates(latitude: 4.0, longitude: 4.0, runData: runData),
      Coordinates(latitude: 4.0, longitude: 3, runData: runData),
      Coordinates(latitude: 4.0, longitude: 2.0, runData: runData),
      Coordinates(latitude: 4.0, longitude: 1.0, runData: runData),
    ];

    final Map<String, dynamic> expectedLimitsSquare = {
      'topLeftCorner': mockCoordinatesSquare
          .where((entry) => entry == mockCoordinatesSquare.first),
      'topRightCorner': mockCoordinatesSquare
          .where((entry) => entry == mockCoordinatesSquare[12]),
      'bottomLeftCorner': mockCoordinatesSquare
          .where((entry) => entry == mockCoordinatesSquare[3]),
      'bottomRightCorner': mockCoordinatesSquare
          .where((entry) => entry == mockCoordinatesSquare.last),
    };

    mockCoordinatesSquare.shuffle();

    List<Coordinates> mockCoordinatesUneven = [
      Coordinates(latitude: -50.0, longitude: -50.0, runData: runData),
      Coordinates(latitude: -50.0, longitude: 0, runData: runData),
      Coordinates(latitude: -50.0, longitude: 50.0, runData: runData),
      Coordinates(latitude: 0.0, longitude: -50.0, runData: runData),
      Coordinates(latitude: 0.0, longitude: 0, runData: runData),
      Coordinates(latitude: 0.0, longitude: 50.0, runData: runData),
      Coordinates(latitude: 50.0, longitude: -50.0, runData: runData),
      Coordinates(latitude: 50.0, longitude: 0, runData: runData),
      Coordinates(latitude: 50.0, longitude: 50.0, runData: runData),
      Coordinates(latitude: -25.3, longitude: -50.4, runData: runData),
      Coordinates(latitude: 75.4, longitude: 0, runData: runData),
      Coordinates(latitude: 45.0, longitude: -90.0, runData: runData),
      Coordinates(latitude: -123.5, longitude: 63.8, runData: runData),
    ];

    final Map<String, dynamic> expectedLimitsUneven = {
      'topLeftCorner': mockCoordinatesUneven
          .where((entry) => entry == mockCoordinatesUneven.last),
      'topRightCorner': mockCoordinatesUneven
          .where((entry) => entry == mockCoordinatesUneven[12]),
      'bottomLeftCorner': mockCoordinatesUneven
          .where((entry) => entry == mockCoordinatesUneven[3]),
      'bottomRightCorner': mockCoordinatesUneven
          .where((entry) => entry == mockCoordinatesUneven.last),
    };

    mockCoordinatesUneven.shuffle();
  });
}
