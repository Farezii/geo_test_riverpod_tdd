import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/coordinates_provider.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';
import 'package:geo_test_riverpod/widgets/item_tile.dart';

// TODO: separate this widget into two similar widgets, one for coordinates and another for runs.

class RunDismissableList extends ConsumerStatefulWidget {
  const RunDismissableList({super.key});

  @override
  ConsumerState<RunDismissableList> createState() => _RunDismissableListState();
}

class _RunDismissableListState extends ConsumerState<RunDismissableList> {
  late Future<void> _runsInitializer;

  @override
  void initState() {
    _runsInitializer = ref.read(runDataProvider.notifier).loadRuns();
    super.initState();
  }

  void _removeRun(String id) {
    ref
        .read(runDataProvider.notifier)
        .removeRun(id); // List will be of all runs
  }

  @override
  Widget build(BuildContext context) {
    final runsList = ref.watch(runDataProvider);

    return ListView.builder(
      itemCount: runsList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(runsList[index].id),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (direction) {
            setState(() {
              _removeRun(runsList[index].id);
              runsList.removeWhere((item) => runsList[index].id == item.id);
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item dismissed'),
              ),
            );
          },
          child: ItemTile(
            index: index,
            item: runsList[index],
          ),
        );
      },
    );
  }
}