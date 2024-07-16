import 'package:flutter/material.dart';

class FiltersBar extends StatefulWidget {
  final Map<String, List<String>> filtersWithDropdown = {
    'Length': ['15 min', '30 min', '45 min', '1 hour'],
    'Muscle Groups': [
      'Full Body',
      'Rested Muscles',
      'Upper Body',
      'Lower Body',
      'Push',
      'Pull',
      'Custom?'
    ],
    'Goal': [
      'Bodybuilding',
      'Weight Loss',
      'Strength Gain',
      'Maintenence/Fitness'
    ],
    'Difficulty': ['Beginner', 'Intermediate', 'Advanced', 'Expert'],
    'Workout Location': [
      'Gym',
      'Home',
      'Bodyweight Only',
    ],
  };
  final Function(Map<String, String>) onFilterSelected;

  FiltersBar({required this.onFilterSelected});

  @override
  _FiltersBarState createState() => _FiltersBarState();
}

class _FiltersBarState extends State<FiltersBar> {
  Map<String, String> selectedSubFilters = {};

  @override
  void initState() {
    super.initState();
    // Initialize selectedSubFilters with the first option of each filter
    widget.filtersWithDropdown.forEach((filter, subFilters) {
      if (subFilters.isNotEmpty) {
        selectedSubFilters[filter] = subFilters[0];
      }
    });
    widget.onFilterSelected(selectedSubFilters);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.filtersWithDropdown.entries.map((entry) {
            String filter = entry.key;
            List<String> subFilters = entry.value;
            String selectedSubFilter =
                selectedSubFilters[filter] ?? subFilters[0];

            return Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: Row(
                children: [
                  Text(
                    filter,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  DropdownButton<String>(
                    value: selectedSubFilters[filter],
                    dropdownColor: Color.fromARGB(255, 0, 5, 10),
                    style: const TextStyle(color: Colors.white),
                    iconEnabledColor: Colors.white,
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        setState(() {
                          selectedSubFilters[filter] = newValue;
                        });
                        widget.onFilterSelected(selectedSubFilters);
                      }
                    },
                    items: subFilters
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
