import 'package:gerasenha/main.dart';
import 'package:gerasenha/src/password_history/password_history_controller.dart';
import 'package:gerasenha/src/preferences/preferences_repository.dart';
import 'package:gerasenha/src/select_difficulty/difficulty_controller.dart';

class Dependencies {
  // register dependecies
  void register() {
    //repositories
    di.registerSingleton<PreferencesRepository>(
      PreferencesRepository(),
    );

    // controllers
    di.registerSingleton<PasswordHistoryController>(
      PasswordHistoryController(di()),
    );
    di.registerSingleton<DifficultyController>(
      DifficultyController(di()),
    );
  }
}
