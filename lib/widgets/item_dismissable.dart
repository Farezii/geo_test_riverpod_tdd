import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/providers/coordinates_provider.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';
import 'package:geo_test_riverpod/widgets/item_tile.dart';

class AdaptableDismissableList extends ConsumerStatefulWidget {
  AdaptableDismissableList({super.key, this.runId = ''});

  String runId;

  @override
  ConsumerState<AdaptableDismissableList> createState() =>
      _AdaptableDismissableListState();
}

class _AdaptableDismissableListState
    extends ConsumerState<AdaptableDismissableList> {
  late Future<void> _listInitializer;

  @override
  void initState() {
    if (widget.runId.isNotEmpty) {
      _listInitializer = ref
          .read(coordinatesProvider.notifier)
          .loadRunCoordinates(widget.runId);
    } else {
      _listInitializer = ref.read(runDataProvider.notifier).loadRuns();
    }
    super.initState();
  }

  void _removeItem(String id) {
    if (widget.runId.isNotEmpty) {
      ref
        .read(coordinatesProvider.notifier)
        .removeCoordinates(id);
    } else {
      ref
        .read(runDataProvider.notifier)
        .removeRun(id);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    late final List<dynamic> itemList;

    if (widget.runId.isNotEmpty) {
      itemList = ref.watch(coordinatesProvider);
    } else {
      itemList = ref.watch(runDataProvider);
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
              _removeItem(itemList[index].id);
              itemList.removeWhere((item) => itemList[index].id == item.id);
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
        );
      },
    );
  }
}
