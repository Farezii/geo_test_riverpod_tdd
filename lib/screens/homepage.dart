import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/coordinates_provider.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';
import 'package:geo_test_riverpod/screens/new_run.dart';
import 'package:geo_test_riverpod/utils/uuid_utils.dart';
import 'package:geo_test_riverpod/widgets/item_dismissable.dart';

class HomepageWidget extends ConsumerStatefulWidget {
  const HomepageWidget({super.key, required this.email});

  final String email;

  @override
  ConsumerState<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends ConsumerState<HomepageWidget> {
  int currentPageIndex = 0;

  void startNewRun() async {
    print('Before new run');
    print('Run Provider: ${ref.read(runDataProvider).toString()}');
    print('Coordinates Provider: ${ref.read(coordinatesProvider).toString()}');

    RunData newRun = RunData(
      email: widget.email,
      id: newUuidV4(ref.read(runDataProvider)),
    );
    final List<Coordinates> newRunCoordinates =
        await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewRunScreen(
          newRun: newRun,
        ),
      ),
    );

    print('New coordinates:');
    print(newRunCoordinates.toString());

    if (newRunCoordinates.isNotEmpty) {
      setState(() {
        ref.read(runDataProvider.notifier).addRun(widget.email, newRun.id);
        for (var item in newRunCoordinates) {
          ref
              .read(coordinatesProvider.notifier)
              .addCoordinates(item.latitude, item.longitude, newRun);
        }
      });

      print('Before new run');
      print('Run Provider: ${ref.read(runDataProvider).toString()}');
      print(
          'Coordinates Provider: ${ref.read(coordinatesProvider).toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Saved runs'), actions: <Widget>[
        IconButton(
          tooltip: 'New run',
          onPressed:
              startNewRun, //TODO: add logic to add new run, using received email
          icon: const Icon(
            Icons.library_add,
          ),
        ),
        IconButton(
          tooltip: 'Help',
          onPressed: () {}, //TODO: popup showing what each button does
          icon: const Icon(
            Icons.help,
          ),
        ),
      ]),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: RunListTile(),
      ),
    );
  }
}
