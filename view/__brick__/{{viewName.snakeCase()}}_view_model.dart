import 'package:get_it/get_it.dart';
import 'package:turbo_mvvm/turbo_mvvm.dart';
import 'package:turbolytics/turbolytics.dart';

import '{{viewName.snakeCase()}}_arguments.dart';

class {{viewName.pascalCase()}}ViewModel extends TBaseViewModel<{{viewName.pascalCase()}}Arguments> with Turbolytics {
  {{viewName.pascalCase()}}ViewModel();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static {{viewName.pascalCase()}}ViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory({{viewName.pascalCase()}}ViewModel.new);

  // 🧩 DEPENDENCIES -------------------------------------------------------------------------- \\
  // 🎬 INIT & DISPOSE ------------------------------------------------------------------------ \\

  @override
  Future<void> initialise({bool doSetInitialised = true}) async {
    await super.initialise(doSetInitialised: doSetInitialised);
  }

  @override
  Future<void> dispose() async {
    await super.dispose();
  }

  // 👂 LISTENERS ----------------------------------------------------------------------------- \\
  // ⚡️ OVERRIDES ----------------------------------------------------------------------------- \\
  // 🎩 STATE --------------------------------------------------------------------------------- \\
  // 🛠 UTIL ---------------------------------------------------------------------------------- \\
  // 🧲 FETCHERS ------------------------------------------------------------------------------ \\
  // 🏗️ HELPERS ------------------------------------------------------------------------------- \\
  // 🪄 MUTATORS ------------------------------------------------------------------------------ \\
}
