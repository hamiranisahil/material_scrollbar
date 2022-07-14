import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'material_scrollbar_base.dart';

const double _kScrollbarThickness = 8.0;
const double _kScrollbarThicknessWithTrack = 12.0;
const double _kScrollbarMargin = 2.0;
const double _kScrollbarMinLength = 48.0;
const Radius _kScrollbarRadius = Radius.circular(8.0);
const Duration _kScrollbarFadeDuration = Duration(milliseconds: 300);
const Duration _kScrollbarTimeToFade = Duration(milliseconds: 600);

class MaterialScrollBar extends Scrollbar {
  /// [thumbColor] is the moving part of the scrollbar, which usually floats on top of the track.
  final Color thumbColor;

  /// [trackColor] is the empty space “below” the progress bar.
  final Color trackColor;

  /// [userThumbSize] is the size of the thumb in scrollbar, which is the moving part of the scrollbar
  ///
  final double? thumbSize;

  const MaterialScrollBar({
    required super.child,
    super.thickness,
    super.thumbVisibility,
    super.radius,
    required this.trackColor,
    required this.thumbColor,
    this.thumbSize,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialWhiteScrollbar(
      color: thumbColor,
      thumbVisibility: thumbVisibility,
      thickness: thickness,
      radius: radius,
      trackVisibility: true,
      trackerColor: trackColor,
      child: child,
      userThumbSize: thumbSize,
    );
  }
}

class MaterialWhiteScrollbar extends MaterialRawScrollbar {
  final Color color;
  final Color trackerColor;
  final bool? showTrackOnHover;
  final double? hoverThickness;

  const MaterialWhiteScrollbar({
    required Widget child,
    required this.color,
    required this.trackerColor,
    this.showTrackOnHover,
    this.hoverThickness,
    super.userThumbSize,
    ScrollController? controller,
    bool? thumbVisibility,
    bool? trackVisibility,
    double? thickness,
    Radius? radius,
    ScrollNotificationPredicate? notificationPredicate,
    bool? interactive,
    ScrollbarOrientation? scrollbarOrientation,
    Key? key,
  }) : super(
          key: key,
          child: child,
          controller: controller,
          thumbVisibility: thumbVisibility,
          thickness: thickness,
          radius: radius,
          trackVisibility: trackVisibility,
          fadeDuration: _kScrollbarFadeDuration,
          timeToFade: _kScrollbarTimeToFade,
          pressDuration: Duration.zero,
          notificationPredicate: notificationPredicate ?? defaultScrollNotificationPredicate,
          interactive: interactive,
          scrollbarOrientation: scrollbarOrientation,
        );

  @override
  _MaterialWhiteScrollbarState createState() => _MaterialWhiteScrollbarState();
}

class _MaterialWhiteScrollbarState extends MaterialRawScrollbarState<MaterialWhiteScrollbar> {
  late AnimationController _hoverAnimationController;
  bool _dragIsActive = false;
  bool _hoverIsActive = false;
  late ColorScheme _colorScheme;
  late ScrollbarThemeData _scrollbarTheme;

  // On Android, scrollbars should match native appearance.
  late bool _useAndroidScrollbar;

  @override
  bool get showScrollbar =>
      widget.thumbVisibility ??
      _scrollbarTheme.thumbVisibility?.resolve(_states) ??
      _scrollbarTheme.isAlwaysShown ??
      false;

  @override
  bool get enableGestures => widget.interactive ?? _scrollbarTheme.interactive ?? !_useAndroidScrollbar;

  bool get _showTrackOnHover => widget.showTrackOnHover ?? _scrollbarTheme.showTrackOnHover ?? false;

