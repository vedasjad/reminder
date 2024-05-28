import 'package:flutter_bloc/flutter_bloc.dart';

import 'logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log.wtf('${bloc.runtimeType} Created!');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log.wtf(
        '$bloc Changed - [${change.currentState.runtimeType}] --> [${change.nextState.runtimeType}]');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log.wtf('${bloc.runtimeType} Closed!');
  }
}
