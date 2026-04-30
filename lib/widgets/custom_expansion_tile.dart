import 'package:flutter/material.dart';

import '../app/themes/app_colors.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final Widget? leading;
  final EdgeInsetsGeometry? padding;

  const CustomExpansionTile({
    required this.title,
    required this.children,
    this.leading,
    this.padding,
    super.key,
  });

  @override
  State<CustomExpansionTile> createState() => _NoDividerExpansionTileState();
}

class _NoDividerExpansionTileState extends State<CustomExpansionTile>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: widget.leading,
          title: widget.title,
          trailing: Icon(
            _isExpanded ? Icons.expand_less : Icons.expand_more,
            color: AppColors.green70,
          ),
          onTap: () {
            setState(() => _isExpanded = !_isExpanded);
          },
        ),
        AnimatedCrossFade(
          firstChild: Container(),
          secondChild: Column(children: widget.children),
          crossFadeState: _isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}
