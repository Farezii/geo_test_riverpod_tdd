import 'package:flutter/material.dart';

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
          onPressed: () {},
          icon: const Icon(
            Icons.library_add,
          ),
          tooltip: 'New run',
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.list_alt,
          ),
          tooltip: 'Show saved coordinates',
        ),
      ]),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        indicatorColor: Colors.amber,
        destinations: const <Widget>[
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.list), label: 'All runs'),
        ],
      ),
    );
  }
}
