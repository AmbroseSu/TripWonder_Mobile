import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:tripwonder/firebase_options.dart';
import 'package:tripwonder/service/media_service.dart';
import 'package:tripwonder/service/storage_service.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<StorageService>(
    StorageService(),
  );
  getIt.registerSingleton<MediaService>(
    MediaService(),
  );
}

