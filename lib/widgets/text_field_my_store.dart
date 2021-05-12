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
  final Function clearSearchResult;
  final String initialValue;

  TextFieldMyStore(
      {this.onChange,
      this.label,
      this.hint,
      this.leadingIcon,
      this.onSubmited,
      this.textEditingController,
      this.counterText,
      this.clearSearchResult,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      onChanged: onChange,
      controller: textEditingController,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: leadingIcon,
          suffixIcon: IconButton(
            onPressed: clearSearchResult,
            icon: Icon(Icons.clear),
          ),
          counterText: counterText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(25.0)))),
    );
  }
}
