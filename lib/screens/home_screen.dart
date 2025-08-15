import 'package:flutter/material.dart';
import 'package:golf_swing_app/widgets/app_body.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: AppBody(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Upload New Swing',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF2EB814),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickVideo(source: ImageSource.gallery);

                if (pickedFile != null) {
                // 動画ファイル pickedFile.path で取得できます
                // 必要に応じて処理を追加してください
                }
              },
              child: const Text('Upload from Device'),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFE8F2E8),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              onPressed: () async {
                final picker = ImagePicker();
                final pickedFile = await picker.pickVideo(source: ImageSource.camera);

                if (pickedFile != null) {
                // 動画ファイル pickedFile.path で取得できます
                // 必要に応じて処理を追加してください
                }
              },
              child: const Text('Record New Swing'),
              ),
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: const Text(
                'Recent Analysis',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('2days ago'),
                    SizedBox(height: 4),
                    Text('swign Analysis'),
                    SizedBox(height: 4),
                    Text('Improve your swing with personalized feedback.'),
                  ],
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: 
                    Image.asset(
                      'assets/images/pro.jpg',
                    ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
