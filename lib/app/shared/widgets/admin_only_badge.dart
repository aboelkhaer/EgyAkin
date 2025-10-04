import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../exports.dart';
import '../../services/theme_bloc.dart';

class AdminOnlyBadge extends StatefulWidget {
  final Widget child;
  final String? badgeText;
  final Color? badgeColor;
  final Color? textColor;
  final double? fontSize;
  final EdgeInsetsGeometry? badgePadding;
  final BorderRadius? borderRadius;
  final bool showIcon;
  final AlignmentGeometry? alignment;
  final bool animated;
  final double? top;
  final double? bottom;
  final double? left;
  final double? right;
  final bool glowEffect;
  final bool pulseAnimation;
  final bool showTooltip;
  final String? tooltipMessage;
  final BadgeStyle style;
  final bool showBadge;

  const AdminOnlyBadge({
    super.key,
    required this.child,
    this.badgeText,
    this.badgeColor,
    this.textColor,
    this.fontSize,
    this.badgePadding,
    this.borderRadius,
    this.showIcon = true,
    this.alignment,
    this.animated = true,
    this.top,
    this.bottom,
    this.left,
    this.right,
    this.glowEffect = true,
    this.pulseAnimation = false,
    this.showTooltip = true,
    this.tooltipMessage,
    this.style = BadgeStyle.premium,
    this.showBadge = true,
  });

  @override
  State<AdminOnlyBadge> createState() => _AdminOnlyBadgeState();
}

enum BadgeStyle {
  premium,
  neon,
  gradient,
  glassmorphism,
  cyberpunk,
}

class _AdminOnlyBadgeState extends State<AdminOnlyBadge>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _glowController;
  late AnimationController _scaleController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _glowAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _glowController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    if (widget.animated) {
      _scaleController.forward();
    }

    if (widget.pulseAnimation) {
      _pulseController.repeat(reverse: true);
    }

    if (widget.glowEffect) {
      _glowController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _glowController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        Widget badge = _buildBadgeContent(isDarkMode);

        if (widget.showTooltip) {
          badge = Tooltip(
            message: widget.tooltipMessage ??
                'Admin Only Feature - Exclusive Access',
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.grey.shade800 : Colors.grey.shade700,
              borderRadius: BorderRadius.circular(8.r),
            ),
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
            child: badge,
          );
        }

        return Stack(
          clipBehavior: Clip.none,
          children: [
            widget.child,
            if (widget.showBadge)
              Positioned(
                top: widget.top ?? -6,
                bottom: widget.bottom,
                right: widget.right ??
                    (widget.alignment == Alignment.centerLeft ? null : -6),
                left: widget.left ??
                    (widget.alignment == Alignment.centerLeft ? -6 : null),
                child: widget.animated
                    ? AnimatedBuilder(
                        animation: Listenable.merge([
                          _scaleAnimation,
                          if (widget.pulseAnimation) _pulseAnimation,
                          if (widget.glowEffect) _glowAnimation,
                        ]),
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _scaleAnimation.value *
                                (widget.pulseAnimation
                                    ? _pulseAnimation.value
                                    : 1.0),
                            child: badge,
                          );
                        },
                      )
                    : badge,
              ),
          ],
        );
      },
    );
  }

  Widget _buildBadgeContent(bool isDarkMode) {
    switch (widget.style) {
      case BadgeStyle.premium:
        return _buildPremiumBadge(isDarkMode);
      case BadgeStyle.neon:
        return _buildNeonBadge(isDarkMode);
      case BadgeStyle.gradient:
        return _buildGradientBadge(isDarkMode);
      case BadgeStyle.glassmorphism:
        return _buildGlassmorphismBadge(isDarkMode);
      case BadgeStyle.cyberpunk:
        return _buildCyberpunkBadge(isDarkMode);
    }
  }

  Widget _buildPremiumBadge(bool isDarkMode) {
    return Container(
      padding: widget.badgePadding ??
          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.badgeColor != null
              ? [widget.badgeColor!, widget.badgeColor!.withOpacity(0.8)]
              : isDarkMode
                  ? [Colors.amber.shade600, Colors.orange.shade700]
                  : [Colors.amber.shade500, Colors.orange.shade600],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color:
                (widget.badgeColor ?? Colors.orange.shade600).withOpacity(0.4),
            blurRadius: widget.glowEffect ? 8 + (_glowAnimation.value * 4) : 6,
            offset: const Offset(0, 2),
            spreadRadius: widget.glowEffect ? _glowAnimation.value * 2 : 0,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: _buildBadgeText(Colors.white),
    );
  }

  Widget _buildNeonBadge(bool isDarkMode) {
    final neonColor = widget.badgeColor ?? Colors.cyan;
    return Container(
      padding: widget.badgePadding ??
          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: neonColor.withOpacity(0.1),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16.r),
        border: Border.all(
          color: neonColor,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: neonColor.withOpacity(0.6),
            blurRadius: 10 + (_glowAnimation.value * 5),
            spreadRadius: 2,
          ),
          BoxShadow(
            color: neonColor.withOpacity(0.3),
            blurRadius: 20 + (_glowAnimation.value * 10),
            spreadRadius: 4,
          ),
        ],
      ),
      child: _buildBadgeText(neonColor),
    );
  }

  Widget _buildGradientBadge(bool isDarkMode) {
    return Container(
      padding: widget.badgePadding ??
          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple.shade400,
            Colors.pink.shade400,
            Colors.orange.shade400,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: widget.borderRadius ?? BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
            spreadRadius: 1,
          ),
        ],
      ),
      child: _buildBadgeText(Colors.white),
    );
  }

  Widget _buildGlassmorphismBadge(bool isDarkMode) {
    return ClipRRect(
      borderRadius: widget.borderRadius ?? BorderRadius.circular(16.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: widget.badgePadding ??
              EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(isDarkMode ? 0.1 : 0.2),
            borderRadius: widget.borderRadius ?? BorderRadius.circular(16.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _buildBadgeText(isDarkMode ? Colors.white : Colors.black87),
        ),
      ),
    );
  }

  Widget _buildCyberpunkBadge(bool isDarkMode) {
    return Container(
      padding: widget.badgePadding ??
          EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
      decoration: BoxDecoration(
        color: Colors.black87,
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: Colors.green.shade400,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.green.shade400.withOpacity(0.5),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: _buildBadgeText(Colors.green.shade400),
    );
  }

  Widget _buildBadgeText(Color textColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showIcon) ...[
          Icon(
            Icons.admin_panel_settings,
            size: (widget.fontSize ?? 8.sp) + 2,
            color: widget.textColor ?? textColor,
          ),
          SizedBox(width: 3.w),
        ],
        Text(
          widget.badgeText ?? 'Admin',
          style: TextStyle(
            color: widget.textColor ?? textColor,
            fontSize: widget.fontSize ?? 8.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.8,
            shadows: widget.style == BadgeStyle.neon ||
                    widget.style == BadgeStyle.cyberpunk
                ? [
                    Shadow(
                      color: textColor.withOpacity(0.8),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
        ),
      ],
    );
  }
}

