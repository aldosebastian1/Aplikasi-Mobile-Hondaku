import 'package:flutter/material.dart';
import 'package:hondaku/l10n/app_localizations.dart';
import 'package:hondaku/ui/core/theme.dart';

class HomeSearchBar extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final VoidCallback? onClear;

  const HomeSearchBar({
    super.key,
    this.onChanged,
    this.controller,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: AppLocalizations.of(context)!.searchHint,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        prefixIcon: Icon(Icons.search, size: 18, color: Colors.grey.shade500),
        suffixIcon: (controller?.text.isNotEmpty ?? false)
            ? IconButton(
                icon: Icon(Icons.clear, size: 18, color: Colors.grey.shade500),
                onPressed: onClear,
              )
            : null,
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: const BorderSide(color: HondakuTheme.red),
        ),
      ),
    );
  }
}
