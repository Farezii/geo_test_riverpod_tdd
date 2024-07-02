import 'package:flutter_test/flutter_test.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/utils/uuid_utils.dart';

void main() {
  group('Testing id creation using UuidV4', () {
    test('Creating new id with empty list', () {
      List<dynamic> stateList = [];

      final newId = newUuidV4(stateList);

      expect(newId, isA<String>());
      expect(stateList.any((runData) => runData.id == newId), false);
    });

    test('Creating new id with filled list (RunData)', () {
      List<RunData> stateList = [
        RunData(
          email: 'ass@blast.com',
        ),
        RunData(
          email: 'das@blast.com',
        ),
        RunData(
          email: 'fasfas@blast.com',
        ),
      ];

      final newId = newUuidV4(stateList);

      expect(newId, isA<String>());
      expect(stateList.any((runData) => runData.id == newId), false);
    });

    test('Creating new id with filled list (Coordinates)', () {
      List<Coordinates> stateList = [
        Coordinates(
          latitude: -54.23,
          longitude: 23.41,
          runData: RunData(
            email: 'asda@asda.asda',
          ),
        ),
        Coordinates(
          latitude: -31.23,
          longitude: 242.12,
          runData: RunData(
            email: 'asda@asda.asda',
          ),
        ),
        Coordinates(
          latitude: 54.23,
          longitude: -3.41,
          runData: RunData(
            email: 'asda@asda.asda',
          ),
        ),
      ];

      final newId = newUuidV4(stateList);

      expect(newId, isA<String>());
      expect(stateList.any((coordinateData) => coordinateData.id == newId), false);
    });
  });
}
