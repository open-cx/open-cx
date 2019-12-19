library Dates;

// const String date1 = 'Mon, 23/03/2020';
// const String date2 = 'Tue, 24/03/2020';
// const String date3 = 'Wed, 25/03/2020';
// const String date4 = 'Thu, 26/03/2020';

 Date date1 = new Date('Mon','01','04','2019');
 Date date2 = new Date('Tue','02','04','2019');
 Date date3 = new Date('Wed','03','04','2019');
 Date date4 = new Date('Thu','04','04','2019');

class Date{
  String _weekDay;
  String _day;
  String _month;
  String _year;
  final List<String> _monthsStr= ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"];

  Date(this._weekDay, this._day, this._month,this._year);

  Date.fromDate(String weekday, String date) {
    this._weekDay = weekday;
    List<String> values = date.split("-");
    this._year = values[0];
    this._month = values[1];
    this._day = values[2];
  }

  String getWeekDay(){
    return _weekDay;
  }

  String getDay(){
    return _day;
  }

  String getMonth(){
    return _month;
  }

  String getMonthStr(){
    int month = int.parse(_month);
    return _monthsStr[month-1];
  }

  String getYear(){
    return _year;
  }

  @override
  String toString() {
    return this._weekDay + ", " + this._day + "/" + this._month + "/" + this._year;
  }

  String toDateString() {
    return this._year + "-" + this._month + "-" + this._day;
  }

  bool dateEqualTo(DateTime date){


    return int.parse(this._year) == date.year && int.parse(this._month) == date.month && int.parse(this._day) == date.day;
  }

}