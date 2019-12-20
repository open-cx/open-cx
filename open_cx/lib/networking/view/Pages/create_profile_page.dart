import 'package:open_cx/networking/model/app_state.dart';
import 'package:open_cx/networking/model/known_person.dart';
import 'package:open_cx/networking/redux/action_creators.dart';
import 'package:open_cx/networking/view/Pages/general_page_view.dart';
import 'package:open_cx/networking/view/Widgets/create_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class CreateProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store =StoreProvider.of<AppState>(context); 
    store.dispatch(queryFriendsList(store.state.content['user_id']));
    return GeneralPageView(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15.0),
        child: this.buildFriends(context)
      )
    );
  }

  Widget buildFriends(BuildContext context) {
    return StoreConnector<AppState, Set<KnownPerson>>(
        converter: (store) => store.state.content['friends'],
        builder: (context, friends) {
          return ListView(
            shrinkWrap: false,
            children: <Widget>[
              new CreateProfileForm(),
            ],
          );
        });
  }

}
