import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum HondakuToastType { success, error, info }

class HondakuToast {
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
      builder: (context) => Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Material(
          type: MaterialType.transparency,
          child: _HondakuToastWidget(
            message: message,
            type: type,
            onDismiss: () {
              entry.remove();
            },
          ),
        ),
      ),
    );

    overlayState.insert(entry);
  }
}

class _HondakuToastWidget extends StatefulWidget {
  final String message;
  final HondakuToastType type;
  final VoidCallback onDismiss;

  const _HondakuToastWidget({
    required this.message,
    required this.type,
    required this.onDismiss,
  });

  @override
  State<_HondakuToastWidget> createState() => _HondakuToastWidgetState();
}

class _HondakuToastWidgetState extends State<_HondakuToastWidget> with SingleTickerProviderStateMixin {
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

    _controller.forward();
    _triggerHaptic();

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
        accentColor = const Color(0xFF2E7D32);
        iconBgColor = const Color(0xFFE8F5E9);
        break;
      case HondakuToastType.error:
        iconData = Icons.error_rounded;
        accentColor = const Color(0xFFC40000);
        iconBgColor = const Color(0xFFFFEBEE);
        cardBgColor = const Color(0xFFFFF5F5);
        textColor = const Color(0xFF7A0000);
        break;
      case HondakuToastType.info:
        iconData = Icons.info_rounded;
        accentColor = const Color(0xFF0288D1);
        iconBgColor = const Color(0xFFE1F5FE);
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.32),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
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
                fontSize: 13.5,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.none,
                fontFamily: 'Inter',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 14),
          Container(
            width: 1.0,
            height: 18,
            color: accentColor.withValues(alpha: 0.2),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: _dismiss,
            child: Icon(
              Icons.close_rounded,
              color: accentColor.withValues(alpha: 0.6),
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}
