import 'package:fitnessapp/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonTextFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final bool isPassword;
  final IconData? prefixIcon;
  final int maxLines;
  final void Function(String)? onChanged;
  final bool isFilled;
  final Color fillColor;
  

  const CommonTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.focusNode,
    this.isPassword = false,
    this.prefixIcon,
    this.maxLines = 1,
    this.onChanged,
    this.isFilled = false,
    this.fillColor = Colors.white,
  });

  @override
  State<CommonTextFormField> createState() => _CommonTextFormFieldState();
}

class _CommonTextFormFieldState extends State<CommonTextFormField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _togglePasswordView() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      maxLines: widget.maxLines,
      onChanged: widget.onChanged,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      decoration: InputDecoration(
        isDense: true,
        filled: widget.isFilled,
        fillColor: widget.fillColor,
        labelText: widget.label,
        labelStyle: GoogleFonts.poppins(
          textStyle: TextStyle(fontSize: 16, color: AppColor.greyColor),
        ),
        prefixIcon: widget.prefixIcon != null ? Icon(widget.prefixIcon) : null,
        border: const OutlineInputBorder(),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColor.greyColor,
                ),
                onPressed: _togglePasswordView,
              )
            : null,
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.redColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.redColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.greyColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.primaryColor, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
}
