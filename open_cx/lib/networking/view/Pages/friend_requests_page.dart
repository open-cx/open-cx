import 'dart:convert';

import 'package:open_cx/networking/model/app_state.dart';
import 'package:open_cx/networking/model/friend_request.dart';
import 'package:open_cx/networking/view/Pages/general_page_view.dart';
import 'package:open_cx/networking/view/Widgets/friend_information.dart';
import 'package:open_cx/networking/view/Widgets/friend_request_button.dart';
import 'package:open_cx/networking/view/Widgets/future_page_builder.dart';
import 'package:open_cx/networking/view/Widgets/photo_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:http/http.dart' as http;

class FriendRequestsPage extends StatelessWidget {
  final horizontalPadding = 15.0;
  final verticalPadding = 3.0;

  @override
  Widget build(BuildContext context) {
    return GeneralPageView(
      child: FuturePageBuilder<Iterable<FriendRequest>>(
        data: getPerson(context),
        func: this.buildFriendRequests,
      ),
    );
  }

  Future<Iterable<FriendRequest>> getPerson(BuildContext context) async {
    final String profile =
        StoreProvider.of<AppState>(context).state.content['user_id'];
    final response = await http
        .get('${DotEnv().env['API_URL']}users/matches/requests/$profile');
    final Iterable friendRequests =
        json.decode(utf8.decode(response.bodyBytes));
    final friends = friendRequests
        .map((friendRequest) => FriendRequest.fromJson(friendRequest));
    return friends;
  }

  buildFriendRequests(
      BuildContext context, Iterable<FriendRequest> friendRequests) {
    return ListView(
      children: this.requestsLists(context, friendRequests),
    );
  }

  buildRequestRow(BuildContext context, FriendRequest friendRequest) {
    final user = friendRequest.user;
    return new Container(
        padding: EdgeInsets.only(
            right: horizontalPadding,
            left: horizontalPadding,
            top: verticalPadding,
            bottom: verticalPadding),
        margin: EdgeInsets.only(bottom: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            PhotoAvatar(
              photo: user.photo,
            ),
            FriendInformation(
              name: user.name,
              location: user.location,
            ),
            FriendRequestButton(
              friendRequest: friendRequest,
            )
          ],
        ));
  }

  List<Widget> requestsLists(
      BuildContext context, Iterable<FriendRequest> friendRequests) {
    final List<Widget> children = List();
    children.add(Container(
      padding: EdgeInsets.all(15.0),
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 2.0, color: Theme.of(context).colorScheme.primary))),
      child: Text(
        'Friend Requests',
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .title
            .apply(fontSizeDelta: -6, fontWeightDelta: 1),
      ),
    ));

    children.addAll(friendRequests
        .map((friendRequest) => this.buildRequestRow(context, friendRequest)));
    return children;
  }
}
