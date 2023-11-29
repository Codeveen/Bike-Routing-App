String getDropOffTime(num duration) {
  int minutes = (duration / 60).round();
  return minutes.toString();
}
