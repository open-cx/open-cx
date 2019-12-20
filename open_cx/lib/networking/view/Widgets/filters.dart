import 'package:open_cx/networking/model/app_state.dart';
import 'package:open_cx/networking/redux/action_creators.dart';
import 'package:open_cx/networking/view/Widgets/filter_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import 'filter_form.dart';

class Filters extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<String>>(
      converter: (store) => store.state.content['current_filters'].toList(),
      builder: (context, filters){
        return Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 5.0
              )
            )
          ),
          child: Row(
            children: this.generateFilters(context, filters),
          ),
        );
      },
    );
  }

  generateFilters(BuildContext context, List<String> filters) {
    final List<Widget> currentFilters = List();
    currentFilters.add(this.generateNewFiltersButton(context));
    filters.forEach((filter) => currentFilters.add(
      FilterCard(
        filter: filter,
        removeFilter: (){
          StoreProvider.of<AppState>(context).dispatch(removeFilter(filter));
        },
      )
    ));
    return currentFilters;
  }

  Widget generateNewFiltersButton(BuildContext context) {
    return ClipOval(
        child: Container(
          color: Theme.of(context).colorScheme.primary,
          child:
            IconButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context){
                  return FilterForm();
                }
              ),
              icon: Icon(Icons.library_add),
            ),
        ),
    );
  }
}
