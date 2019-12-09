import 'package:open_cx/communio/model/app_state.dart';
import 'package:open_cx/communio/model/person_found.dart';
import 'package:open_cx/communio/redux/action_creators.dart';
import 'package:open_cx/communio/view/Pages/general_page_view.dart';
import 'package:open_cx/communio/view/Widgets/filters.dart';
import 'package:open_cx/communio/view/Widgets/friend_information.dart';
import 'package:open_cx/communio/view/Widgets/photo_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:open_cx/communio/view/theme.dart' show navyBlueColor;

class PeopleSearchingPage extends StatelessWidget {
  final horizontalPadding = 22.0;
  final verticalPadding = 3.0;

  @override
  Widget build(BuildContext context) {
    StoreProvider.of<AppState>(context).dispatch(scanForDevices());
    return GeneralPageView(
        child: Container(
      child: this.buildDevices(context),
    ));
  }

  Widget buildDevices(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      converter: (store) => getFilteredDevices(store.state),
      builder: (context, devices) {
        return ListView(
          key: new Key('people-searching-page'),
          shrinkWrap: false,
          children: this.generateDevicesCards(context, devices),
        );
      },
    );
  }

  getFilteredDevices(AppState state) {
    final storeContent = state.content;
    final Set<String> filters = storeContent['current_filters'];
    final devices =
        storeContent['bluetooth_devices'];
    final filteredDevices = Map.from(devices)
      ..removeWhere((key, value) => !value.interests.any((value) =>
          filters.toList().indexWhere(
                  (filter) => filter.toLowerCase() == value.toLowerCase()) !=
              -1 ||
          filters.length == 0));
    return filteredDevices;
  }

  generatePersonCard(BuildContext context, PersonFound person) {
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
              photo: person.photo,
            ),
            FriendInformation(
              name: person.name,
              location: person.location,
            ),
            this.generateConnectionButton(context, person)
          ],
        ));
  }

  generateDevicesCards(
      BuildContext context, devices) {
    final List<Widget> devicesCards = List();
    devicesCards.add(new Filters());
    devices.forEach((device, person) {
      devicesCards.add(this.generatePersonCard(context, person));
    });
    return devicesCards;
  }

  generateConnectionButton(BuildContext context, person) {
    return IconButton(
      icon: Icon(
        Icons.person_add,
        size: 30.0,
        color: navyBlueColor,
      ),
      onPressed: () {
        StoreProvider.of<AppState>(context).dispatch(connectToPerson(person));
      },
    );
  }
}
