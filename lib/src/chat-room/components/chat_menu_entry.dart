import 'package:flutter/material.dart';

class ChatMenuEntry {
  const ChatMenuEntry(
      {required this.label, this.shortcut, this.onPressed, this.menuChildren})
      : assert(menuChildren == null || onPressed == null,
            'onPressed is ignored if menuChildren are provided');
  final Widget label;

  final MenuSerializableShortcut? shortcut;
  final VoidCallback? onPressed;
  final List<ChatMenuEntry>? menuChildren;

  static List<Widget> build(List<ChatMenuEntry> selections) {
    Widget buildSelection(ChatMenuEntry selection) {
      if (selection.menuChildren != null) {
        return SubmenuButton(
          menuChildren: ChatMenuEntry.build(selection.menuChildren!),
          menuStyle: const MenuStyle(
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 41, 41, 41))),
          style: const ButtonStyle(
              alignment: Alignment.centerRight,
              backgroundColor: MaterialStatePropertyAll(Colors.black)),
          child: selection.label,
        );
      }

      return MenuItemButton(
        style: const ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(125, 20)),
        ),
        shortcut: selection.shortcut,
        onPressed: selection.onPressed,
        child: selection.label,
      );
    }

    return selections.map<Widget>(buildSelection).toList();
  }

  static Map<MenuSerializableShortcut, Intent> shortcuts(
      List<ChatMenuEntry> selections) {
    final Map<MenuSerializableShortcut, Intent> result =
        <MenuSerializableShortcut, Intent>{};
    for (final ChatMenuEntry selection in selections) {
      if (selection.menuChildren != null) {
        result.addAll(ChatMenuEntry.shortcuts(selection.menuChildren!));
      } else {
        if (selection.shortcut != null && selection.onPressed != null) {
          result[selection.shortcut!] =
              VoidCallbackIntent(selection.onPressed!);
        }
      }
    }
    return result;
  }
}
