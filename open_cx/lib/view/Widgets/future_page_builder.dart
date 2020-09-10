
import 'package:flutter/material.dart';

class FuturePageBuilder<T> extends StatelessWidget {
  const FuturePageBuilder({Key key, @required this.data, @required this.func})
      : super(key: key);

  final Future<T> data;
  final Function(BuildContext, T) func;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<T>(
      future: data,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          final person = snapshot.data;
          return func(context, person);
        }
        return Container();
      },
    );
  }
}