import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T> onChanged;
  T value;
  final bool isEnabled;
  final String hint;

  CustomDropdown({
    Key key,
    @required this.dropdownMenuItemList,
    @required this.onChanged,
    @required this.value,
    @required this.hint,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _CustomDropdownState<T> createState() => _CustomDropdownState<T>();
}

class _CustomDropdownState<T> extends State<CustomDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: IgnorePointer(
        ignoring: !widget.isEnabled,
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              color: widget.isEnabled ? Colors.white : Colors.grey.withAlpha(100)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              hint: new Text(widget.hint),
              isExpanded: true,
              itemHeight: 50.0,
              style: TextStyle(fontSize: 15.0, color: widget.isEnabled ? Colors.black : Colors.grey[700]),
              items: widget.dropdownMenuItemList,
              onChanged: (value) {

                widget.onChanged(value);
                setState(() {
                  widget.value = value;
                });
              },
              value: widget.value,
            ),
          ),
        ),
      ),
    );
  }
}
