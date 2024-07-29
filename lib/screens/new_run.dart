import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/coordinates_provider.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';
import 'package:geo_test_riverpod/widgets/item_dismissable.dart';
import 'package:geo_test_riverpod/widgets/location_functions.dart';
import 'package:geolocator/geolocator.dart';

class NewRunScreen extends ConsumerStatefulWidget {
  NewRunScreen({super.key, required this.newRun});

  RunData newRun;

  @override
  ConsumerState<NewRunScreen> createState() {
    return _NewRunScreenState();
  }
}

class _NewRunScreenState extends ConsumerState<NewRunScreen> {
  late List<Coordinates> listCoordinates;

  @override
  void initState() {
    ref.read(coordinatesProvider.notifier).loadRunCoordinates(widget.newRun.id);
    listCoordinates = ref.read(coordinatesProvider);
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
    Navigator.pop(context, listCoordinates);
  }

  void deleteCurrentRun() async{
    ref.read(runDataProvider.notifier).removeRun(widget.newRun.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New run'),
        actions: [
          IconButton(
            onPressed: deleteCurrentRun,
            icon: const Icon(Icons.delete),
            tooltip: 'Delete run',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Image.network(
                  'https://media.tenor.com/eSzFEGSKahgAAAAi/orange-justice-anime.gif'),
            ),
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
