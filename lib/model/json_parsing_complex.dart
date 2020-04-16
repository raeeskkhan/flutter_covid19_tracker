class MapListOfStats {
  List<Stats> country;

  MapListOfStats({this.country});

  factory MapListOfStats.fromJson(Map<String, dynamic> json) {
    //Enter your country here as it is in the URL
    var list = json["South Africa"] as List;
    List<Stats> dataList = list.map((i) => Stats.fromJson(i)).toList();

    return MapListOfStats(
      country: dataList,
    );
  }
}

//class ListOfStats {
//  final List<Stats> statistics;
//
//  ListOfStats({this.statistics});
//
//  factory ListOfStats.fromJson(List<dynamic> parsedJson) {
//    List<Stats> statistics = new List<Stats>();
//    statistics = parsedJson.map((i) => Stats.fromJson((i))).toList();
//
//    return ListOfStats(statistics: statistics);
//  }
//}

class Stats {
  String date;
  int confirmed;
  int deaths;
  int recovered;

  Stats({this.date, this.confirmed, this.deaths, this.recovered});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      date: json["date"],
      confirmed: json["confirmed"],
      deaths: json["deaths"],
      recovered: json["recovered"],
    );
  }
}
