import 'package:flutter/material.dart';

class CustomTextInput extends StatelessWidget {

  final Color color;
  final String label;
  final double width;
  final int maxLength;
  final bool obscureText;
  final TextAlign textAlign;
  final TextInputType inputType;
  final Function(String value) onChanged;
  final Function(String value) validator;
  final TextEditingController controller;
  final TextCapitalization capitalization;

  CustomTextInput({
    this.width,
    this.color,
    this.inputType,
    this.onChanged,
    this.validator,
    this.maxLength,
    this.textAlign,
    this.capitalization,
    this.obscureText = false,
    @required this.label,
    @required this.controller,
  }): assert(label != null),
      assert(controller != null);
  
  @override
  Widget build(BuildContext context) {
 
    final BoxDecoration decoration = BoxDecoration(
      color: Colors.black12 ?? color,
      borderRadius: BorderRadius.circular(999.0),
    );

    final TextFormField input = TextFormField(
      validator: validator,
      maxLength: maxLength,
      controller: controller,
      obscureText: obscureText,
      cursorColor: Colors.grey,
      textAlign: textAlign ?? TextAlign.start,
      keyboardType: inputType ?? TextInputType.text,
      textCapitalization: capitalization ?? TextCapitalization.none,
      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.grey),
      decoration: InputDecoration(
        hintText: label,
        border: InputBorder.none,
        errorBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
        hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.black45),
      ),
      onChanged: onChanged,
    );

    return Container(
      height: 52.0,
      child: input,
      decoration: decoration,
      padding: EdgeInsets.symmetric(horizontal: 20.0,),
      width: MediaQuery.of(context).size.width ?? width,
    );
  }
}