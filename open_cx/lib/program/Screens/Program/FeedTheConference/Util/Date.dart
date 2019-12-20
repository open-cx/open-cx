String dateToString(DateTime d){

  int year = d.year;
  int month = d.month;
  int day = d.day;

  return '$year-$month-$day';

}

String dateToInvertedString(DateTime d){

  int year = d.year;
  int month = d.month;
  int day = d.day;

  if(day < 10 && month < 10)
    return '0$day-0$month-$year';
  else if(day < 10)
    return '0$day-$month-$year';
  else if(month < 10)
    return '$day-0$month-$year';
  else
    return '$day-$month-$year';

}

String timeToString(DateTime d){

  int hour = d.hour;
  int minutes = d.minute;
  if(hour < 10 && minutes < 10){
    return '0$hour:0$minutes';
  }
  else if(hour < 10){
    return '0$hour:$minutes';
  }
  else if(minutes < 10){
    return '$hour:0$minutes';
  }
  else
    return '$hour:$minutes';

}

String dateAndTimeToString(DateTime d){

  int year = d.year;
  int month = d.month;
  int day = d.day;
  int hour = d.hour;
  int minutes = d.minute;

  return '$day-$month-$year $hour:$minutes';
}

String monthOfTheYear(DateTime d){

  String month;
  switch(d.month){

    case 1:
      month = "Jan";
      break;

    case 2:
      month = "Feb";
      break;

    case 3:
      month = "Mar";
      break;

    case 4:
      month = "Apr";
      break;

    case 5:
      month = "May";
      break;

    case 6:
      month = "Jun";
      break;

    case 7:
      month = "Jul";
      break;

    case 8:
      month = "Aug";
      break;

    case 9:
      month = "Sep";
      break;

    case 10:
      month = "Oct";
      break;

    case 11:
      month = "Nov";
      break;

    case 12:
      month = "Dec";
      break;

    default:
      month = null;
      break;
  }

  return month;
}