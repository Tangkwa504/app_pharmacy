import 'package:app_pharmacy/core/cache/io_file_system.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:injectable/injectable.dart';

// Example code if you'd like manual code
// https://stackoverflow.com/questions/60306287/save-network-images-in-flutter-to-load-them-offline
// https://github.com/Baseflow/flutter_cache_manager/issues/238
@Singleton()
class BaseCustomCacheManager extends CacheManager with ImageCacheManager {
  static const String key = "customCache";

  static BaseCustomCacheManager? _instance;

  BaseCustomCacheManager._()
      : super(
          Config(
            key,
            stalePeriod: const Duration(seconds: 1),
            maxNrOfCacheObjects: 1000,
            repo: JsonCacheInfoRepository(databaseName: key),
            fileSystem: IOFileSystem(key),
            fileService: HttpFileService(),
          ),
        );

  factory BaseCustomCacheManager() {
    return _instance ??= BaseCustomCacheManager._();
  }
}
