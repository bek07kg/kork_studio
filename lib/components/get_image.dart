import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> getImageUrls(String folderPath) async {
  final List<String> urls = [];
  final ListResult result =
      await FirebaseStorage.instance.ref(folderPath).listAll();

  for (var ref in result.items) {
    final String url = await ref.getDownloadURL();
    urls.add(url);
  }

  return urls;
}