// Alternative banner-style widget
class AdminOnlyBanner extends StatelessWidget {
  final Widget child;
  final String? bannerText;
  final Color? bannerColor;
  final Color? textColor;
  final double? fontSize;
  final bool showIcon;
  final EdgeInsetsGeometry? margin;

  const AdminOnlyBanner({
    super.key,
    required this.child,
    this.bannerText,
    this.bannerColor,
    this.textColor,
    this.fontSize,
    this.showIcon = true,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: margin ?? EdgeInsets.only(bottom: 8.h),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: bannerColor ??
                    (isDarkMode
                        ? Colors.orange.shade700
                        : Colors.orange.shade600),
                borderRadius: BorderRadius.circular(6.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showIcon) ...[
                    Icon(
                      Icons.admin_panel_settings,
                      size: (fontSize ?? 8.sp) + 2,
                      color: textColor ?? Colors.white,
                    ),
                    SizedBox(width: 4.w),
                  ],
                  Text(
                    bannerText ?? 'Admin Only',
                    style: TextStyle(
                      color: textColor ?? Colors.white,
                      fontSize: fontSize ?? 11.sp,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            child,
          ],
        );
      },
    );
  }
}

// Simple mark/indicator widget
class AdminOnlyMark extends StatelessWidget {
  final Widget child;
  final Color? markColor;
  final double? size;
  final AlignmentGeometry? alignment;

  const AdminOnlyMark({
    super.key,
    required this.child,
    this.markColor,
    this.size,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        final isDarkMode = themeState is ThemeLoaded && themeState.isDarkMode;

        return Stack(
          clipBehavior: Clip.none,
          children: [
            child,
            Positioned(
              top: -4,
              right: alignment == Alignment.centerLeft ? null : -4,
              left: alignment == Alignment.centerLeft ? -4 : null,
              child: Container(
                width: size ?? 12.r,
                height: size ?? 12.r,
                decoration: BoxDecoration(
                  color: markColor ??
                      (isDarkMode
                          ? Colors.orange.shade700
                          : Colors.orange.shade600),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isDarkMode ? AppColors.darkScaffoldBG : Colors.white,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 3,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.star,
                  size: (size ?? 12.r) * 0.6,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
