import 'package:flutter/material.dart';

class FiltersBar extends StatefulWidget {
  final List<String> filters;
  final Function(String) onFilterSelected;

  FiltersBar({required this.filters, required this.onFilterSelected});

  @override
  _FiltersBarState createState() => _FiltersBarState();
}

class _FiltersBarState extends State<FiltersBar> {
  String selectedFilter = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.filters.map((filter) {
            bool isSelected = selectedFilter == filter;
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedFilter = filter;
                });
                widget.onFilterSelected(filter);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                margin: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                  color: isSelected ? const Color.fromARGB(255, 0, 140, 255) : Color.fromARGB(255, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 1.5, color: Color(0xFFFFFFFF))
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
