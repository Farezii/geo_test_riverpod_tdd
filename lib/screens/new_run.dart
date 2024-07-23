import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/widgets/item_dismissable.dart';

class NewRunScreen extends StatefulWidget {
  const NewRunScreen({super.key});

  @override
  State<NewRunScreen> createState() {
    return _NewRunScreenState();
  }
}

class _NewRunScreenState extends State<NewRunScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New run'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Flexible(
              child: Image.network(
                  'https://media.tenor.com/eSzFEGSKahgAAAAi/orange-justice-anime.gif'),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text('Get position'),
            ),
            Flexible(
              child: RunListTile(),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              label: const Text('Finish Run'),
            ),
          ],
        ),
      ),
    );
  }
}
