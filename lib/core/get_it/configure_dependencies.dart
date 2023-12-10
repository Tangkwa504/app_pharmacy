import 'package:app_pharmacy/core/get_it/configure_dependencies.config.dart';
import 'package:app_pharmacy/core/get_it/di_instance.dart';
import 'package:injectable/injectable.dart';

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();
