import '../../ui/history/history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/models/dictionary_entry.dart';
import 'home_view_model.dart';

class HomeScreen extends StatelessWidget {
  final void Function() onSearchComplete;

  const HomeScreen({super.key, required this.onSearchComplete});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<HomeViewModel>(context);
    final controller = TextEditingController();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Заголовок
            const Text(
              'Мини-Словарь',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // Поле ввода и кнопка
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: 'Введите слово для поиска',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (controller.text.trim().isNotEmpty) {
                            context.read<HomeViewModel>().searchWord(controller.text);
                            context.read<HistoryViewModel>().loadHistory();
                            onSearchComplete();
                          }
                        },
                      ),
                    ),
                    onSubmitted: (text) {
                      if (text.trim().isNotEmpty) {
                        context.read<HomeViewModel>().searchWord(text);
                        context.read<HistoryViewModel>().loadHistory();
                        onSearchComplete();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    if (controller.text.trim().isNotEmpty) {
                      context.read<HomeViewModel>().searchWord(controller.text);
                      context.read<HistoryViewModel>().loadHistory();
                      onSearchComplete();
                    }
                  },
                  child: const Text('Найти'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Прокручиваемая область с результатами
            Expanded(
              child: vm.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : vm.currentEntry != null
                  ? _buildResult(vm.currentEntry!)
                  : const Center(
                child: Text(
                  'Введите слово и нажмите «Найти»',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResult(DictionaryEntry entry) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(entry.word, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),

          ...entry.meanings.map((meaning) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meaning.partOfSpeech,
                  style: const TextStyle(
                    fontSize: 18,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ...meaning.definitions.map((def) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 8.0, bottom: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(def.definition, style: const TextStyle(fontSize: 16)),
                        if (def.example != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            '(Пример: ${def.example})',
                            style: const TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                        const Divider(height: 16, thickness: 1),
                      ],
                    ),
                  );
                }).toList(),
                const SizedBox(height: 16),
              ],
            );
          }).toList(),
        ],
      ),
    );
  }
}