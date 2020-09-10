import 'package:communio/view/Widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GeneralPageView extends StatelessWidget {
  final Widget child;
  final Widget floatingActionButton;
  GeneralPageView({Key key, @required this.child, this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: new NavigationDrawer(parentContext: context,),
      appBar: new AppBar(
        backgroundColor: Theme.of(context).colorScheme.onBackground,
        iconTheme: new IconThemeData(
            color: Theme.of(context).colorScheme.onSurface),
        centerTitle: true,
        title: new Text('Commun.io', style: Theme.of(context).textTheme.title,
          textAlign: TextAlign.center,),
      ),
      body: Container(
          color: Theme.of(context).colorScheme.background,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: Theme.of(context).colorScheme.onBackground,
            ),
            margin: const EdgeInsets.all(15.0),
            child: child,
          )
        ),
      floatingActionButton: this.floatingActionButton,
    );
  }
}
