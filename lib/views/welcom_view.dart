import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff181818),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
          ],
        ),
      ),
    );
  }
}
