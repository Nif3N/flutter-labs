import 'package:flutter/foundation.dart';
import '../../data/repositories/dictionary_repository.dart';
import '../../data/models/dictionary_entry.dart';
import '../../data/local/history_repository.dart';

class HomeViewModel with ChangeNotifier {
  final DictionaryRepository _dictRepo = DictionaryRepository();
  final HistoryRepository _historyRepo = HistoryRepository();

  DictionaryEntry? _currentEntry;
  bool _isLoading = false;

  DictionaryEntry? get currentEntry => _currentEntry;
  bool get isLoading => _isLoading;

  Future<void> searchWord(String word) async {
    word = word.trim();
    if (word.isEmpty) return;

    _isLoading = true;
    notifyListeners();

    try {
      _currentEntry = await _dictRepo.getWord(word.toLowerCase());
      await _historyRepo.addToHistory(_currentEntry!.word);
    } catch (e) {
      print('ОШИБКА: $e');
      _currentEntry = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}