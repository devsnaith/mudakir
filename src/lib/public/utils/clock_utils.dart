class ClockUtils {
  static DateTime durationToDateTime(Duration duration) {
    int milliseconds = duration.inMilliseconds;
    int minutes = ((milliseconds / (1000 * 60)) % 60).toInt();
    int hours = ((milliseconds / (1000 * 60 * 60)) % 24).toInt();                            
    return DateTime(1, 1, 1, hours, minutes, 0, 0, 0);
  }
}