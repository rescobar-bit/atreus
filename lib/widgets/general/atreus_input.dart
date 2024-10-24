import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

enum AtreusInputTypes {
  email,
  number,
  text,
}

class AtreusInput extends StatelessWidget {
  final FocusNode? inputFocus;
  final Function()? onEditingComplete;
  final ValueNotifier<bool> hiddenPasswordNotifier = ValueNotifier<bool>(true);
  final String? Function(String?)? validators;
  final String name;
  final String? initialValue;
  final bool isPassword;
  final bool isEnabled;
  final AtreusInputTypes inputType;
  final TextEditingController? controller;
  final int? maxLength;
  final InputDecoration inputStyle;

  AtreusInput({
    required this.name,
    required this.inputStyle,
    this.initialValue = '',
    this.inputType = AtreusInputTypes.text,
    this.isPassword = false,
    this.isEnabled = true,
    this.maxLength,
    this.inputFocus,
    this.validators,
    this.onEditingComplete,
    this.controller,
    super.key,
  });

  final Map<AtreusInputTypes, TextInputType> atreusInputType = {
    AtreusInputTypes.email: TextInputType.emailAddress,
    AtreusInputTypes.number: TextInputType.number,
    AtreusInputTypes.text: TextInputType.text,
  };

  @override
  Widget build(BuildContext context) {
    final effectiveController = controller ?? TextEditingController(text: initialValue);

    return ValueListenableBuilder<bool>(
      valueListenable: hiddenPasswordNotifier,
      builder: (context, hiddenPassword, child) {
        return FormBuilderTextField(
          maxLength: maxLength,
          controller: effectiveController,
          enabled: isEnabled,
          enableSuggestions: true,
          obscureText: (isPassword) ? hiddenPassword : false,
          focusNode: inputFocus,
          decoration: inputStyle,
          validator: validators,
          onEditingComplete: onEditingComplete,
          keyboardType: atreusInputType[inputType],
          cursorColor: Colors.black,
          name: name,
        );
      },
    );
  }
}
