import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final void Function(String word) onWordTap;

  const HistoryScreen({super.key, required this.onWordTap});

  static const _mockHistory = ['apple', 'book', 'computer', 'dictionary', 'flutter'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок "Мини-Словарь"
            const Text(
              'Мини-Словарь',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // Подзаголовок "История поиска"
            const Text(
              'История поиска',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: ListView.builder(
                itemCount: _mockHistory.length,
                itemBuilder: (context, index) {
                  final word = _mockHistory[index];
                  return ListTile(
                    title: Text(word),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Удалено: $word')),
                        );
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