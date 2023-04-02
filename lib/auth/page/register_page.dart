import 'package:e_commerce/auth/page/login_page.dart';
import 'package:e_commerce/util/asset_string.dart';
import 'package:e_commerce/util/route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../util/app_color.dart';
import '../../util/app_theme.dart';
import '../../util/validator.dart';
import '../../widget/logo_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool obsecure = false;
  late TextEditingController nameTextController;
  late TextEditingController emailTextController;
  late TextEditingController passwordTextController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameTextController = TextEditingController();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [

             const LogoWidget(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      "User name",
                      style: TextStyle(color: AppColor.primaryColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) => Validator.valueExists(value),
                      controller: nameTextController,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                          // hintText: AppLocalizations.of(context).name,
                          prefixIcon: const Icon(Icons.person),
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Email",
                      style: TextStyle(color: AppColor.primaryColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) => Validator.phoneValidate(value),
                      keyboardType: TextInputType.phone,
                      controller: emailTextController,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                          // hintText: AppLocalizations.of(context).phone,
                           prefixIcon: const Icon(Icons.email_outlined),
                          ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Password",
                      style: TextStyle(color: AppColor.primaryColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      validator: (value) => Validator.passwordValidate(value),
                      controller: passwordTextController,
                      obscureText: obsecure,
                      decoration: AppTheme.authTextFieldDecoration.copyWith(
                        // hintText: AppLocalizations.of(context).password,
                         prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obsecure = !obsecure;
                            });
                          },
                          icon: obsecure
                              ? const Icon(CupertinoIcons.eye)
                              : const Icon(CupertinoIcons.eye_slash),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {  },
                        child: const Text("Register"),
                      ),
                    ),
                    // SizedBox(
                    //   width: double.infinity,
                    //   child: ElevatedButton(
                    //     onPressed: state.isLoading || regState.isLoading
                    //         ? () {}
                    //         : () async {
                    //             String? mesg = await ref
                    //                 .watch(checkPhoneController.notifier)
                    //                 .checkPhone(
                    //                     phone: emailTextController.text);
                    //             if (mounted) {
                    //               if (mesg == null) {
                    //                 ref
                    //                     .read(registerScreenController.notifier)
                    //                     .verifyPhoneForRegister(
                    //                       rf: RegisterationForm(
                    //                         name: nameTextController.text,
                    //                         phone: emailTextController.text,
                    //                         password:
                    //                             passwordTextController.text,
                    //                         referral:
                    //                             referralTextController.text,
                    //                       ),
                    //                       context: context,
                    //                     );
                    //                 // goto(
                    //                 //   context,
                    //                 //   page: CodeVerifyPage(
                    //                 //     phoneForForgotPassword: null,
                    //                 //     registerationForm: RegisterationForm(
                    //                 //       name: nameTextController.text,
                    //                 //       phone: emailTextController.text,
                    //                 //       password: passwordTextController.text,
                    //                 //       referral: referralTextController.text,
                    //                 //     ),
                    //                 //     verificationId: "",
                    //                 //   ),
                    //                 // );
                    //               } else {
                    //                 context.showErrorSnackbar(mesg);
                    //               }
                    //             }
                    //           },
                    //     child: state.isLoading || regState.isLoading
                    //         ? const Padding(
                    //             padding: EdgeInsets.all(3.0),
                    //             child: CircularProgressIndicator(
                    //               color: AppColor.textColor,
                    //             ),
                    //           )
                    //         : Text(AppLocalizations.of(context).register),
                    //   ),
                    // ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Do you have account?"),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              //goto(context, page:const LoginPage());
                            },
                            child: const Text("Login"),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

