import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  final TextEditingController textValueController;
  final String? valueKey;
  final String label;
  final Function? onValidate;
  final String hint;
  final int? maxLine;
  final TextInputType? textInputType;
  final String? initialValue;
  final Widget? suffixIcon;
  final Function? onSuffixTap;
  final bool? isEditable;
  const CustomeTextField(
      {super.key,
      required this.textValueController,
      this.maxLine,
      this.textInputType,
      this.onSuffixTap,
      this.initialValue,
      this.suffixIcon,
      this.onValidate,
      this.valueKey,
      required this.hint,
      required this.label,
      this.isEditable});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            label,
          ),
        ),
        TextFormField(
          style: const TextStyle(fontSize: 12),
          maxLines: maxLine,
          readOnly: isEditable ?? false,
          controller: textValueController,
          initialValue: initialValue,
          cursorColor: Colors.green,
          key: ValueKey(valueKey),
          validator: onValidate as String? Function(String?)?,
          textInputAction: TextInputAction.next,
          keyboardType: textInputType,
          decoration: InputDecoration(
              filled: true,
              suffixIcon: InkWell(
                onTap: onSuffixTap as void Function()?,
                child: suffixIcon!,
              ),
              hintText: hint),
        ),
      ],
    );
  }
}
