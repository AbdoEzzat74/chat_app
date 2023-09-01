import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({required String Email , required String Password}) async{
   emit(LoginLoading());
    try {
      UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: Email,
          password: Password,);
      emit(LoginSuccess());
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(LoginError(errorMessage: 'user-not-found'));

      } else if (e.code == 'wrong-password') {
        emit(LoginError(errorMessage: 'wrong-password'));
      }
    }
    }
  }

