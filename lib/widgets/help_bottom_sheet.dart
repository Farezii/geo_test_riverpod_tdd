import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/screens/help_screen.dart';

void helpModalBottomSheet(BuildContext context) {
  showModalBottomSheet(
    isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Flexible(
                flex: 8,
                child: HelpPagesView(),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              )
            ],
          ),
        );
      });
}
