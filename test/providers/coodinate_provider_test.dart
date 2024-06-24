import 'package:flutter_test/flutter_test.dart';

import 'container_manip.dart';

void main() {
  test('Valid fields', () {
    // Create a ProviderContainer for this test.
    // DO NOT share ProviderContainers between tests.
    final container = createContainer();

    // TODO: use the container to test your application.
    expect(
      container.read(email),
      equals('some value'),
    );
    expect(
      container.read(receivedCoordinates),
      equals('some value'),
    );
    expect(
      container.read(propertyCoordinates),
      equals('some value'),
    );
  });
}