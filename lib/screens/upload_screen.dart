import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:golf_swing_app/widgets/app_bottom_nav.dart';
import 'analysis_screen.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:image_picker/image_picker.dart';

class UploadScreen extends StatefulWidget {
  const UploadScreen({super.key});

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  List<AssetEntity> _mediaList = [];
  bool _isLoading = true;
  bool _hasPermission = true;
  String? _permissionMessage;

  @override
  void initState() {
    super.initState();
    _fetchMedia();
  }

  Future<void> _fetchMedia() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    if (ps.hasAccess) {
      final List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.video,
      );
      final List<AssetEntity> media = albums.isNotEmpty
          ? List<AssetEntity>.from(
              await albums[0].getAssetListPaged(page: 0, size: 60),
            )
          : [];
      setState(() {
        _mediaList = media;
        _isLoading = false;
        _hasPermission = true;
        _permissionMessage = null;
      });
    } else {
      setState(() {
        _isLoading = false;
        _hasPermission = false;
        _permissionMessage = ps.isAuth == false
            ? '写真・動画へのアクセスが許可されていません。設定から許可してください。'
            : '写真・動画へのアクセス権限が必要です。';
      });
    }
  }

  Future<void> _openCamera() async {
    final picker = ImagePicker();
    final XFile? video = await picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      // カメラで撮影した動画をAnalysisScreenへ渡す処理（仮）
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AnalysisScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('リールをアップロード')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : !_hasPermission
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.lock, size: 48, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text(_permissionMessage ?? '', textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      PhotoManager.openSetting();
                    },
                    child: const Text('設定を開く'),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                      });
                      _fetchMedia();
                    },
                    child: const Text('再試行'),
                  ),
                ],
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
              ),
              itemCount: _mediaList.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  // カメラ起動ボタン
                  return GestureDetector(
                    onTap: _openCamera,
                    child: Container(
                      color: Colors.purpleAccent.withOpacity(0.8),
                      child: const Center(
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ),
                  );
                }
                final asset = _mediaList[index - 1];
                return FutureBuilder<Uint8List?>(
                  future: asset.thumbnailDataWithSize(
                    const ThumbnailSize(200, 200),
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      return GestureDetector(
                        onTap: () {
                          // ギャラリーから選択した動画をAnalysisScreenへ渡す処理（仮）
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnalysisScreen(),
                            ),
                          );
                        },
                        child: Image.memory(snapshot.data!, fit: BoxFit.cover),
                      );
                    }
                    return Container(color: Colors.grey[200]);
                  },
                );
              },
            ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
