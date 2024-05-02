import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:via/models/wiki_page.dart';

class WikiRepository {
  final http.Client httpClient;

  WikiRepository({http.Client? httpClient})
      : this.httpClient = httpClient ?? http.Client();

  Future<List<WikiPage>> fetchNearbyPlaces(double lat, double lon) async {
    var url = Uri.https('en.wikipedia.org', '/w/api.php', {
      'action': 'query',
      'list': 'geosearch',
      'gscoord': '$lat|$lon',
      'gsradius': '10000',
      'gslimit': '10',
      'format': 'json'
    });

    final response = await httpClient.get(url);
    print("response");
    print(response);
    if (response.statusCode == 200) {
      final list =
          json.decode(response.body)['query']['geosearch'] as List<dynamic>;
      return list.map((e) {
        return WikiPage.fromJson(e as Map<String, dynamic>);
      }).toList(); // Returning JSON string
    } else {
      throw Exception('Failed to load nearby places');
    }
  }
}
