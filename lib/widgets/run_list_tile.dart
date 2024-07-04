import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';

class RunListTile extends ConsumerStatefulWidget {
  const RunListTile({super.key});

  @override
  ConsumerState<RunListTile> createState() => _RunListTileState();
}

class _RunListTileState extends ConsumerState<RunListTile> {
  void _removeRun(String id) {
    ref.read(runDataProvider.notifier).removeRun(id);
  }

  @override
  Widget build(BuildContext context) {
    final runList = ref.watch(runDataProvider);
    return ListView.builder(
      itemCount: runList.length,
      itemBuilder: (context, index) {
        return Dismissible(
            key: Key(runList[index].id),
            background: Container(
              color: Colors.red,
            ),
            onDismissed: (direction) {
              setState(() {
                _removeRun(runList[index].id);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Item dismissed'),
                ),
              );
            },
            child: const ListTile()); //TODO: take list of runs and show them via this listtile
            //TODO: click to show all coordiantes of the run, and image of the area.
      },
    );
  }
}
