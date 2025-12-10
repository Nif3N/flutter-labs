import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ui/home/home_view_model.dart';
import 'ui/history/history_view_model.dart';
import 'ui/home/home_screen.dart';
import 'ui/history/history_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => HistoryViewModel()..loadHistory()),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Мини-Словарь',
      theme: ThemeData(useMaterial3: true, primarySwatch: Colors.blue),
      home: const MainScreenWrapper(),
    );
  }
}

class MainScreenWrapper extends StatefulWidget {
  const MainScreenWrapper({super.key});

  @override
  State<MainScreenWrapper> createState() => _MainScreenWrapperState();
}

class _MainScreenWrapperState extends State<MainScreenWrapper> {
  int _currentIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      context.read<HistoryViewModel>().loadHistory();
    }
    setState(() => _currentIndex = index);
  }

  void _onWordFromHistory(String word) {
    final homeVm = context.read<HomeViewModel>();
    final historyVm = context.read<HistoryViewModel>();
    homeVm.searchWord(word);
    historyVm.loadHistory();
    setState(() => _currentIndex = 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(onSearchComplete: () {}),
          HistoryScreen(
          onWordTap: (word) {
            context.read<HomeViewModel>().searchWord(word);
            context.read<HistoryViewModel>().loadHistory();
            setState(() => _currentIndex = 0);
          },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'История'),
        ],
      ),
    );
  }
}