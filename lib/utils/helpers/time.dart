String getCurrentSeason() {
  int currentMonth = DateTime.now().month;

  // January, February
  if (currentMonth < 3) {
    return "WINTER";
  // March, April, May
  } else if (currentMonth < 6) {
    return "SPRING";
  // June, July, August
  } else if (currentMonth < 9) {
    return "SUMMER";
  // September, October, November
  } else if (currentMonth < 12) {
    return "FALL";
  // December
  } else {
    return "WINTER";
  }
}

int getCurrentSeasonYear() {
  int currentYear = DateTime.now().year;

  // Increment year if the current month is December
  return DateTime.now().month == 12 ? currentYear + 1 : currentYear;
}

String convertSecondsToDate(String timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);

  return dateTime.year.toString() + "-" + addISO6801Padding(dateTime.month) + "-" +
      addISO6801Padding(dateTime.day) + " "  + addISO6801Padding(dateTime.hour) + ":" +
      addISO6801Padding(dateTime.minute) + " " + dateTime.timeZoneName;
}

String addISO6801Padding(int num) {
  return num < 10 ? "0" + num.toString() : num.toString();
}
