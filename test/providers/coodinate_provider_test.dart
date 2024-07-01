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

    List<Coordinates> mockCoordinates = [
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

    test('Provider starts empty', () {
      // Create a ProviderContainer for this test.
      // DO NOT share ProviderContainers between tests.
      final container = createContainer();

      // TODO: use the container to test your application.
      expect(
        container.read(coordinatesProvider),
        isEmpty,
      );
    });

    test('Provider adds new coordinate', () {
      final container = createContainer();

      expect(
        container.read(coordinatesProvider),
        isEmpty,
      );

      container
          .read(coordinatesProvider.notifier)
          .addCoordinates(mockCoordinates.first);

      expect(
        container.read(coordinatesProvider),
        hasLength(1),
      );
    });

    test('Provider resets coordinate list', () {
      final container = createContainer();

      expect(
        container.read(coordinatesProvider),
        isEmpty,
      );

      container
          .read(coordinatesProvider.notifier)
          .addCoordinates(mockCoordinates.first);

      expect(
        container.read(coordinatesProvider),
        hasLength(1),
      );

      container.read(coordinatesProvider.notifier).resetCoordinates();

      expect(
        container.read(coordinatesProvider),
        isEmpty,
      );
    });

    test('Is findDelimitations giving out an empty map', () {
      final container = createContainer();

      expect(
        container.read(coordinatesProvider),
        isEmpty,
      );

      final Map<String, dynamic> listCoordinates =
          container.read(coordinatesProvider.notifier).findDelimitations(container.read(coordinatesProvider));

      for (Coordinates? coordinate in listCoordinates.values){
        expect(coordinate, null);
      }
    });

    test('Is findDelimitations working correctly', () {
      final container = createContainer();

      expect(
        container.read(coordinatesProvider),
        isEmpty,
      );

      for (Coordinates coordinate in mockCoordinates) {
        container.read(coordinatesProvider.notifier).addCoordinates(coordinate);
      }

      expect(
        container.read(coordinatesProvider),
        hasLength(mockCoordinates.length),
      );

      final Map<String, dynamic> listCoordinates =
          container.read(coordinatesProvider.notifier).findDelimitations(container.read(coordinatesProvider));

      for (Coordinates coordinate in listCoordinates.values){
        expect(coordinate, isA<Coordinates>());
      }
    });
  });
}
