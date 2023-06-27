import 'package:bloc/bloc.dart';
import 'package:flashchat/services/auth/bloc/auth_event.dart';
import 'package:flashchat/services/auth/bloc/auth_state.dart';
import 'package:flashchat/services/auth/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(AuthProvider provider)
      : super(const AuthStateUninitialized(isLoading: true)) {
    on<AuthEventInitialize>((event, emit) async {
      await provider.initialize();
      final user = provider.currentUser;
      if (user == null) {
        emit(const AuthStateLoggedOut(
          exception: null,
        ));
      } else {
        emit(
          AuthStateLoggedIn(
            user: user,
          ),
        );
      }
    });

    on<AuthEventRegister>(
      (event, emit) async {
        final username = event.username;
        final email = event.email;
        final password = event.password;

        try {
          await EasyLoading.show(status: 'Registering...');
          await provider.createUser(
            email: email,
            userName: username,
            password: password,
          );

          await EasyLoading.showSuccess('Success!');

          emit(
            AuthStateLoggedIn(
              user: provider.currentUser!,
            ),
          );
        } on Exception catch (e) {
          emit(
            AuthStateRegistering(
              exception: e,
            ),
          );
        }

        await EasyLoading.dismiss();
      },
    );

    on<AuthEventLogIn>(
      (event, emit) async {
        emit(
          const AuthStateLogginIn(
            exception: null,
          ),
        );
        final email = event.email;
        final password = event.password;
        try {
          EasyLoading.show(status: 'Loggin in...');
          final user = await provider.logIn(email: email, password: password);
          await EasyLoading.dismiss();
          emit(
            AuthStateLoggedIn(
              user: user,
            ),
          );
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(
              exception: e,
            ),
          );
        }
      },
    );

    //log out
    on<AuthEventLogOut>(
      (event, emit) async {
        try {
          await provider.logOut();
          emit(
            const AuthStateLoggedOut(
              exception: null,
            ),
          );
        } on Exception catch (e) {
          emit(
            AuthStateLoggedOut(
              exception: e,
            ),
          );
        }
      },
    );

    on<AuthEventShouldRegister>(
      (event, emit) {
        emit(const AuthStateRegistering(
          exception: null,
        ));
      },
    );

    on<AuthEventShouldLogin>(
      (event, emit) {
        emit(const AuthStateLogginIn(
          exception: null,
        ));
      },
    );
  }
}
