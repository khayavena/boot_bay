// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class DynamicDropdownWidget<T> extends StatefulWidget {
  final List<DropdownMenuItem<dynamic>> dropdownMenuItemList;
  final ValueChanged<Object> onChanged;
  T value;
  final bool isEnabled;
  final String hint;

  DynamicDropdownWidget({
    Key? key,
    required this.dropdownMenuItemList,
    required this.onChanged,
    required this.value,
    required this.hint,
    this.isEnabled = true,
  }) : super(key: key);

  @override
  _DynamicDropdownWidgetState<T> createState() =>
      _DynamicDropdownWidgetState<T>();
}

class _DynamicDropdownWidgetState<T> extends State<DynamicDropdownWidget<T>> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: IgnorePointer(
        ignoring: !widget.isEnabled,
        child: Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(0.0)),
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
              color: _color),
          child: DropdownButtonHideUnderline(
              child: DropdownButton<dynamic>(
            hint: Text(widget.hint),
            isExpanded: true,
            itemHeight: 50.0,
            style: _textStyle,
            items: widget.dropdownMenuItemList,
            onChanged: (Object? value) {
              setState(() {
                widget.onChanged(value!);
                widget.value = value as T;
              });
            },
            value: widget.value,
          )),
        ),
      ),
    );
  }

  TextStyle get _textStyle => TextStyle(
      fontSize: 15.0,
      color: widget.isEnabled ? Colors.black : Colors.grey[700]);

  Color get _color =>
      widget.isEnabled ? Colors.white : Colors.grey.withAlpha(100);
}
