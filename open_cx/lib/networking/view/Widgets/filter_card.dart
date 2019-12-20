import 'package:flutter/material.dart';

class FilterCard extends StatefulWidget {
  final String filter;
  final Function removeFilter;

  FilterCard({@required this.filter, @required this.removeFilter});

  @override
  _FilterCardState createState() => _FilterCardState(filter, removeFilter);
}

class _FilterCardState extends State<FilterCard> {
  final Function removeFilter;
  final String filter;
  final verticalPadding = 12.0;
  final horizontalPadding = 12.0;
  final horizontalMargin = 5.0;

  _FilterCardState(this.filter, this.removeFilter);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        this.removeFilter();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryVariant,
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin:
            EdgeInsets.only(right: horizontalMargin, left: horizontalMargin),
        child: Container(
            padding: EdgeInsets.only(
                top: verticalPadding,
                bottom: verticalPadding,
                left: horizontalPadding,
                right: horizontalPadding),
            child: Text(
              filter,
              style: Theme.of(context).textTheme.body2.apply(fontSizeDelta: -5),
            )),
      ),
    );
  }
}
