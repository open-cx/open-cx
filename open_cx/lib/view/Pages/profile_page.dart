import 'dart:convert';
import 'dart:io';

import 'package:communio/model/app_state.dart';
import 'package:communio/model/known_person.dart';
import 'package:communio/view/Pages/general_page_view.dart';
import 'package:communio/view/Pages/secondary_page_view.dart';
import 'package:communio/view/Widgets/editable_description.dart';
import 'package:communio/view/Widgets/future_page_builder.dart';
import 'package:communio/view/Widgets/profile_interests.dart';
import 'package:communio/view/Widgets/social_media_column.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:communio/view/theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String profileId;
  final KnownPerson knownPerson;
  final bool edit;
  static Future<KnownPerson> person;

  ProfilePage({this.profileId, this.knownPerson, @required this.edit});

  @override
  Widget build(BuildContext context) {
    if (person == null) person = getPerson(context, profileId);

    if (knownPerson != null) {
      return SecondaryPageView(
        child: buildPerson(context, knownPerson),
      );
    }
    return new FuturePageBuilder<KnownPerson>(
      data: person,
      func: this.buildProfilePage,);
  }

  buildProfilePage(BuildContext context, KnownPerson person){
    if(edit){
      return GeneralPageView(child: this.buildPerson(context, person),);
    }
    return SecondaryPageView(child: this.buildPerson(context, person),);
  }

  buildPerson(BuildContext context, KnownPerson person) {
    final query = MediaQuery.of(context).size;
    final Function(String, String) addingFunc = (interest, type) async {
      final String profile =
          StoreProvider.of<AppState>(context).state.content['user_id'];
      final Map<String, String> body = {'$type': interest};
      await http.put('${DotEnv().env['API_URL']}users/tags/$profile',
          body: json.encode(body),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    };
    final Function(String, String) removeFunc = (interest, type) async {
      final String profile =
          StoreProvider.of<AppState>(context).state.content['user_id'];
      final Map<String, String> body = {'$type': interest};
      await http.post('${DotEnv().env['API_URL']}users/tags/$profile',
          body: json.encode(body),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    };

    return ListView(
      key: Key('profile-page'),
      children: <Widget>[
        buildImage(person, context, query),
        buildName(person, context, query),
        buildLocation(person, context, query),
        buildDescription(person, context, query),
        buildSocialMedia(person, context, query),
        ProfileInterests(
          interests: person.interests,
          name: 'Interests',
          type: 'tags',
          edit: edit,
          adding: addingFunc,
          removing: removeFunc,
        ),
        ProfileInterests(
          interests: person.programmingLanguages,
          name: 'Programming Languages',
          type: 'programming_languages',
          edit: edit,
          adding: addingFunc,
          removing: removeFunc,
        ),
        ProfileInterests(
          interests: person.skills,
          name: 'Skills',
          type: 'skills',
          edit: edit,
          adding: addingFunc,
          removing: removeFunc,
        )
      ],
    );
  }

  Widget padWidget({Widget child, Size query}) {
    return Padding(
        padding: EdgeInsets.only(
            top: query.height * 0.005,
            bottom: query.height * 0.005,
            left: query.height * 0.05,
            right: query.height * 0.05),
        child: child);
  }

  Widget buildName(KnownPerson person, BuildContext context, Size query) {
    return padWidget(
        child: Center(
          child: Text(
            person.name,
            style: Theme.of(context).textTheme.body2.apply(fontSizeDelta: 10),
          ),
        ),
        query: query);
  }

  buildImage(KnownPerson person, BuildContext context, Size query) {
    final double _picRatio = (4.0 / 5.0) * (query.width / query.height);
    return padWidget(
        child: Align(
            alignment: Alignment.center,
            child: Container(
              margin: EdgeInsets.only(top: query.height * 0.01),
              padding: EdgeInsets.only(
                  left: query.height * 0.1, right: query.height * 0.1),
              height: query.width * _picRatio,
              width: query.width * _picRatio,
              decoration: ShapeDecoration(
                  shape: CircleBorder(
                    side: BorderSide.none,
                  ),
                  image: new DecorationImage(
                      fit: BoxFit.fitWidth, image: NetworkImage(person.photo))),
            )),
        query: query);
  }

  buildLocation(KnownPerson person, BuildContext context, Size query) {
    return padWidget(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.location_on,
                color: cyanColor,
              ),
              Text(
                person.location,
                style: Theme.of(context).textTheme.body2,
              )
            ],
          ),
        ),
        query: query);
  }

  buildDescription(KnownPerson person, BuildContext context, Size query) {
    final Function(String) updateFunc = (description) async {
      final String profile =
          StoreProvider.of<AppState>(context).state.content['user_id'];

      final Map<String, String> body = {'description': description};
      await http.post('${DotEnv().env['API_URL']}users/description/$profile',
          body: json.encode(body),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    };

    return buildRowWithItem(
      context,
      Icons.info,
      EditableDescription(person: person, edit: edit, update: updateFunc),
      query,
    );
  }

  buildSocialMedia(KnownPerson person, BuildContext context, Size query) {
    final Function(String, String) addSocialFunc = (socialID, newSocial) async {
      final String profile =
          StoreProvider.of<AppState>(context).state.content['user_id'];

      final Map<String, String> body = {socialID: newSocial};
      await http.put('${DotEnv().env['API_URL']}users/socials/$profile',
          body: json.encode(body),
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    };

    final Function(String) delSocialFunc = (social) async {
      final String profile =
          StoreProvider.of<AppState>(context).state.content['user_id'];

      await http.delete(
          '${DotEnv().env['API_URL']}users/socials/$profile/$social',
          headers: {
            HttpHeaders.contentTypeHeader: 'application/json',
          });
    };

    return buildRowWithItem(
        context,
        Icons.person,
        SocialMediaColumn(
          person: person,
          edit: edit,
          adding: addSocialFunc,
          removing: delSocialFunc,
        ),
        query);
  }

  buildRowWithItem(
      BuildContext context, IconData iconData, Widget widget, Size query) {
    return Padding(
      padding: EdgeInsets.only(
        top: query.height * 0.03,
        bottom: query.height * 0.03,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: query.width * 0.15,
            child: Center(
              child: Icon(
                iconData,
                color: cyanColor,
              ),
            ),
          ),
          Container(
            child: widget,
          )
        ],
      ),
    );
  }

  Future<KnownPerson> getPerson(BuildContext context,String profileId) async {
    final profileUrl = StoreProvider.of<AppState>(context)
          .state.content['profile'];
    final response =
        await http.get('$profileUrl/$profileId');
    final map = json.decode(utf8.decode(response.bodyBytes));
    return KnownPerson.fromJson(map);
  }
}

