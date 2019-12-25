

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_cx/navigation/view/icons/guideasy_icons_icons.dart';

// TODO decide on better POIs
enum POIType {
  STAIRS,
  ELEVATOR,
  MALE_WC,
  FEMALE_WC,
  ACCESS_WC,
  RECEPTION,
  LOST_AND_FOUND,
  SNACK_BAR,
  COFFEE_BREAK,
  VENDING_MACHINE,
  ROOM,
  PARKING,
  UNDEFINED
}

POIType stringToPOIType(String type) {
  switch(type) {
    case 'room':
      return POIType.ROOM;
    case 'stairs':
      return POIType.STAIRS;
    case 'elevator':
      return POIType.ELEVATOR;
    case 'male wc':
      return POIType.MALE_WC;
    case 'female wc':
      return POIType.FEMALE_WC;
    case 'accessible wc':
      return POIType.ACCESS_WC;
    case 'reception':
      return POIType.RECEPTION;
    case 'lost and found':
      return POIType.LOST_AND_FOUND;
    case 'snack bar':
      return POIType.SNACK_BAR;
    case 'coffee break':
      return POIType.COFFEE_BREAK;
    case 'vending machine':
      return POIType.VENDING_MACHINE;
    case 'parking':
      return POIType.PARKING;
    default:
      return POIType.UNDEFINED;
  }
}

IconData poiTypeIcon(POIType type) {
  switch(type) {
    case POIType.ROOM:
      return GuideasyIcons.room;
    case POIType.STAIRS:
      return GuideasyIcons.stairs;
    case POIType.ELEVATOR:
      return GuideasyIcons.elevator;
    case POIType.MALE_WC:
      return GuideasyIcons.male;
    case POIType.FEMALE_WC:
      return GuideasyIcons.female;
    case POIType.ACCESS_WC:
      return GuideasyIcons.wheelchair;
    case POIType.RECEPTION:
      return GuideasyIcons.concierge_bell_solid;
    case POIType.LOST_AND_FOUND:
      return GuideasyIcons.lostandfound;
    case POIType.COFFEE_BREAK:
      return GuideasyIcons.coffee;
    case POIType.VENDING_MACHINE:
      return GuideasyIcons.vending_machine;
    case POIType.SNACK_BAR:
      return Icons.local_dining;
    case POIType.PARKING:
      return Icons.local_parking;
    case POIType.UNDEFINED:
      return Icons.help;
    default:
      return Icons.help;
  }
}