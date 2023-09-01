import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  Future<void> registerUser({required String Email , required String Password}) async{
    emit(RegisterLoading());
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      emit(RegisterSuccess());
    }  on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      emit(RegisterError(errorMessage: "weak-password"));
    }
    else if (e.code == 'email-already-in-use') {
      emit(RegisterError(errorMessage: 'email-already-in-use'));
    }
    }
  }
}
