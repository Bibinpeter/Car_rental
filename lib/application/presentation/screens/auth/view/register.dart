import 'package:carrental/application/presentation/screens/auth/model/usermodel.dart';
import 'package:carrental/application/presentation/screens/auth/widgets/customtextformfield.dart';
import 'package:carrental/domain/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

import '../auth_bloc/bloc/auth_bloc.dart';

class RegisterPageWrapper extends StatelessWidget {
  const RegisterPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authbloc = BlocProvider.of<AuthBloc>(context);
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is Authenticated) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        });
      }

      return Scaffold(
          backgroundColor: scaffoldcolor,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
            backgroundColor: const Color(0xfff263147),
          ),
          body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              height: double.infinity,
              width: double.infinity,
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                          const WidgetCircularAnimator(
                            size: 130 ,
                            child: Icon(Icons.person_add,size: 80,color: kwhite,),
                            ),
                        Text(
                          "Register",
                          style: Theme.of(context).textTheme.displayLarge!.copyWith(color: kwhite)
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            controller: _emailController,
                            hintText: "Enter Email"),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            obscureText: true,
                            controller: _passwordController,
                            hintText: "Enter Password"),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            controller: _nameController,
                            hintText: "Enter Name"),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                            controller: _phoneController,
                            hintText: "Enter Phone"),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        InkResponse(
                          onTap: () {
                            Usermodel user = Usermodel(
                                name: _nameController.text,
                                email: _emailController.text,
                                password: _passwordController.text,
                                phone: _phoneController.text);

                            authbloc.add(SignupEvent(user: user));
                          },
                          child: Container(
                            height: 52,
                            width: 250,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.orange),
                            child: Center(
                              child: Text(
                                "Register",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an Account?",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(color:kwhite),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  "Login",
                                  style: Theme.of(context).textTheme.bodySmall!.copyWith(color: kwhite)
                                ))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )));
    });
  }
}
