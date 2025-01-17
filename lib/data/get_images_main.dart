import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> getImagesFromMain() async {
  final storageRef = FirebaseStorage.instance.ref().child('main');
  final ListResult result = await storageRef.listAll();

  // Получаем URL для каждого файла
  List<String> imageUrls = [];
  for (var ref in result.items) {
    String url = await ref.getDownloadURL();
    imageUrls.add(url);
  }

  return imageUrls;
}
