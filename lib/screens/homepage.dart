import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geo_test_riverpod/models/coordinates.dart';
import 'package:geo_test_riverpod/providers/runs_provider.dart';
import 'package:geo_test_riverpod/screens/new_run.dart';
import 'package:geo_test_riverpod/utils/uuid_utils.dart';
import 'package:geo_test_riverpod/widgets/help_bottom_sheet.dart';
import 'package:geo_test_riverpod/widgets/item_dismissable.dart';

class HomepageWidget extends ConsumerStatefulWidget {
  const HomepageWidget({super.key, required this.email});

  final String email;

  @override
  ConsumerState<HomepageWidget> createState() => _HomepageWidgetState();
}

class _HomepageWidgetState extends ConsumerState<HomepageWidget> {
  int currentPageIndex = 0;

  void startNewRun() async {
    RunData newRun = RunData(
      email: widget.email,
      id: newUuidV4(ref.read(runDataProvider)),
    );

    setState(() {
      ref.read(runDataProvider.notifier).addRun(widget.email, newRun.id);
    });

    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NewRunScreen(
          newRun: newRun,
        ),
      ),
    );
  }

  void onPressLogout() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            tooltip: 'Logout',
            onPressed: onPressLogout,
            icon: const Icon(
              Icons.logout,
            ),
          ),
        title: const Text('Saved runs'),
        actions: <Widget>[
          IconButton(
            tooltip: 'New run',
            onPressed: startNewRun,
            icon: const Icon(
              Icons.library_add,
            ),
          ),
          IconButton(
            tooltip: 'Help',
            onPressed: () => helpModalBottomSheet(context), //TODO: popup showing what each button does
            icon: const Icon(
              Icons.help,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: AdaptableDismissableList(),
      ),
    );
  }
}
