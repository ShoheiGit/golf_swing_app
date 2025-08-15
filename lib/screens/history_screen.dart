import 'package:flutter/material.dart';
import 'package:golf_swing_app/screens/home_screen.dart';
import 'package:golf_swing_app/screens/practice_screen.dart';
import 'package:golf_swing_app/screens/upload_screen.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mockHistory = [
      {'date': '2025/06/10', 'result': 'スイング軌道：良好'},
      {'date': '2025/06/08', 'result': '体重移動：やや不足'},
      {'date': '2025/06/05', 'result': 'ヘッドスピード：平均'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('履歴')),
      body: ListView.builder(
        itemCount: mockHistory.length,
        itemBuilder: (context, index) {
          final item = mockHistory[index];
          return ListTile(
            leading: const Icon(Icons.video_library),
            title: Text(item['date']!),
            subtitle: Text(item['result']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AnalysisScreen(
                    date: item['date'],
                    result: item['result'],
                    detail: 'この履歴の詳細な分析内容をここに表示できます。',
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}

class AnalysisScreen extends StatelessWidget {
  final String? date;
  final String? result;
  final String? detail;

  const AnalysisScreen({super.key, this.date, this.result, this.detail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('分析結果')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('日付: $date', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8.0),
            Text(
              '結果: $result',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16.0),
            Text(detail ?? '', style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == currentIndex) return;
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const UploadScreen()),
          );
        } else if (index == 2) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HistoryScreen()),
          );
        } else if (index == 3) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PracticeScreen()),
          );
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'ホーム'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: '履歴'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
      ],
    );
  }
}
