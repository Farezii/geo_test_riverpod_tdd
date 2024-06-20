import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:geolocator/geolocator.dart';

import 'package:geo_test_riverpod/widgets/location_functions.dart';

// Mock class for Geolocator
class MockGeolocatorPlatform extends Mock implements GeolocatorPlatform {}

class MockLocationSettings extends Mock implements LocationSettings {}

void main() {
  group('Geolocator functions test', () {
    test('getCurrentLocation should return Position', () async {
      // Create a mock instance
      final mockGeolocatorPlatform = MockGeolocatorPlatform();
      
      // Mock the getCurrentPosition method
      when(mockGeolocatorPlatform.getCurrentPosition()).thenAnswer((_) async => Position(
          latitude: 37.4219983,
          longitude: -122.084,
          timestamp: DateTime.now(),
          accuracy: 5.0,
          altitude: 0.0,
          altitudeAccuracy: 0.0,
          heading: 0.0,
          headingAccuracy: 0.0,
          speed: 0.0,
          speedAccuracy: 0.0));
      
      when (mockGeolocatorPlatform.isLocationServiceEnabled()).thenAnswer((_) async => true);
      when (mockGeolocatorPlatform.checkPermission()).thenAnswer((_) async => LocationPermission.whileInUse);

      // Call the function and store the result
      final position = await determinePosition();

      // Verify that the result is of type Position
      expect(position, isA<Position>());
    });
  });
}
