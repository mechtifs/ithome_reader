import 'package:flutter/material.dart';

mixin _ScrollUnderFlexibleConfig {
  TextStyle? get collapsedTextStyle;
  TextStyle? get expandedTextStyle;
  EdgeInsetsGeometry? get collapsedTitlePadding;
  EdgeInsetsGeometry? get collapsedCenteredTitlePadding;
  EdgeInsetsGeometry? get expandedTitlePadding;
}

class _LargeScrollUnderFlexibleConfig with _ScrollUnderFlexibleConfig {
  _LargeScrollUnderFlexibleConfig(this.context);

  final BuildContext context;
  late final ThemeData _theme = Theme.of(context);
  late final ColorScheme _colors = _theme.colorScheme;
  late final TextTheme _textTheme = _theme.textTheme;

  @override
  TextStyle? get collapsedTextStyle =>
      _textTheme.titleLarge?.apply(color: _colors.onSurface);

  @override
  TextStyle? get expandedTextStyle =>
      _textTheme.headlineMedium?.apply(color: _colors.onSurface);

  @override
  EdgeInsetsGeometry? get collapsedTitlePadding =>
      const EdgeInsetsDirectional.only(start: 40);

  @override
  EdgeInsetsGeometry? get collapsedCenteredTitlePadding =>
      const EdgeInsetsDirectional.only(start: 40);

  @override
  EdgeInsetsGeometry? get expandedTitlePadding =>
      const EdgeInsets.fromLTRB(16, 0, 16, 28);
}

class _ScrollUnderFlexibleSpace extends StatelessWidget {
  const _ScrollUnderFlexibleSpace({
    required this.hasLeading,
    required this.label,
    this.actions,
  });

  final bool hasLeading;
  final String label;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    late final AppBarTheme appBarTheme = AppBarTheme.of(context);
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>()!;
    final double topPadding = MediaQuery.viewPaddingOf(context).top;
    final double collapsedHeight = settings.minExtent - topPadding;
    final double scrollUnderHeight = settings.maxExtent - settings.minExtent;
    final _ScrollUnderFlexibleConfig config;
    config = _LargeScrollUnderFlexibleConfig(context);

    late final Widget? collapsedTitle;
    late final Widget? expandedTitle;
    collapsedTitle = DefaultTextStyle(
      style: config.collapsedTextStyle!
          .copyWith(color: appBarTheme.foregroundColor),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
    expandedTitle = DefaultTextStyle(
      style: config.expandedTextStyle!
          .copyWith(color: appBarTheme.foregroundColor),
      child: Text(
        label,
        overflow: TextOverflow.ellipsis,
        maxLines: 3,
      ),
    );

    EdgeInsetsGeometry effectiveCollapsedTitlePadding = EdgeInsets.zero;
    if (hasLeading) {
      effectiveCollapsedTitlePadding = config.collapsedTitlePadding!;
    }
    final bool isCollapsed = settings.isScrolledUnder ?? false;
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: topPadding),
          child: Container(
            height: collapsedHeight,
            padding: effectiveCollapsedTitlePadding,
            child: NavigationToolbar(
              centerMiddle: false,
              middleSpacing:
                  appBarTheme.titleSpacing ?? NavigationToolbar.kMiddleSpacing,
              middle: AnimatedOpacity(
                opacity: isCollapsed ? 1 : 0,
                duration: const Duration(milliseconds: 500),
                curve: const Cubic(0.2, 0.0, 0.0, 1.0),
                child: collapsedTitle,
              ),
              trailing: actions != null
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: actions!,
                    )
                  : null,
            ),
          ),
        ),
        Flexible(
          child: ClipRect(
            child: OverflowBox(
              minHeight: scrollUnderHeight,
              maxHeight: scrollUnderHeight,
              alignment: Alignment.bottomLeft,
              child: Container(
                alignment: AlignmentDirectional.bottomStart,
                padding: config.expandedTitlePadding,
                child: expandedTitle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MultilineAppBar extends StatelessWidget {
  const MultilineAppBar({
    super.key,
    this.leading,
    required this.label,
    this.actions,
  });

  final Widget? leading;
  final String label;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      leading: leading,
      actions: actions,
      expandedHeight: 240,
      flexibleSpace: _ScrollUnderFlexibleSpace(
        hasLeading: leading != null,
        label: label,
        actions: actions,
      ),
    );
  }
}
