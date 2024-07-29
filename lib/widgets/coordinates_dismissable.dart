import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/coordinates_provider.dart';
import 'package:geo_test_riverpod/widgets/item_tile.dart';

// TODO: separate this widget into two similar widgets, one for coordinates and another for runs.

class CoordinatesDismissableList extends ConsumerStatefulWidget {
  CoordinatesDismissableList({super.key, required this.runId});

  String runId;

  @override
  ConsumerState<CoordinatesDismissableList> createState() => _CoordinatesDismissableListState();
}

class _CoordinatesDismissableListState extends ConsumerState<CoordinatesDismissableList> {
  late Future<void> _coordinatesInitializer;

  @override
  void initState() {
    _coordinatesInitializer = ref.read(coordinatesProvider.notifier).loadRunCoordinates(widget.runId);
    super.initState();
  }

  void _removeCoordinate(String id) {
    ref
        .read(coordinatesProvider.notifier)
        .removeCoordinates(id); // List will be of all runs
  }

  @override
  Widget build(BuildContext context) {
    final coordinatesList = ref.watch(coordinatesProvider);

    return ListView.builder(
      itemCount: coordinatesList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(coordinatesList[index].id),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (direction) {
            setState(() {
              _removeCoordinate(coordinatesList[index].id);
              coordinatesList.removeWhere((item) => coordinatesList[index].id == item.id);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item dismissed'),
              ),
            );
          },
          child: ItemTile(
            index: index,
            item: coordinatesList[index],
          ),
        );
      },
    );
  }
}