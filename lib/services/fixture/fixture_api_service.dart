import 'dart:developer';
import 'package:flexible_cache/constant/cache_policy.dart';
import 'package:flexible_cache/models/meeting.dart';
import 'package:flexible_cache/utilities/http.dart';

class FixtureApiService {
  Http _http = Http(baseUrl: "https://fixture.palmerbet.online");

  Future<MeetingResponse> getRaces(DateTime date) async {
    var response = await _http.get(
        options: RequestOptions(maxAge: CachePolicy.racingMeetingsMaxAge),
        url: "/fixtures/racing/2020-08-06/HorseRacing?channel=website");
    if (response == null) {
      log("no-data");
      return null;
    }
    var meetings = MeetingResponse.fromJson(response);
    return meetings;
  }
}
