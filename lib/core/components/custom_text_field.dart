import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final String? initialValue;
  final TextEditingController? controller;
  final bool isPassword;
  final FocusNode? focusNode;
  final bool autofocus;
  final String? prefix;
  final String? label;
  final void Function(String? value)? onChanged;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final Function(String?)? onSaved;
  final int maxLines;
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
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.focusNode,
    this.textInputAction,
    this.onSaved,
    this.initialValue,
    this.isPassword = false,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside: (_) => FocusManager.instance.primaryFocus!.unfocus(),
      initialValue: widget.initialValue,
      decoration: InputDecoration(
          label: Text(widget.label ?? ''),
          prefix: widget.prefix != null ? Text(widget.prefix!) : null,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                  icon: _isPasswordVisible
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                )
              : null,),
      controller: widget.controller,
      obscureText: !_isPasswordVisible && widget.isPassword,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      onSaved: widget.onSaved,
      maxLines: widget.maxLines,
      inputFormatters: widget.inputFormatters,
      validator: widget.validatorFunction,
    );
  }
}
