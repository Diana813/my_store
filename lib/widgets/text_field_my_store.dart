import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextFieldMyStore extends StatelessWidget {
  final Function onChange;
  final String label;
  final String hint;
  final Widget leadingIcon;
  final Function onSubmited;
  final TextEditingController textEditingController;
  final String counterText;

  TextFieldMyStore(
      {this.onChange,
      this.label,
      this.hint,
      this.leadingIcon,
      this.onSubmited,
      this.textEditingController,
      this.counterText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChange,
      onSubmitted: onSubmited,
      controller: textEditingController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: leadingIcon,
          counterText: counterText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }
}
