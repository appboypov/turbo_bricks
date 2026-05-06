import 'package:get_it/get_it.dart';
import 'package:turbo_mvvm/turbo_mvvm.dart';
import 'package:turbolytics/turbolytics.dart';

import 'login_arguments.dart';

class LoginViewModel extends TBaseViewModel<LoginArguments> with Turbolytics {
  LoginViewModel();

  // 📍 LOCATOR ------------------------------------------------------------------------------- \\

  static LoginViewModel get locate => GetIt.I.get();
  static void registerFactory() => GetIt.I.registerFactory(LoginViewModel.new);

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
