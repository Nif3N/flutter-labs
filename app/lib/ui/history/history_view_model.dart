import 'package:flutter/foundation.dart';
import '../../data/local/history_repository.dart';

class HistoryViewModel with ChangeNotifier {
  final HistoryRepository _historyRepo = HistoryRepository();
  List<String> _history = [];

  List<String> get history => _history;

  Future<void> loadHistory() async {
    _history = await _historyRepo.getHistory();
    notifyListeners();
  }

  Future<void> removeWord(String word) async {
    await _historyRepo.removeFromHistory(word);
    await loadHistory();
  }
}