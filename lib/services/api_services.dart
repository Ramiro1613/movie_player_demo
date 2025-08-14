import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;

const tokenAuth =
    'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5Y2JhYjlmNmU5NTUxNzFhZGIzYjBkNmM2Zjc1ZTc1OCIsIm5iZiI6MTc1NTA1ODg3Ny44NTUsInN1YiI6IjY4OWMxMmJkMzhmYjk0NzFkYTVlNDE2MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.aeY8htlxcw9gykyw94XTVSNXvAXxDgSOicd4wl_iqN0';
const accountId = '22223437';
const baseURL = 'https://api.themoviedb.org/3/';

class GeneralApi {
  static Future<Map<String, dynamic>> getAuthToken() async {
    final url = Uri.parse('$baseURL/$tokenAuth');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $tokenAuth'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Error al obtener token: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Excepción al hacer la petición: $e');
    }
  }

  static Future<Map<String, dynamic>> getPopularMovies(
    String category,
    int page,
  ) async {
    final url = Uri.parse('$baseURL/movie/$category?page=$page');
    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $tokenAuth'},
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception(
          'Error: ${response.statusCode} ${response.reasonPhrase}',
        );
      }
    } catch (e) {
      throw Exception('Excepción en petición: $e');
    }
  }

  static Future<Map<String, dynamic>> searchMovies(
    String query,
    int page,
  ) async {
    final url = Uri.parse(
      '${baseURL}search/movie?language=en-US&query=${Uri.encodeComponent(query)}&page=$page&include_adult=false',
    );
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $tokenAuth'},
    );
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data;
    } else {
      print(response);
      throw Exception('Failed to load search results');
    }
  }
}
