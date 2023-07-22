import 'package:flutter/material.dart';
import 'package:ithome_reader/widget/multiline_app_bar.dart';

class BasePageLayout extends StatelessWidget {
  const BasePageLayout({
    super.key,
    required this.title,
    required this.body,
    this.actions,
    this.hasBackButton = false,
  });

  final String title;
  final Widget body;
  final List<Widget>? actions;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) => [
        MultilineAppBar(
          label: title,
          actions: actions,
          leading: hasBackButton
              ? IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back),
                )
              : null,
        ),
      ],
      body: Material(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(36)),
        elevation: 1,
        color: Theme.of(context).colorScheme.background,
        type: MaterialType.card,
        surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
        child: body,
      ),
    );
  }
}
