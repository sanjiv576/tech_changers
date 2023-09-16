import 'package:flutter/material.dart';

class CustomTextFormWidget extends StatelessWidget {
  const CustomTextFormWidget({
    super.key,
    required TextEditingController fullNameController,
    required String name,
    bool? hide,
    TextInputType? keyboardType,
    required IconData frontIcon,
  })  : _fullNameController = fullNameController,
        _name = name,
        _hide = hide ?? false,
        _keyboardType = keyboardType ?? TextInputType.name,
        _frontIcon = frontIcon;

  final TextEditingController _fullNameController;
  final String _name;
  final bool _hide;
  final TextInputType _keyboardType;
  final IconData _frontIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _hide,
      keyboardType: _keyboardType,
      controller: _fullNameController,
      validator: (value) =>
          value == null || value.isEmpty ? 'Please, enter $_name' : null,
      decoration: InputDecoration(
        prefixIcon: Icon(_frontIcon),
        prefixIconColor: Colors.black,
        hintText: 'Enter $_name',
        labelText: _name,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(9),
        ),
      ),
    );
  }
}
