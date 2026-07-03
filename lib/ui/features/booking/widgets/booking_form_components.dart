import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingSectionTitle extends StatelessWidget {
  final Widget iconWidget;
  final String title;

  const BookingSectionTitle({
    super.key,
    required this.iconWidget,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ExcludeSemantics(child: iconWidget),
        const SizedBox(width: 7),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

class BookingIdCardIcon extends StatelessWidget {
  const BookingIdCardIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: SizedBox(
        width: 20,
        height: 20,
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  border: Border.all(color: const Color(0xFFD32F2F), width: 1.8),
                ),
              ),
            ),
            Positioned(
              left: 2,
              top: 3,
              child: Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFD32F2F), width: 1.5),
                ),
              ),
            ),
            Positioned(
              right: 2,
              top: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 7,
                    height: 1.5,
                    color: const Color(0xFFD32F2F),
                  ),
                  const SizedBox(height: 2.5),
                  Container(
                    width: 5,
                    height: 1.5,
                    color: const Color(0xFFD32F2F),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BookingLabel extends StatelessWidget {
  final String text;
  const BookingLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return ExcludeSemantics(
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
    );
  }
}

class BookingInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String semanticsLabel;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? formatters;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;

  const BookingInputField({
    super.key,
    required this.controller,
    required this.hint,
    required this.semanticsLabel,
    this.keyboardType = TextInputType.text,
    this.formatters,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: keyboardType,
        inputFormatters: formatters,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
          errorText: errorText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorStyle: const TextStyle(fontSize: 12, color: Color(0xFFD32F2F)),
        ),
      ),
    );
  }
}

class BookingDropdown extends StatelessWidget {
  final String? value;
  final String hint;
  final String semanticsLabel;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? errorText;

  const BookingDropdown({
    super.key,
    required this.value,
    required this.hint,
    required this.semanticsLabel,
    required this.items,
    required this.onChanged,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        hint: Text(
          hint,
          style: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
        ),
        icon: const ExcludeSemantics(
          child: Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFF707070),
            size: 22,
          ),
        ),
        style: const TextStyle(fontSize: 14, color: Colors.black),
        items: items
            .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
            .toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          errorText: errorText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorStyle: const TextStyle(fontSize: 12, color: Color(0xFFD32F2F)),
        ),
      ),
    );
  }
}

class BookingPhoneField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final String? errorText;

  const BookingPhoneField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.textInputAction,
    this.onSubmitted,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'No. HP (WhatsApp Aktif)',
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.phone,
        textInputAction: textInputAction,
        onSubmitted: onSubmitted,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        style: const TextStyle(fontSize: 14, color: Colors.black),
        decoration: InputDecoration(
          hintText: '812xxxx',
          hintStyle: const TextStyle(fontSize: 14, color: Color(0xFF707070)),
          errorText: errorText,
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          prefixIcon: Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
              ),
            ),
            child: const Text(
              '+62',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 58,
            minHeight: 48,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD32F2F), width: 1.2),
          ),
          errorStyle: const TextStyle(fontSize: 12, color: Color(0xFFD32F2F)),
        ),
      ),
    );
  }
}
