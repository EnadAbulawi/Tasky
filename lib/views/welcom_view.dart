import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:snackly/snackly.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/views/main_view.dart';

class WelcomeView extends StatelessWidget {
  WelcomeView({super.key});

  final TextEditingController userNameController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: const Color(0xfff6f7f9),
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
                    CustomSvgPicture.withoutColor(
                      path: 'assets/images/logo.svg',
                      height: 42,
                      width: 42,
                    ),

                    const SizedBox(width: 16),
                    Text(
                      'Tasky',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 118),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Welcome To Tasky',
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                    const SizedBox(width: 8),
                    CustomSvgPicture.withoutColor(
                      path: 'assets/images/hands.svg',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'Your productivity journey starts here.',
                  style: Theme.of(
                    context,
                  ).textTheme.displaySmall!.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 24),

                CustomSvgPicture.withoutColor(
                  path: 'assets/images/welcome.svg',
                  width: 215,
                  height: 205,
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 24),
                      CustomTextFormField(
                        controller: userNameController,
                        hintText: 'e.g. Enad Abulawi',
                        title: 'Full Name',
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return "Please Enter Your Full Name";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 24),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            MediaQuery.of(context).size.width,
                            50,
                          ),
                        ),
                        onPressed: () async {
                          // log(userNameController.text.toString());

                          if (_key.currentState?.validate() ?? false) {
                            await PreferencesManager().setString(
                              'username',
                              userNameController.value.text,
                            );

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MainView(),
                              ),
                            );
                          } else {
                            Snackly.error(
                              context: context,
                              title: 'خطأ',
                              message: "يجب عليك ادخال اسمك الكامل ",
                            );
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
