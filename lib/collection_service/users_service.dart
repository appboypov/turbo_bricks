import 'package:get_it/get_it.dart';
import 'package:turbo_firestore_api/turbo_firestore_api.dart';

class UsersService extends TCollectionService<UserDto, User> {
  UsersService({
    required super.collection,
    required super.modelBuilder,
    super.apiBuilder,
    super.defaultValue,
    super.initialValue,
    super.streamBuilder,
    super.initialiseStream,
    super.firestoreCacheService,
    super.initialSortFilteredListsMap,
    super.modelDocsBuilder,
  });

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static UsersService get locate => GetIt.I.get();
  static void registerLazySingleton() => GetIt.I.registerLazySingleton(
    () => UsersService(
      collection: ,
      modelBuilder: ,
      initialiseStream: ,
    ),
    dispose: (param) async => await param.dispose(),
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
