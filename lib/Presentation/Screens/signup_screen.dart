import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grapewine_music_app/Colors/colors.dart';
import 'package:grapewine_music_app/Presentation/widgets/googleSignInWidget.dart';
import 'package:grapewine_music_app/Providers/date_provider.dart';
import 'package:grapewine_music_app/Providers/gender_provider.dart';
import 'package:grapewine_music_app/Providers/signup_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = true;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _dateofbirthController = TextEditingController();
  DateTime? dob;
  Future<void> _showDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: dob ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2026),
    );

    if (pickedDate != null) {
      setState(() {
        dob = pickedDate;
        _dateofbirthController.text =
            DateFormat('dd MMM yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print('Widget tree builded');
    var signUpProvider = Provider.of<SignupProvider>(context);
    return Scaffold(
        body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SafeArea(
        child: Center(
            child: Container(
          margin: EdgeInsets.only(left: 16, right: 16, top: 50, bottom: 30),
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
                      fontWeight: FontWeight.w700,
                      color: redColor,
                      fontSize: 20),
                ),
                SizedBox(
                  height: 20,
                ),
                GoogleSignInButton(text: 'Sign Up with Google'),
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
                  controller: _nameController,
                  style: GoogleFonts.redHatDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  keyboardType: TextInputType.text,
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
                  controller: _emailController,
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
                  controller: _passwordController,
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
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    // DatePickerWidget(),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: TextField(
                          controller: _dateofbirthController,
                          readOnly: true,
                          style: GoogleFonts.redHatDisplay(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                          onTap: () {
                            _showDatePicker(context);
                          },
                          decoration: InputDecoration(
                            hintText: 'Date of Birth',
                            prefixIcon: Icon(Icons.calendar_today_outlined),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            filled: true,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            fillColor: whiteColor,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 14.0),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Consumer<GenderProvider>(
                          builder: (context, genderProvider, child) {
                            return Container(
                              padding: EdgeInsets.only(left: 30, right: 30),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  style: GoogleFonts.redHatDisplay(
                                    color: backgroundColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  items:
                                      genderProvider.genders.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        textAlign: TextAlign.center,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    genderProvider.setGender(newValue!);
                                    print('Only i build');
                                    genderProvider.notifyListeners();
                                  },
                                  value: genderProvider.selectedGender,
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  child: Consumer<DateProvider>(
                    builder: (context, value, child) {
                      return ElevatedButton(
                        onPressed: () {
                          var name = _nameController.text.trim();
                          var email = _emailController.text.trim();
                          var password = _passwordController.text.trim();
                          try {
                            var dateofbirth =
                                _dateofbirthController.text.trim();
                            print(dateofbirth);

                            DateTime? dob =
                                DateFormat('dd MMM yyyy').parse(dateofbirth);

                            var gender = Provider.of<GenderProvider>(context,
                                    listen: false)
                                .selectedGender;

                            // var gender = _genderDropdownValue.toString().trim();
                            // signUp(context, name, email, password, dob, gender);
                            signUpProvider.signUpUser(
                                context, name, email, password, dob, gender);
                          } catch (e) {
                            print(e);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          backgroundColor: redColor,
                        ),
                        child: Text(
                          "SIGN UP",
                          style: GoogleFonts.redHatDisplay(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: 18),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Have an Account?',
                      style: GoogleFonts.redHatDisplay(
                        fontSize: 12,
                        color: whiteColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.toNamed('/login');
                      },
                      child: Text(
                        'Login now',
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
              ]),
        )),
      ),
    ));
  }
}
