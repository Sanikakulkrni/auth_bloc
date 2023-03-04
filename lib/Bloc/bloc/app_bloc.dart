import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:phone_bloc/repository/repository.dart';

import '../../models/usermodel.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final AuthRepository _authRepository;
  StreamSubscription<User>? _userSubscription;
  AppBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AppState.authenticated(authRepository.currentUser)
            : const AppState.unauthenticated()) {
    void _onUserChanged(
      _AppUserChanged event,
      Emitter<AppState> emit,
    ) {
      emit(
        event.user.isNotEmpty
            ? AppState.authenticated(event.user)
            : const AppState.unauthenticated(),
      );
    }

  

    void _onLogoutRequested(
      AppLogoutRequested event,
      Emitter<AppState> emit,
    ) {
      unawaited(_authRepository.logout(email: '', password: ''));
    }

    on<_AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    _userSubscription = _authRepository.user.listen(
      (user) => add(_AppUserChanged(user)),
    );
    @override
    Future<void> close() {
      _userSubscription?.cancel();
      return super.close();
    }
  }
}
