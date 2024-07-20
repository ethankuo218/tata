import 'package:flutter/material.dart';
import 'package:flutter_context_menu/flutter_context_menu.dart';

final class CustomContextMenuItem extends ContextMenuItem<String> {
  final String label;
  final IconData? icon;
  final Color? textColor;

  const CustomContextMenuItem(
      {required this.label,
      super.value,
      super.onSelected,
      this.icon,
      this.textColor});

  const CustomContextMenuItem.submenu(
      {required this.label, required super.items, this.icon, this.textColor})
      : super.submenu();

  @override
  bool get isFocusMaintained => true;

  @override
  Widget builder(BuildContext context, ContextMenuState menuState,
      [FocusNode? focusNode]) {
    return GestureDetector(
        onTap: () {
          onSelected?.call();
          menuState.close();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          child: Row(
            children: [
              if (icon != null) Icon(icon, color: textColor),
              if (icon != null) SizedBox(width: 8),
              Text(label, style: TextStyle(color: textColor ?? Colors.white)),
            ],
          ),
        ));
  }
}
