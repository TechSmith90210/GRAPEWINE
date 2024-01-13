import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/googleSignInWidget.dart';
import 'package:grapewine_music_app/Providers/login_provider.dart';
import 'package:grapewine_music_app/Providers/password_provider.dart';
import 'package:provider/provider.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print('Widget tree rebuilt');
    var loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 100, bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/grapewine_logo.png',
                  height: 125,
                  width: 125,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'LOGIN PAGE',
                  style: GoogleFonts.redHatDisplay(
                      fontWeight: FontWeight.w700,
                      color: redColor,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 25,
                ),
                Form(
                    autovalidateMode: AutovalidateMode.always,
                    child: Column(
                      children: [
                        // Text(
                        //   'Email',
                        //   style: GoogleFonts.redHatDisplay(
                        //       color: greyColor, fontWeight: FontWeight.w600),
                        // ),
                        TextField(
                          controller: emailController,
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            filled: true,
                            fillColor: whiteColor,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            focusColor: purpleColor,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 14.0),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Consumer<PasswordProvider>(
                          builder: (context, passwordProvider, child) {
                            return TextField(
                              controller: passwordProvider.passwordController,
                              style: GoogleFonts.redHatDisplay(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: passwordProvider.obscureText,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                hintText: 'Enter password',
                                suffixIcon: InkWell(
                                  onTap: () {
                                    print('I rebuilt!');
                                    passwordProvider.seePassword();
                                  },
                                  child: Icon(passwordProvider.obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                filled: true,
                                fillColor: whiteColor,
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
                                focusColor: purpleColor,
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 14.0),
                              ),
                            );
                          },
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password?',
                              style: GoogleFonts.redHatDisplay(
                                  fontSize: 12, color: greyColor),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Consumer<PasswordProvider>(
                            builder: (context, passwordProvider, child) {
                              return ElevatedButton(
                                onPressed: () async {
                                  var email = emailController.text.trim();
                                  var password = passwordProvider
                                      .passwordController.text
                                      .trim();

                                  loginProvider.login(context, email, password);
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  backgroundColor: redColor,
                                ),
                                child: Text(
                                  "LOGIN",
                                  style: GoogleFonts.redHatDisplay(
                                      fontWeight: FontWeight.w700,
                                      color: whiteColor,
                                      fontSize: 18),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Or login with',
                          style: GoogleFonts.redHatDisplay(
                              fontSize: 12,
                              fontWeight: FontWeight.w300,
                              color: greyColor),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        GoogleSignInButton(text: 'Google'),
                        SizedBox(
                          height: 18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don’t have an Account?',
                              style: GoogleFonts.redHatDisplay(
                                fontSize: 12,
                                color: whiteColor,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Get.toNamed('/signup');
                              },
                              child: Text(
                                'Sign Up now',
                                style: GoogleFonts.redHatDisplay(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  color: redColor,
                                  decoration: TextDecoration.underline,
                                  decorationColor: redColor,
                                  decorationThickness: 1.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
