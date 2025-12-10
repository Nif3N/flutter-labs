import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            // Поле ввода с кнопкой поиска
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Введите слово для поиска',
                      border: OutlineInputBorder(),
                      suffixIcon: const Icon(Icons.search),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: null, // Пока без логики
                  child: const Text('Найти'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Область вывода результата
            const Text(
              '{Слово}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              '{Часть речи}',
              style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
            ),
            const SizedBox(height: 8),
            const Text(
              '{Определение}',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // Пример использования (если есть)
            const Text(
              '(Пример: {Пример использования слова})',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),

            const Spacer(), // Отступ до нижней панели

            // Нижняя панель навигации
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black,
                  ),
                  child: const Text('Главная'),
                ),
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