import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String? prefilledWord;
  final void Function(String) onSearch;

  const HomeScreen({
    super.key,
    this.prefilledWord,
    required this.onSearch,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.prefilledWord ?? '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSearch(text);
    }
  }

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
            const SizedBox(height: 24),

            // Поле ввода с кнопкой
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Введите слово для поиска',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: _handleSearch,
                      ),
                    ),
                    onSubmitted: (_) => _handleSearch(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _handleSearch,
                  child: const Text('Найти'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Результат поиска (заглушка)
            if (_controller.text.isNotEmpty) ...[
              Text(
                _controller.text,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'noun',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'A basic unit of language that carries meaning.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                '(Пример: This word appears in the dictionary.)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ] else
              const Text(
                'Введите слово и нажмите «Найти»',
                style: TextStyle(color: Colors.grey),
              ),

            const Spacer(),
          ],
        ),
      ),
    );
  }
}