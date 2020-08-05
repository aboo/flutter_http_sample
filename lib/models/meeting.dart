class MeetingResponse {
  List<Meeting> meetings;

  MeetingResponse({this.meetings});

  factory MeetingResponse.fromJson(Map<String, dynamic> json) {
    return MeetingResponse(
        meetings: (json['meetings'] as List)
            .map((x) => Meeting.fromJson(x as Map<String, dynamic>))
            .toList());
  }
}

class Meeting {
  Venue venue;
  List<Race> races;

  Meeting({this.venue, this.races});

  factory Meeting.fromJson(Map<String, dynamic> json) {
    var races = (json["races"] as List)
        .map((x) => Race.fromJson(x as Map<String, dynamic>))
        .toList();
    var venue = Venue.fromJson(json["venue"]);
    return Meeting(venue: venue, races: races);
  }
}

class Venue {
  String title;

  Venue({this.title});

  factory Venue.fromJson(Map<String, dynamic> json) {
    return Venue(title: json["title"]);
  }
}

class Race {
  String title;
  int number;

  Race({this.title, this.number});

  factory Race.fromJson(Map<String, dynamic> json) {
    return Race(title: json["title"], number: json["number"]);
  }
}
