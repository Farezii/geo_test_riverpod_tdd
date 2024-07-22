import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/widgets/item_dismissable.dart';

class HomepageWidget extends StatefulWidget {
  const HomepageWidget({super.key, required this.email});

  final String email;

  @override
  State<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends State<HomepageWidget> {
  int currentPageIndex = 0;

  void startNewRun() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => HomepageWidget(
              email: widget.email,
            ))); //TODO: create new widget for new run screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test'), actions: <Widget>[
        IconButton(
          tooltip: 'New run',
          onPressed:
              () {}, //TODO: add logic to add new run, using received email
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
      body: const Padding(
        padding: EdgeInsets.all(8),
        child: Placeholder(),
      ),
    );
  }
}
