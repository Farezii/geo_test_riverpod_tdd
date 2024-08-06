import 'package:flutter/material.dart';

class GenericHelpPage extends StatelessWidget {
  GenericHelpPage({
    super.key,
    required this.image,
    required this.textList,
    this.bulletPoints = false,
  });

  String image;
  List<String> textList;
  bool? bulletPoints;
// TODO: Generic class for help pages
// TODO: Switch text for listile, will contain only text
// leading will contain the bullet for the bullet point
// Preview: Image V ListTile
// ListTile: Required listText, optional numbers
// if no numbers, use bullets

  ListTile customListTile(int index, String item) {
    if (!bulletPoints!) {
      return ListTile(
        leading: Text(index.toString()),
        title: Text(item),
      );
    } else {
      return ListTile(
        leading: const Text('●'),
        title: Text(item),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(image),
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: textList.length,
            itemBuilder: (BuildContext context, int index) {
              return customListTile(index + 1, textList[index]);
            },
          ),
        ),
      ],
    );
  }
}
