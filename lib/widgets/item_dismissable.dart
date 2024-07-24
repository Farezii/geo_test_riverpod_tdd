import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/coordinates_provider.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';
import 'package:geo_test_riverpod/widgets/item_tile.dart';

// TODO: separate this widget into two similar widgets, one for coordinates and another for runs.

class RunListTile extends ConsumerStatefulWidget {
  RunListTile({super.key, this.listCoordinates});

  List<Coordinates>? listCoordinates;

  @override
  ConsumerState<RunListTile> createState() => _RunListTileState();
}

class _RunListTileState extends ConsumerState<RunListTile> {
  void _removeRun(String id) {
    ref
        .read(runDataProvider.notifier)
        .removeRun(id); // List will be of all runs
  }

  void _removeCoordinate(String id) {
    ref.read(coordinatesProvider.notifier).removeCoordinates(id);
  } // List will be of all coordinates

  @override
  Widget build(BuildContext context) {
    final List<dynamic> itemList;
    if (widget.listCoordinates == null) {
      itemList = ref.read(runDataProvider); // List will be of all runs
    } else {
      itemList = widget
          .listCoordinates!; // List will be of coordinates for specific run
    }

    return ListView.builder(
      itemCount: itemList.length,
      itemBuilder: (context, index) {
        return Dismissible(
          key: Key(itemList[index].id),
          background: Container(
            color: Colors.red,
          ),
          onDismissed: (direction) {
            setState(() {
              if (widget.listCoordinates == null) {
                _removeRun(itemList[index].id);
                itemList.removeWhere((item) => itemList[index].id == item.id);
              }
            });
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item dismissed'),
              ),
            );
          },
          child: ItemTile(
            index: index,
            item: itemList[index],
          ),
        ); //TODO: take list of runs and show them via this listtile
        //TODO: click to show all coordiantes of the run, and image of the area.
      },
    );
  }
}
