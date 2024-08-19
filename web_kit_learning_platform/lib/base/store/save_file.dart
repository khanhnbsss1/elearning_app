import 'package:http/http.dart';
import 'package:universal_html/html.dart' as html;

class FileStoreManager {
  FileStoreManager._();

  static final FileStoreManager _singletonFileManager = FileStoreManager._internal();

  static FileStoreManager get getInstance => _singletonFileManager;

  factory FileStoreManager() {
    return _singletonFileManager;
  }

  FileStoreManager._internal();

  Future<void> downloadFileFromStream({required String url, required String fileName}) async {
    Response res = await get(Uri.parse(url),);
    if (res.statusCode == 200) {
      final blob = html.Blob([res.bodyBytes]);
      final url = html.Url.createObjectUrlFromBlob(blob);
      final anchor = html.document.createElement('a') as html.AnchorElement
        ..href = url
        ..style.display = 'none'
        ..download = fileName;
      html.document.body?.children.add(anchor);

      anchor.click();

      html.document.body?.children.remove(anchor);
      html.Url.revokeObjectUrl(url);
    }
  }
}