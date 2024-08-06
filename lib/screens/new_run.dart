import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/coordinates_provider.dart';
import 'package:geo_test_riverpod/widgets/item_dismissable.dart';
import 'package:geo_test_riverpod/widgets/location_functions.dart';
import 'package:geo_test_riverpod/widgets/maps/render_map.dart';
import 'package:geolocator/geolocator.dart';

class NewRunScreen extends ConsumerStatefulWidget {
  const NewRunScreen({super.key, required this.newRun});

  final RunData newRun;

  @override
  ConsumerState<NewRunScreen> createState() {
    return _NewRunScreenState();
  }
}

class _NewRunScreenState extends ConsumerState<NewRunScreen> {
  List<Coordinates> listCoordinates = [];
  List<Coordinates> originalListCoordinates = [];

  @override
  void initState() {
    ref.read(coordinatesProvider.notifier).loadRunCoordinates(widget.newRun.id);
    listCoordinates = ref.read(coordinatesProvider).toList();
    originalListCoordinates = listCoordinates;
    super.initState();
  }

  void getNewPosition() async {
    Position newPosition = await determinePosition();
    setState(() {
      listCoordinates.add(
        Coordinates(
            latitude: newPosition.latitude,
            longitude: newPosition.longitude,
            runData: widget.newRun),
      );
      ref.read(coordinatesProvider.notifier).addCoordinates(
          newPosition.latitude, newPosition.longitude, widget.newRun);
    });
  }

  void saveCurrentRun() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('New run'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(child: LatestCoordinateMap()),
            ElevatedButton.icon(
              onPressed: getNewPosition,
              label: const Text('Get position'),
            ),
            Flexible(
              child: AdaptableDismissableList(
                runId: widget.newRun.id,
              ),
            ),
            ElevatedButton.icon(
              onPressed: saveCurrentRun,
              label: const Text('Finish Run'),
            ),
          ],
        ),
      ),
    );
  }
}
