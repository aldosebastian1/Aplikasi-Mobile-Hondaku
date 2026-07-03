import 'package:flutter/material.dart';

class AuthTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final IconData? icon;

  const AuthTextField({
    super.key,
    required this.hint,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: const Color(0xFF5A4D4C).withValues(alpha: 0.6),
                size: 22,
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFE8E8E8).withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 18.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Color(0xFFC40000), width: 2.0),
        ),
      ),
    );
  }
}

class AuthPasswordField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool isVisible;
  final VoidCallback onToggle;
  final IconData? icon;

  const AuthPasswordField({
    super.key,
    required this.hint,
    this.controller,
    required this.isVisible,
    required this.onToggle,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey[500],
          fontSize: 15.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: const Color(0xFF5A4D4C).withValues(alpha: 0.6),
                size: 22,
              )
            : null,
        filled: true,
        fillColor: const Color(0xFFE8E8E8).withValues(alpha: 0.5),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 18.0,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Color(0xFFC40000), width: 2.0),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: const Color(0xFF5A4D4C).withValues(alpha: 0.8),
            size: 20.0,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }
}
