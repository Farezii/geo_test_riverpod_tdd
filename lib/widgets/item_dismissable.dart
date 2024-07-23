import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';
import 'package:geo_test_riverpod/widgets/item_tile.dart';

class RunListTile extends ConsumerStatefulWidget {
  RunListTile({super.key}, this.listCoordinates);

  List<Coordinates>? listCoordinates;

  @override
  ConsumerState<RunListTile> createState() => _RunListTileState();
}

class _RunListTileState extends ConsumerState<RunListTile> {

  @override
  Widget build(BuildContext context) {
    final List<dynamic> itemList;
    if(widget.listCoordinates == null){
      itemList = ref.watch(runDataProvider);
    } else {
      itemList = widget.listCoordinates!;
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
                
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item dismissed'),
                ),
              );
            },
            child: ItemTile(index: index, item: itemList[index],),); //TODO: take list of runs and show them via this listtile
            //TODO: click to show all coordiantes of the run, and image of the area.
      },
    );
  }
}
