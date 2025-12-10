import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ui/history/history_view_model.dart';

class HistoryScreen extends StatelessWidget {
  final void Function(String word) onWordTap;
  const HistoryScreen({super.key, required this.onWordTap});

  @override
  Widget build(BuildContext context) {
    final history = context.watch<HistoryViewModel>().history;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Мини-Словарь', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text('История поиска', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: history.isEmpty
                  ? const Center(child: Text('История пуста'))
                  : ListView.builder(
                itemCount: history.length,
                itemBuilder: (context, index) {
                  final word = history[index];
                  return ListTile(
                    title: Text(word),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        context.read<HistoryViewModel>().removeWord(word);
                      },
                    ),
                      onTap: () => onWordTap(word),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}