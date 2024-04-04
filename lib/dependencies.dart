import 'package:gerasenha/src/password_history/password_history_controller.dart';
import 'package:gerasenha/src/preferences/preferences_repository.dart';
import 'package:gerasenha/src/select_difficulty/difficulty_controller.dart';
import 'package:get_it/get_it.dart';

GetIt di = GetIt.I();

class Dependencies {
  // register dependecies
  resgister() {

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
