// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мини-Словарь',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MainScreenWrapper(),
    );
  }
}

// Обёртка для управления состоянием и навигацией
class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({super.key});

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  int _currentIndex = 0; // 0 — Главная, 1 — История

  // Слово, которое передаётся из истории обратно на главный экран
  String? _prefilledWord;

  // Метод для перехода на главный экран с предзаполненным словом
  void goToHomeWithWord(String word) {
    setState(() {
      _prefilledWord = word;
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentScreen;

    if (_currentIndex == 0) {
      currentScreen = HomeScreen(
        prefilledWord: _prefilledWord,
        onSearch: (word) {
          // Пока ничего не сохраняем, просто фиксируем в UI
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Поиск: $word')),
          );
        },
      );
    } else {
      currentScreen = HistoryScreen(
        onWordTap: goToHomeWithWord,
      );
    }

    return Scaffold(
      body: currentScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _prefilledWord = null; // сброс при переключении
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'История',
          ),
        ],
      ),
    );
  }
}