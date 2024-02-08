import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? prefix;
  final String? label;
  final void Function(String? value)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final int? maxLines;
  final String? Function(String? text)? validatorFunction;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.controller,
    this.autofocus = false,
    this.prefix,
    this.label,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
    this.validatorFunction,
    this.maxLines,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.onSaved, this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus!.unfocus(),
      initialValue: initialValue,
      decoration: InputDecoration(
        label: Text(label ?? ''),
        prefix: prefix != null ? Text(prefix!) : null,
      ),
      controller: controller,
      focusNode: focusNode,
      autofocus: autofocus,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      validator: validatorFunction,
    );
  }
}