  MaterialStateProperty<bool> get _trackVisibility => MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.hovered) && _showTrackOnHover) {
          return true;
        }
        return widget.trackVisibility ?? _scrollbarTheme.trackVisibility?.resolve(states) ?? false;
      });

  Set<MaterialState> get _states => <MaterialState>{
        if (_dragIsActive) MaterialState.dragged,
        if (_hoverIsActive) MaterialState.hovered,
      };

  MaterialStateProperty<Color> get _trackColor {
    return MaterialStateProperty.all(widget.trackerColor);
  }

  MaterialStateProperty<Color> get _trackBorderColor {
    final Color onSurface = _colorScheme.onSurface;
    final Brightness brightness = _colorScheme.brightness;
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (showScrollbar && _trackVisibility.resolve(states)) {
        return _scrollbarTheme.trackBorderColor?.resolve(states) ??
            (brightness == Brightness.light ? onSurface.withOpacity(0.1) : onSurface.withOpacity(0.25));
      }
      return const Color(0x00000000);
    });
  }

  MaterialStateProperty<double> get _thickness {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.hovered) && _trackVisibility.resolve(states))
        return widget.hoverThickness ?? _scrollbarTheme.thickness?.resolve(states) ?? _kScrollbarThicknessWithTrack;
      // The default scrollbar thickness is smaller on mobile.
      return widget.thickness ??
          _scrollbarTheme.thickness?.resolve(states) ??
          (_kScrollbarThickness / (_useAndroidScrollbar ? 2 : 1));
    });
  }

  @override
  void initState() {
    super.initState();
    _hoverAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _hoverAnimationController.addListener(() {
      updateScrollbarPainter();
    });
  }

  @override
  void didChangeDependencies() {
    final ThemeData theme = Theme.of(context);
    _colorScheme = theme.colorScheme;
    _scrollbarTheme = theme.scrollbarTheme;
    switch (theme.platform) {
      case TargetPlatform.android:
        _useAndroidScrollbar = true;
        break;
      case TargetPlatform.iOS:
      case TargetPlatform.linux:
      case TargetPlatform.fuchsia:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
        _useAndroidScrollbar = false;
        break;
    }
    super.didChangeDependencies();
  }

  @override
  void updateScrollbarPainter() {
    scrollbarPainter
      ..color = widget.color
      ..trackColor = _trackColor.resolve(_states)
      ..trackBorderColor = _trackBorderColor.resolve(_states)
      ..trackRadius = widget.radius ?? _scrollbarTheme.radius ?? (_useAndroidScrollbar ? null : _kScrollbarRadius)
      ..textDirection = Directionality.of(context)
      ..thickness = _thickness.resolve(_states)
      ..radius = widget.radius ?? _scrollbarTheme.radius ?? (_useAndroidScrollbar ? null : _kScrollbarRadius)
      ..crossAxisMargin = _scrollbarTheme.crossAxisMargin ?? (_useAndroidScrollbar ? 0.0 : _kScrollbarMargin)
      ..mainAxisMargin = _scrollbarTheme.mainAxisMargin ?? 0.0
      ..minLength = _scrollbarTheme.minThumbLength ?? _kScrollbarMinLength
      // ..padding = MediaQuery.of(context).padding
      ..scrollbarOrientation = widget.scrollbarOrientation
      ..ignorePointer = !enableGestures;
  }

  @override
  void handleThumbPressStart(Offset localPosition) {
    super.handleThumbPressStart(localPosition);
    setState(() {
      _dragIsActive = true;
    });
  }

  @override
  void handleThumbPressEnd(Offset localPosition, Velocity velocity) {
    super.handleThumbPressEnd(localPosition, velocity);
    setState(() {
      _dragIsActive = false;
    });
  }

  @override
  void handleHover(PointerHoverEvent event) {
    super.handleHover(event);
    // Check if the position of the pointer falls over the painted scrollbar
    if (isPointerOverScrollbar(event.position, event.kind, forHover: true)) {
      // Pointer is hovering over the scrollbar
      setState(() {
        _hoverIsActive = true;
      });
      _hoverAnimationController.forward();
    } else if (_hoverIsActive) {
      // Pointer was, but is no longer over painted scrollbar.
      setState(() {
        _hoverIsActive = false;
      });
      _hoverAnimationController.reverse();
    }
  }

  @override
  void handleHoverExit(PointerExitEvent event) {
    super.handleHoverExit(event);
    setState(() {
      _hoverIsActive = false;
    });
    _hoverAnimationController.reverse();
  }

  @override
  void dispose() {
    _hoverAnimationController.dispose();
    super.dispose();
  }
}
