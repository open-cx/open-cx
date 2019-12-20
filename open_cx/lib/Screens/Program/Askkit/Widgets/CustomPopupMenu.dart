import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPopupMenu {

  static RelativeRect _buttonMenuPosition(BuildContext c) {
    final RenderBox bar = c.findRenderObject();
    final RenderBox overlay = Overlay.of(c).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        bar.localToGlobal(bar.size.topRight(Offset.zero), ancestor: overlay),
        bar.localToGlobal(bar.size.topRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    return position;
  }

  static Future<void> show(BuildContext context, {List<Widget> items = const [], List<VoidCallback> actions = const []}) async{
    while (actions.length < items.length)
      actions.add(() {});

    List<PopupMenuItem<String>> menuItems = List();
    for (int i = 0; i < items.length; i++)
      menuItems.add(PopupMenuItem(child: items[i], value: "Value" + i.toString()));

    String choiceStr = await showMenu<String>(
        context: context,
        position: _buttonMenuPosition(context),
        items: menuItems
    );

    int choice = menuItems.indexWhere((element) => element.value == choiceStr);
    if (choice == -1)
      return;
    actions[choice]();
  }

}
