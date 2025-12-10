import '../services/dictionary_service.dart';
import '../models/dictionary_entry.dart';

class DictionaryRepository {
  final DictionaryService _service = DictionaryService();

  Future<DictionaryEntry> getWord(String word) async {
    return _service.fetchWord(word);
  }
}