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

String convertSecondsToYYYYMMDD(String timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);

  return dateTime.year.toString() + "-" + addISO6801PaddingInt(dateTime.month) +
      "-" + addISO6801PaddingInt(dateTime.day);
}

String convertSecondsToHHmm(String timestamp) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp) * 1000);

  return addISO6801PaddingInt(dateTime.hour) + ":" + addISO6801PaddingInt(dateTime.minute) +
      " " + dateTime.timeZoneName;
}

String addISO6801PaddingInt(int num) {
  return num < 10 ? "0" + num.toString() : num.toString();
}

String addISO6801PaddingString(String num) {
  return int.parse(num) < 10 ? "0" + num : num;
}
