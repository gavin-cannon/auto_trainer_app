import 'package:auto_trainer/data/models/achievement.dart';
import 'package:flutter/material.dart';

class AchievementsBox extends StatefulWidget {
  final List<Achievement> achievements;

  const AchievementsBox({super.key, required this.achievements});

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
        decoration:
            BoxDecoration(border: Border.all(color: Colors.blueGrey, width: 2)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // Number of columns in the grid
              mainAxisSpacing: 10.0, // Spacing between items vertically
              crossAxisSpacing: 10.0, // Spacing between items horizontally
              childAspectRatio: 1.0, // Ratio of item width to item height
            ),
            itemCount: widget.achievements.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Show modal when item is clicked
                  showModal(context, widget.achievements[index]);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: widget.achievements[index].completed
                        ? Colors.green
                        : Colors.grey[850],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      widget.achievements[index].name,
                      style: TextStyle(fontSize: 18.0, color: Colors.white, ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

void showModal(BuildContext context, Achievement item) {
  var status;
  var requirement;
  var message;
  if (item.completed) {
    status = 'Completed';
  } else {
    status = 'Incomplete';
  }
  if (item.requirementType == 'max') {
    requirement =
        'Requirement: Reach ${item.requirementAmount} on ${item.requirementField}';
    message = 'Congratulations! You have shown great strength!';
  } else if (item.requirementType == 'customer') {
    requirement = 'Requirement: ${item.requirementField}';
    message = 'Thank you, for your patronage!';
  }
  if (item.requirementType == 'total') {
    requirement =
        'Requirement: Reach ${item.requirementAmount} ${item.requirementField}';
    message =
        'Congratulations you have shown great determination and endurance!';
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('${item.name}', style: TextStyle(color: Colors.white)),
        content: Column(
          children: [
            Text('Status: ${status}.', style: TextStyle(color: Colors.white)),
            Text('${requirement}.', style: TextStyle(color: Colors.white)),
            Text(item.completed ? '${message}' : 'Keep trying!', style: TextStyle(color: Colors.white)),
          ],
        ),
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
