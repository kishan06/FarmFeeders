import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropdownBtn extends StatefulWidget {
  DropdownBtn({
    required this.hint,
    required this.items,
    this.isEnabled = true,
    this.onItemSelected,
    bool showAddButton = false,
    this.value,
    this.bgColor,
    super.key,
  });
  final String hint;
  // final List? items;
  final void Function(String)? onItemSelected;
  final bool isEnabled;
  final List<DropdownMenuItem<dynamic>>? items;
  dynamic value;
  final Color? bgColor;
  @override
  State<DropdownBtn> createState() => _DropdownBtnState();
}

class _DropdownBtnState extends State<DropdownBtn> {
  late String label;
  // final List<String> items = [
  //   'Item1',
  //   'Item2',
  //   'Item3',
  //   'Item4',
  //   'Item5',
  //   'Item6',
  //   'Item7',
  //   'Item8',
  // ];

  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: Row(
          children: [
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: Text(
                widget.hint,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4D4D4D),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        items: widget.items,
        // widget.items!
        //     .map((item) => DropdownMenuItem<String>(
        //           value: item,
        //           child: Text(
        //             item,
        //             style: const TextStyle(
        //               fontSize: 14,
        //               fontWeight: FontWeight.bold,
        //               color: Color(0xFF4D4D4D),
        //             ),
        //             overflow: TextOverflow.ellipsis,
        //           ),
        //         ))
        //     .toList(),
        value: widget.value,
        onChanged: (value) {
          setState(() {
            selectedValue = value as String;
          });
        },
        buttonStyleData: ButtonStyleData(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 14, right: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: widget.bgColor ?? const Color(0xFFF1F1F1),
            ),
            color: widget.bgColor ?? const Color(0xFFF1F1F1),
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            Icons.keyboard_arrow_down,
          ),
          iconSize: 14,
          iconEnabledColor: Color(0xFF4D4D4D),
          iconDisabledColor: Colors.grey,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,

          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xFFF1F1F1),
          ),
          elevation: 8,
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all<double>(6),
            thumbVisibility: MaterialStateProperty.all<bool>(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 40,
          padding: EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}
