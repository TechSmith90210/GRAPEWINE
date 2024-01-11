import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Authentications/login_function.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'signup_screen.dart';
import 'package:grapewine_music_app/Authentications/login_function.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
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
                        // Text(
                        //   'Password',
                        //   style: GoogleFonts.redHatDisplay(
                        //       color: greyColor, fontWeight: FontWeight.w600),
                        // ),
                        TextField(
                          controller: passwordController,
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          keyboardType: TextInputType.text,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter password',
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
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
                          child: ElevatedButton(
                            onPressed: () async {
                              var email = emailController.text.trim();
                              var password = passwordController.text.trim();
                              Auth auth = Auth();
                              await auth.login(context, email, password);
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
                                  color: Colors.white,
                                  fontSize: 18),
                            ),
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
                        Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Auth auth = Auth();
                              auth.signinwithgoogle(context);
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: whiteColor,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/google_icon.png',
                                  height: 20,
                                  width: 20,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Google",
                                  style: GoogleFonts.redHatDisplay(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: eerieblackColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
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
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SignUpScreen()));
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
