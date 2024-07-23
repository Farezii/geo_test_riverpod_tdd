import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';

class ItemTile extends StatelessWidget {
  final dynamic item;
  final int index;

  const ItemTile({super.key, required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    if (item is Coordinates) {
      return ListTile(
        leading: Text(index.toString()),
        title: Text('ID: ${item.id}'),
        subtitle: Text('Coordinates: ${item.latitude}, ${item.longitude}'),
      );
    } else if (item is RunData) {
      return ListTile(
        leading: Text(index.toString()),
        title: Text('ID: ${item.id}'),
        subtitle: Text('Email: ${item.email}'),
      );
    } else {
      return const ListTile(
        title: Text('Unknown item type'),
      );
    }
  }
}