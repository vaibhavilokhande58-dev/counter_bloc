import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      if (event.email.trim().isEmpty) {
        emit(LoginError('Email is required'));
        return;
      }

      if (event.password.isEmpty) {
        emit(LoginError('Password is required'));
        return;
      }

      if (!event.email.contains('@')) {
        emit(LoginError('Please enter a valid email'));
        return;
      }

      if (event.password.length < 6) {
        emit(LoginError('Password must be at least 6 characters'));
        return;
      }

      emit(LoginLoading());

      await Future.delayed(const Duration(seconds: 2));

      emit(LoginSuccess());
    });
  }
}
