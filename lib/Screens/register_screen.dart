import 'package:chat_app/cubit/register_cubit/register_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../component/Text_Field.dart';
import '../component/button.dart';
import '../const/const.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  String? Email;
  String? Password;
  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if(state is RegisterLoading){
          isLoading = true;
        }
        else if(state is RegisterSuccess){
          isLoading = false;
          ScaffoldMessenger.of(context).showSnackBar( const SnackBar(
            content: Text('Register Success'),
            backgroundColor: Colors.blue,
          ));
          Navigator.pushNamed(context,  'ChatScreen' ,arguments:Email);
        } else if (state is RegisterError){
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar( SnackBar(
            content: Text(state.errorMessage),
            backgroundColor: Colors.red,
          ));
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Form(
                key: formKey,
                child: CustomScrollView(
                  slivers: [
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Column(
                        children:
                        [
                          SizedBox(
                            height: 75,
                          ),
                          Image.asset('assets/images/scholar.png',
                            height: 100,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Chat app",
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 75,
                          ),
                          Row(
                            children: [
                              Text("Register Now",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,),
                          CustomFormTextField(
                            validateText: 'Email Must not be empty',
                            onChanged: (data) {
                              Email = data;
                            },
                            hintText: 'Email',
                          ),
                          const SizedBox(
                            height: 15,),
                          CustomFormTextField(
                            validateText: 'Password Must not be empty',
                            onChanged: (data) {
                              Password = data;
                            },
                            hintText: 'Password',
                            obscureText: false,
                          ),
                          const SizedBox(
                            height: 20,),
                          CustomButton(
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                                BlocProvider.of<RegisterCubit>(context).registerUser(
                                    Email: Email!,
                                    Password: Password!
                                );
                              }
                            },
                            text: 'Register',
                          ),
                          const SizedBox(
                            height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('already have an account?',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text('  Login ',
                                  style: TextStyle(
                                    color: Color(0xffC7EDE6),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 75,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}
