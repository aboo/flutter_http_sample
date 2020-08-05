abstract class CachePolicy {
  static Duration racingMeetingsMaxAge = Duration(seconds: 10);
  static Duration racingMeetingsMaxStale = Duration(minutes: 1);
}
