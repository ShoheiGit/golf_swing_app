import 'package:flutter/material.dart';
import 'package:golf_swing_app/screens/history_screen.dart';
import 'practice_screen.dart';

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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (date != null || result != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (date != null)
                    Text(
                      '日付: $date',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  if (result != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '結果: $result',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  const SizedBox(height: 16),
                ],
              ),
            const Text('AIフィードバック', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text(
              detail ??
                  'Your swing shows a slight overswing at the top, leading to a less consistent downswing plane. Focus on shortening your backswing and maintaining a more compact motion.',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            const Text(
              'Comparison with Pro Player',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/pro.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'プロ選手のスイングはトップでコンパクトに収まり、ダウンスイングで一貫したプレーンを維持しています。',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/images/pro.jpg',
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Text(
                    'プロ選手のスイングはトップでコンパクトに収まり、ダウンスイングで一貫したプレーンを維持しています。',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            // 練習紹介ページへの遷移ボタン
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PracticeScreen(),
                    ),
                  );
                },
                child: const Text('練習を見る'),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
