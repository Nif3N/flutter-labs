import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/dictionary_entry.dart';
import '../../core/constants.dart';

class DictionaryService {
  Future<DictionaryEntry> fetchWord(String word) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/$word'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      if (jsonList.isEmpty) {
        throw Exception('Empty response');
      }
      return DictionaryEntry.fromJson(jsonList[0] as Map<String, dynamic>);
    } else {
      throw Exception('Word not found');
    }
  }
}