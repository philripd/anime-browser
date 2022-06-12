String getCurrentSeason() {
  int currentMonth = DateTime.now().month;

  // January, February, March
  if (currentMonth < 4) {
    return "WINTER";
  // April, May, June
  } else if (currentMonth < 7) {
    return "SPRING";
  // July, August, September
  } else if (currentMonth < 10) {
    return "SUMMER";
  // October, November, December
  } else {
    return "FALL";
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
