import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snackly/snackly.dart';
import 'package:tasky/views/home_view.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({super.key});

  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/logo.svg',
                      width: 42,
                      height: 42,
                    ),
                    const SizedBox(width: 16),
                    Text(
                      'Tasky',
                      style: TextStyle(fontSize: 28, color: Color(0xfffffcfc)),
                    ),
                  ],
                ),
                const SizedBox(height: 118),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To Tasky',
                      style: TextStyle(fontSize: 24, color: Color(0xfffffcfc)),
                    ),
                    const SizedBox(width: 8),
                    SvgPicture.asset(
                      'assets/images/hands.svg',
                      width: 24,
                      height: 24,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Your productivity journey starts here.',
                  style: TextStyle(fontSize: 16, color: Color(0xff949494)),
                ),
                const SizedBox(height: 24),

                SvgPicture.asset(
                  'assets/images/welcome.svg',
                  width: 215,
                  height: 205,
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text(
                        'Full Name',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xfffffcfc),
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        onTapOutside: (_) =>
                            FocusManager.instance.primaryFocus?.unfocus(),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Full Name";
                          }
                          return null;
                        },
                        controller: userNameController,
                        style: TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          filled: true,

                          fillColor: const Color(0xff282828),
                          hintText: 'e.g. Enad Abulawi',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff15b86c),
                          foregroundColor: Color(0xfffffcfc),
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            50,
                          ),
                        ),
                        onPressed: () async {
                          // log(userNameController.text.toString());
                          final pref = await SharedPreferences.getInstance();
                          await pref.setString(
                            'username',
                            userNameController.value.text,
                          );

                          if (_key.currentState?.validate() ?? false) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HomeView(),
                              ),
                            );
                          } else {
                            Snackly.error(
                              context: context,
                              title: 'خطأ',
                              message: "يجب عليك ادخال اسمك الكامل ",
                            );

                            /// !TODO : add snackbar
                          }
                        },
                        child: Text('Let’s Get Started'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
