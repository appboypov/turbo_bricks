import 'package:get_it/get_it.dart';
import 'package:turbo_firestore_api/turbo_firestore_api.dart';

class {{collectionObjectName.pascalCase()}}Service extends TDocService<{{collectionObjectName.pascalCase()}}Dto, {{collectionObjectName.pascalCase()}}> {
  {{collectionObjectName.pascalCase()}}Service({
    required super.defaultValue,
    required super.modelBuilder,
    required super.collection,
    super.onMissingRemoteValue,
    super.initialValue,
    super.afterLocalNotifyUpdate,
    super.apiBuilder,
    super.beforeLocalNotifyUpdate,
    super.firestoreCacheService,
    super.initialiseStream,
    super.streamBuilder,
  });

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static {{collectionObjectName.pascalCase()}}Service get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
    () => {{collectionObjectName.pascalCase()}}Service(
      defaultValue: ,
      onMissingRemoteValue: ,
      modelBuilder: ,
      collection: ,
    ),
  );

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\
  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
