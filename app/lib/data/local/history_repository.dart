import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepository {
  static const String _historyKey = 'search_history';

  Future<List<String>> getHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_historyKey);
    return history ?? [];
  }

  Future<void> addToHistory(String word) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    if (!history.contains(word)) {
      history.insert(0, word);
      await prefs.setStringList(_historyKey, history);
    }
  }

  Future<void> removeFromHistory(String word) async {
    final prefs = await SharedPreferences.getInstance();
    final history = await getHistory();
    history.remove(word);
    await prefs.setStringList(_historyKey, history);
  }
}