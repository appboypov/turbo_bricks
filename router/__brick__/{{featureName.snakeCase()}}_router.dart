import 'package:get_it/get_it.dart';
import 'package:turbo_modules/routing/abstracts/t_route.dart';
import 'package:turbo_modules/routing/abstracts/t_router.dart';
import 'package:turbo_modules/routing/services/app_routing_service.dart';
import 'package:turbo_modules/routing/services/navigation_tab_service.dart';

class {{featureName.pascalCase()}}Router extends TRouter {
  {{featureName.pascalCase()}}Router({
    required super.initialRoute,
    required super.appRoutingService,
    required super.navigationTabService,
  });

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static {{featureName.pascalCase()}}Router Function() get lazyLocate => () => GetIt.I.get();
  static {{featureName.pascalCase()}}Router get locate => GetIt.I.get();
  static void registerFactory({required TRoute initialRoute}) => GetIt.I.registerFactory(
    () => {{featureName.pascalCase()}}Router(
      initialRoute: initialRoute,
      appRoutingService: AppRoutingService.locate,
      navigationTabService: NavigationTabService.locate,
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
