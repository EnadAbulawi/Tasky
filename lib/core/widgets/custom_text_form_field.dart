import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    this.maxLines,
    required this.hintText,
    this.validator,
    required this.title,
  });
  final TextEditingController controller;
  final int? maxLines;
  final String hintText;
  final Function(String?)? validator;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        TextFormField(
          onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
          validator: validator != null
              ? (String? value) => validator!(value)
              : null,
          controller: controller,
          style: Theme.of(context).textTheme.labelMedium,
          // cursorColor: Colors.white,
          maxLines: maxLines,
          decoration: InputDecoration(hintText: hintText),
        ),
      ],
    );
  }
}
