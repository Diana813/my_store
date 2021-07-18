class Date{
  static String getDate() {
    var now = DateTime.now();
    return now.year.toString() +
        '-' +
        now.month.toString() +
        '-' +
        now.day.toString();
  }
}