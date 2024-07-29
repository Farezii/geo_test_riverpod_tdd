import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';

Future<void> openRunCoordinatesList(RunData item, BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Basic dialog title'),
        content: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              Flexible(
                child: Image.network(
                    'https://media.tenor.com/eSzFEGSKahgAAAAi/orange-justice-anime.gif'),
              ),
              //Flexible(child: ItemTile(item: item, index: index))
              const Flexible(child: Placeholder()),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Disable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Enable'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
