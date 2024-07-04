import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/widgets/run_list_tile.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key, required this.email});

  final String email;

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  int currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test'), actions: <Widget>[
        IconButton(
          tooltip: 'New run',
          onPressed: () {}, //TODO: add logic to add new run, using received email
          icon: const Icon(
            Icons.library_add,
          ),
        ),
        IconButton(
          tooltip: 'Show saved coordinates',
          onPressed: () {}, //TODO: To be depreciated in favor of listtile action
          icon: const Icon(
            Icons.list_alt,
          ),
        ),
      ]),
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: RunListTile(),
      ),
    );
  }
}
