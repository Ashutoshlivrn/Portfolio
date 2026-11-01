import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// An interactive card widget with smooth hover elevation, subtle glow border,
/// and responsive styling. Ideal for projects, skills, and experience items.
class AnimatedGlassCard extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color? hoverBorderColor;
  final Color? backgroundColor;

  const AnimatedGlassCard({
    super.key,
    required this.child,
    this.padding,
    this.onTap,
    this.borderRadius = 16.0,
    this.hoverBorderColor,
    this.backgroundColor,
  });

  @override
  State<AnimatedGlassCard> createState() => _AnimatedGlassCardState();
}

class _AnimatedGlassCardState extends State<AnimatedGlassCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final defaultBg = widget.backgroundColor ??
        (isDark ? AppColors.darkCard : AppColors.lightCard);
    final hoveredBg = isDark ? AppColors.darkCardHover : AppColors.lightCardHover;

    final defaultBorder = isDark ? AppColors.darkBorder : AppColors.lightBorder;
    final hoverBorder = widget.hoverBorderColor ?? AppColors.primary;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: widget.onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          transform: _isHovered
              ? Matrix4.translationValues(0.0, -5.0, 0.0)
              : Matrix4.identity(),
          padding: widget.padding ?? const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: _isHovered ? hoveredBg : defaultBg,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            border: Border.all(
              color: _isHovered ? hoverBorder : defaultBorder,
              width: _isHovered ? 1.5 : 1.0,
            ),
            boxShadow: [
              if (_isHovered)
                BoxShadow(
                  color: (widget.hoverBorderColor ?? AppColors.primary).withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                )
              else
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
