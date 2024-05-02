class WikiPage {
  final int pageid;
  final int ns;
  final String title;
  final double lat;
  final double lon;
  final double dist;

  WikiPage({
    required this.pageid,
    required this.ns,
    required this.title,
    required this.lat,
    required this.lon,
    required this.dist,
  });

  factory WikiPage.fromJson(Map<String, dynamic> json) {
    return WikiPage(
      pageid: json['pageid'],
      ns: json['ns'],
      title: json['title'].replaceAll("\n", " "),
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      dist: json['dist'].toDouble(),
    );
  }
}
