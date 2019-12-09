import 'package:open_cx/communio/model/app_state.dart';
import 'package:open_cx/communio/redux/action_creators.dart';
import 'package:open_cx/communio/view/Pages/general_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';


class HomePageView extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return GeneralPageView(
      child: createScrollableCardView(context),
      floatingActionButton: createActionButton(context),
    );
  }

  Widget createScrollableCardView(BuildContext context) {
    return  StoreConnector<AppState, int>(
      converter: (store) => store.state.content['counter'],
      builder: (context, counter){
        return Container(
          child:
            ListView(
              shrinkWrap: false,
              padding: EdgeInsets.all(20.0),
              children:<Widget>[
                 new Text(
                'The button has been clicked $counter times!',
                   style: Theme.of(context).textTheme.body2,
                ),
              ]
            ),
        );
      },
    );
  }

  Widget createActionButton(BuildContext context){
    return new FloatingActionButton(
      onPressed: () => {
        StoreProvider.of<AppState>(context).dispatch(incrementCounter())  
      },
      tooltip: 'Increment',
      child: new Icon(Icons.add),
    );
  }

}


