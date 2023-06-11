import 'package:flutter/material.dart';

class SelectableWidget extends StatefulWidget {
  final Widget child;
  final ValueChanged<bool> onSelect;
  // final bool initiallyInUserWidgets;

  const SelectableWidget({
    required this.child,
    required this.onSelect,
    // required this.initiallyInUserWidgets
  });

  @override
  _SelectableWidgetState createState() => _SelectableWidgetState();
}

class _SelectableWidgetState extends State<SelectableWidget> {
  // TODO: isSelected is true if widget alreayd in userWidgets
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
        widget.onSelect(isSelected);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey,
            width: 2.0,
          ),
        ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: widget.child,
        ),
      ),
    );
  }
}
