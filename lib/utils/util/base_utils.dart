import 'dart:math';

import 'package:path/path.dart' as p;
import 'package:http/http.dart' as http;

class BaseUtils {
  BaseUtils._();

  static bool allowFileExtension(
    String file,
    List<String> allowFiles,
  ) {
    final _file = p.extension(file);
    return allowFiles.contains(_file);
  }

  static String? enumToStringSnakeCase(enumValue) {
    if (enumValue == null) return null;

    String enumString = enumValue.toString().split('.')[1];
    return enumString
        .replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) => '_${match.group(0)}',
        )
        .toLowerCase();
  }

  static Future<bool> checkUrl(String? url) async {
    try {
      if (url == null) return false;

      final response = await http.head(Uri.parse(url));
      return (response.statusCode >= 200 && response.statusCode < 300);
    } catch (e) {
      return false;
    }
  }

  static String generateRandomString(int len) {
    var r = Random();
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
        .join();
  }
}
