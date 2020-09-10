import 'package:communio/model/app_state.dart';
import 'package:communio/model/known_person.dart';
import 'package:communio/redux/action_creators.dart';
import 'package:communio/view/Pages/general_page_view.dart';
import 'package:communio/view/Widgets/friend_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

class ConnectedListingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store =StoreProvider.of<AppState>(context); 
    store.dispatch(queryFriendsList(store.state.content['user_id']));
    return GeneralPageView(
        child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: this.buildFriends(context)));
  }

  Widget buildFriends(BuildContext context) {
    return StoreConnector<AppState, Set<KnownPerson>>(
        converter: (store) => store.state.content['friends'],
        builder: (context, friends) {
          return ListView(
            shrinkWrap: false,
            children: this.generateFriendsCards(friends),
          );
        });
  }

  generateFriendsCards(Set<KnownPerson> friends) {
    final List<Widget> friendsCards = List();
    friends.toList().asMap().forEach((index, friend) => friendsCards
        .add(FriendCard(key: Key('friend-card-$index'), friend: friend)));
    return friendsCards;
  }
}
