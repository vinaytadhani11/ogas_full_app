// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ogas_full_app/Widget/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? name;
  final String? hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final bool? readOnly;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;

  CustomTextField(
      {Key? key,
      this.hintText,
      this.controller,
      this.keyboardType,
      this.validator,
      this.maxLength,
      this.name,
      this.suffixIcon,
      this.readOnly,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          alignment: Alignment.topLeft,
          child: Text(name ?? "",
              style: TextStyle(
                color: ColorConstants.textboxTextColor.withOpacity(0.9),
                fontSize: 16,
                fontFamily: "DMSans",
                fontWeight: FontWeight.w600,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: keyboardType,
            inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
            readOnly: readOnly ?? false,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              hintStyle: const TextStyle(
                fontFamily: "DMSans",
                fontWeight: FontWeight.w400,
                color: ColorConstants.grey,
                fontSize: 15,
              ),
              hintText: hintText ?? "",
              enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(
                    color: ColorConstants.textboxTextColor, width: 1.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class LanguageModel extends StatefulWidget {
  final String? lname;
  final void Function(Object?)? lonChanged;
  final int? gvalue;
  final double? hisize;
  final double? wisize;
  final double? lansize;
  final void Function()? onnTap;
  final BoxBorder? borderr;
  final int? vvalue;

  LanguageModel(
      {Key? key,
      this.lname,
      this.lonChanged,
      this.gvalue,
      this.hisize,
      this.wisize,
      this.lansize,
      this.onnTap,
      this.borderr,
      this.vvalue})
      : super(key: key);

  @override
  State<LanguageModel> createState() => _LanguageModelState();
}

class _LanguageModelState extends State<LanguageModel> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onnTap,
      child: Container(
        padding: const EdgeInsets.only(left: 15),
        alignment: Alignment.centerLeft,
        height: widget.hisize, width: widget.wisize,
        // height: 50,width: 340,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: ColorConstants.lightGrey,
              blurRadius: 1,
              spreadRadius: 1,
            ),
          ],
          color: ColorConstants.white,
          borderRadius: BorderRadius.circular(8),
          border: widget.borderr,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.lname ?? "",
                  style: TextStyle(
                      fontSize: widget.lansize, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Radio<int>(
              value: widget.vvalue ?? 0,
              groupValue: widget.gvalue,
              onChanged: widget.lonChanged,
              activeColor: ColorConstants.orange,
              fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                if (states.contains(MaterialState.selected)) {
                  return ColorConstants.orange;
                }
                return ColorConstants.orange;
              }),
            ),
          ],
        ),
      ),
    );
  }
}
