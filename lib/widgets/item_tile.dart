import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';

class ItemTile extends ConsumerWidget {
  const ItemTile({super.key, required this.item, required this.index});

  final dynamic item;
  final int index;

  String subtitleText(dynamic item) {
    String text = '';

    if (item is Coordinates) {
      text = 'Coordinates: ${item.latitude}, ${item.longitude}';
    } else if (item is RunData) {
      text = 'Email: ${item.email}';
    }

    return text;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (item is Coordinates) {
      return ListTile(
        leading: Text(index.toString()),
        title: Text('ID: ${item.id}'),
        subtitle: Text(subtitleText(item)),
      );
    } else if (item is RunData) {
      return ListTile(
        leading: Text(index.toString()),
        title: Text('ID: ${item.id}'),
        subtitle: Text(subtitleText(item)),
      );
    } else {
      return const ListTile(
        title: Text('Unknown item type'),
      );
    }
  }
}
