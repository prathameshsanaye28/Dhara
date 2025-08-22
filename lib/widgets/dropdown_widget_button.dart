import 'package:flutter/material.dart';

class DropdownButtonWidget extends StatefulWidget {
  final List<String> options;
  final String initialValue;
  final TextEditingController controller;
  final String label;
  const DropdownButtonWidget({
    Key? key,
    required this.options,
    required this.initialValue,
    required this.controller,
    required this.label
  }) : super(key: key);

  @override
  _DropdownButtonWidgetState createState() => _DropdownButtonWidgetState();
}

class _DropdownButtonWidgetState extends State<DropdownButtonWidget> {
  String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    widget.controller.text = _selectedValue!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
      Text(widget.label,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: Colors.white),),
      SizedBox(height: 5,),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: DropdownButton<String>(
            style: TextStyle(color: Colors.white),
             dropdownColor: Colors.black,
            value: _selectedValue,
            onChanged: (value) {
              setState(() {
                _selectedValue = value;
                widget.controller.text = _selectedValue!;
              });
            },
            items: widget.options.map((option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(option),
                ),
              );
            }).toList(),
            isExpanded: true,
            underline: const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }
}