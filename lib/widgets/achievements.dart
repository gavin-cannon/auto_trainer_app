import 'package:flutter/material.dart';

class AchievementsBox extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AchievementsBox();
  }
}

class _AchievementsBox extends State<AchievementsBox> {
  final List<String> items = List.generate(8, (index) => 'Item ${index + 1}');
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey,
          width: 2)
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Number of columns in the grid
            mainAxisSpacing: 10.0, // Spacing between items vertically
            crossAxisSpacing: 10.0, // Spacing between items horizontally
            childAspectRatio: 1.0, // Ratio of item width to item height
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Show modal when item is clicked
                showModal(context, items[index]);
              },
              child: Container(
                color: Colors.blueGrey[100],
                alignment: Alignment.center,
                child: Text(
                  items[index],
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

void showModal(BuildContext context, String item) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Item Details'),
        content: Text('You clicked on $item.'),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
