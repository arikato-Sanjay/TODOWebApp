class DateFunction {
  String getDay(int day) {
    switch (day) {
      case 1: return "Monday"; break;
      case 2: return "Tuesday"; break;
      case 3: return "Wednesday"; break;
      case 4: return "Thursday"; break;
      case 5: return "Friday"; break;
      case 6: return "Saturday"; break;
      case 7: return "Sunday"; break;
    }
  }

  String getMonth(int month) {
    switch (month) {
      case 1: return "Jan"; break;
      case 2: return "Feb"; break;
      case 3: return "Mar"; break;
      case 4: return "April"; break;
      case 5: return "May"; break;
      case 6: return "Jun"; break;
      case 7: return "Jul"; break;
      case 8: return "Aug"; break;
      case 9: return "Sep"; break;
      case 10: return "Oct"; break;
      case 11: return "Nov"; break;
      case 12: return "Dec"; break;
    }
  }
}
