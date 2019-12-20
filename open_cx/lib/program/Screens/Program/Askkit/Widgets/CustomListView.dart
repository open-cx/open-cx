import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final ScrollController controller;
  final int itemCount;
  final Widget Function(BuildContext, int) itemBuilder;
  final Future<void> Function() onRefresh;

  CustomListView({@required this.onRefresh, @required this.controller, @required this.itemCount, @required this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            controller: controller,
            itemCount: itemCount,
            itemBuilder: itemBuilder,
          )
        )
    );
  }

}