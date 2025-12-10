import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Мини-Словарь'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Заголовок
            const Text(
              'История поиска',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Список слов с иконками удаления
            Expanded(
              child: ListView.separated(
                itemCount: 5, // Пример: 5 слов
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final word = 'Слово${index + 1}';
                  return ListTile(
                    title: Text(word),
                    trailing: IconButton(
                      onPressed: null, // Пока без логики
                      icon: const Icon(Icons.delete_outline),
                    ),
                  );
                },
              ),
            ),

            const Spacer(), // Отступ до нижней панели

            // Нижняя панель навигации
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('Главная'),
                ),
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('История'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}