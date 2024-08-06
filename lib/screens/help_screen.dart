import 'package:flutter/material.dart';
import 'package:geo_test_riverpod/utils/help_texts.dart';
import 'package:geo_test_riverpod/widgets/help_pages.dart';
import 'package:geo_test_riverpod/widgets/page_indicator.dart';

class HelpPagesView extends StatefulWidget {
  const HelpPagesView({super.key});

  @override
  State<HelpPagesView> createState() {
    return _HelpPagesViewState();
  }
}

class _HelpPagesViewState extends State<HelpPagesView>
    with TickerProviderStateMixin {
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  List<Widget> listHelpPages = <Widget>[
    Center(
      child: GenericHelpPage(
        image: 'https://media1.tenor.com/m/R5IECfIf34YAAAAd/fish-spinning.gif',
        textList: textListHomepage,
      ), // Page showing what can the homepage do
    ),
    Center(
      child: GenericHelpPage(
        image: 'https://media1.tenor.com/m/R5IECfIf34YAAAAd/fish-spinning.gif',
        textList: textListNewRun,
      ), // Page showing what the new run page can do
    ),
    Center(
      child: GenericHelpPage(
        image: 'https://media1.tenor.com/m/R5IECfIf34YAAAAd/fish-spinning.gif',
        textList: textListDeleteRun,
        bulletPoints: true,
      ), // Show how to delete coordinates from a run
    ),
    Center(
      child: GenericHelpPage(
        image: 'https://media1.tenor.com/m/R5IECfIf34YAAAAd/fish-spinning.gif',
        textList: textListDeleteCoordinate,
        bulletPoints: true,
      ), // Page showing how to delete a run
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController();
    _tabController = TabController(length: listHelpPages.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: PageView(
            controller: _pageViewController,
            onPageChanged: _handlePageViewChanged,
            children: listHelpPages,
          ),
        ),
        PageIndicator(
          tabController: _tabController,
          currentPageIndex: _currentPageIndex,
          onUpdateCurrentPageIndex: _updateCurrentPageIndex,
          lengthPagesList: listHelpPages.length,
        )
      ],
    );
  }
}
