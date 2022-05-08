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

int getCurrentYear() {
  return DateTime.now().year;
}
