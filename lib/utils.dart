import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:tripwonder/firebase_options.dart';
import 'package:tripwonder/service/auth_service.dart';
import 'package:tripwonder/service/storage_service.dart';
import 'package:tripwonder/services/database_service.dart';
import 'package:tripwonder/services/navigation_service.dart';

Future<void> setupFirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> registerServices() async {
  final GetIt getIt = GetIt.instance;
  getIt.registerSingleton<AuthService>(
    AuthService(),
  );
  getIt.registerSingleton<NavigationService>(
    NavigationService(),
  );
  // getIt.registerSingleton<AlertService>(
  //   AlertService(),
  // );
  getIt.registerSingleton<StorageService>(
    StorageService(),
  );
  getIt.registerSingleton<DatabaseService>(
    DatabaseService(),
  );
}

String generateChatID({required String uid1, required String uid2}) {
  List uids = [uid1, uid2];
  uids.sort();
  String chatID = uids.fold("", (id, uid) => "$id$uid");
  return chatID;
}