import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';

class RunDataNotifier extends StateNotifier<List<RunData>> {
  RunDataNotifier() : super(const []);

  void loadRuns () {
    //TODO: load all runs in a list for showing
  }
}

final runDataProvider = StateNotifierProvider<RunDataNotifier, List<RunData>>(
  (ref) => RunDataNotifier(),
);
