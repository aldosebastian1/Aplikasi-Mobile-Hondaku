import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum HondakuToastType { success, error, info }

class HondakuToast extends StatefulWidget {
  final String message;
  final HondakuToastType type;
  final VoidCallback onDismiss;

  const HondakuToast({
    super.key,
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<HondakuToast> createState() => _HondakuToastState();
}

class _HondakuToastState extends State<HondakuToast> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  bool _isDismissed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      reverseDuration: const Duration(milliseconds: 250),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
        reverseCurve: Curves.easeInCubic,
      ),
    );

    // Start animation in
    _controller.forward();

    // Trigger haptic feedback when toast mounts
    _triggerHaptic();

    // Auto-dismiss after 2.5 seconds (slightly longer to allow user action)
    Future.delayed(const Duration(milliseconds: 2500), () {
      if (mounted && !_isDismissed) {
        _dismiss();
      }
    });
  }

  void _triggerHaptic() {
    switch (widget.type) {
      case HondakuToastType.success:
        HapticFeedback.lightImpact();
        break;
      case HondakuToastType.error:
        HapticFeedback.mediumImpact();
        break;
      case HondakuToastType.info:
        HapticFeedback.selectionClick();
        break;
    }
  }

  void _dismiss() {
    if (_isDismissed) return;
    setState(() {
      _isDismissed = true;
    });
    _controller.reverse().then((_) {
      widget.onDismiss();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: _buildToastCard(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToastCard() {
    IconData iconData;
    Color accentColor;
    Color iconBgColor;
    Color cardBgColor = Colors.white;
    Color textColor = const Color(0xFF1A1A1A);

    switch (widget.type) {
      case HondakuToastType.success:
        iconData = Icons.check_circle_rounded;
        accentColor = const Color(0xFF2E7D32); // Success Green
        iconBgColor = const Color(0xFFE8F5E9);
        break;
      case HondakuToastType.error:
        iconData = Icons.error_rounded;
        accentColor = const Color(0xFFC40000); // Honda Red
        iconBgColor = const Color(0xFFFFEBEE);
        cardBgColor = const Color(0xFFFFF5F5); // Soft red background tint
        textColor = const Color(0xFF7A0000); // Darker red text for readability
        break;
      case HondakuToastType.info:
        iconData = Icons.info_rounded;
        accentColor = const Color(0xFF0288D1); // Info Blue
        iconBgColor = const Color(0xFFE1F5FE);
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16), // Wider width margin (stretches better)
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14), // Enlarge padding dimensions
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withOpacity(0.32), // More visible border
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: accentColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Flexible(
            child: Text(
              widget.message,
              style: TextStyle(
                color: textColor,
                fontSize: 13.5, // Enlarge font size slightly
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
                fontFamily: 'Inter',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 14),
          // Vertical divider to separate close button
          Container(
            width: 1.0,
            height: 18,
            color: accentColor.withOpacity(0.2),
          ),
          const SizedBox(width: 12),
          // Close button
          GestureDetector(
            onTap: _dismiss,
            child: Icon(
              Icons.close_rounded,
              color: accentColor.withOpacity(0.6),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class HondakuToastHelper {
  static void showSuccess(BuildContext context, String message) {
    _showOverlay(context, message, HondakuToastType.success);
  }

  static void showError(BuildContext context, String message) {
    _showOverlay(context, message, HondakuToastType.error);
  }

  static void showInfo(BuildContext context, String message) {
    _showOverlay(context, message, HondakuToastType.info);
  }

  static void _showOverlay(
    BuildContext context,
    String message,
    HondakuToastType type,
  ) {
    final overlayState = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: HondakuToast(
          message: message,
          type: type,
          onDismiss: () {
            entry.remove();
          },
        ),
      ),
    );

    overlayState.insert(entry);
  }
}
