import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:intl/intl.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  TextEditingController _dateofbirthController = TextEditingController();

  Future<void> _showDatePicker() async {
    DateTime? _picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2026));

    String _formatDate(DateTime date) {
      return DateFormat('dd/MM/yyyy')
          .format(date); // Change the date format here
    }

    if (_picked != null) {
      setState(() {
        _dateofbirthController.text = _formatDate(_picked);
      });
    }
  }

  String gender1 = 'Male';
  String gender2 = 'Female';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Center(
          child: Container(
        margin: EdgeInsets.only(left: 16, right: 16, top: 120, bottom: 30),
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
                'SIGNUP PAGE',
                style: GoogleFonts.redHatDisplay(
                    fontWeight: FontWeight.w700, color: redColor, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
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
                        "Sign up with Google",
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
                height: 10,
              ),
              Text(
                'Or',
                style: GoogleFonts.redHatDisplay(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: greyColor),
              ),
              Text(
                'Using e-mail address',
                style: GoogleFonts.redHatDisplay(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    color: greyColor),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                // controller: emailController,
                style: GoogleFonts.redHatDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'What’s your Name?',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusColor: purpleColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                // controller: emailController,
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
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                // controller: passwordController,
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
                    child: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusColor: purpleColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Container(
              //   color: whiteColor,
              //   child: MaterialButton(
              //       onPressed: () {
              //         _showDatePicker();
              //       },
              //       child: Text('date of birth')),
              // )

              TextField(
                controller: _dateofbirthController,
                readOnly: true,
                style: GoogleFonts.redHatDisplay(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
                onTap: () {
                  _showDatePicker();
                },
                decoration: InputDecoration(
                  hintText: 'Date of Birth',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  filled: true,
                  fillColor: whiteColor,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  focusColor: purpleColor,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                ),
              ),
             
            ]),
      )),
    ));
  }
}
