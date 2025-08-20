import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/views/complete_tasks_view.dart';
import 'package:tasky/views/home_view.dart';
import 'package:tasky/views/profile_view.dart';
import 'package:tasky/views/tasks_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final List<Widget> _view = [
    HomeView(),
    TasksView(),
    CompleteTasksView(),
    ProfileView(),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff181818),
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Color(0xffc6c6c6),
        selectedItemColor: Color(0xff15B86C),
        currentIndex: _currentIndex,
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 0 ? Color(0xff15B86C) : Color(0xffc6c6c6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/todo.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 1 ? Color(0xff15B86C) : Color(0xffc6c6c6),
                BlendMode.srcIn,
              ),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/todo_complete.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 2 ? Color(0xff15B86C) : Color(0xffc6c6c6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              colorFilter: ColorFilter.mode(
                _currentIndex == 3 ? Color(0xff15B86C) : Color(0xffc6c6c6),
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
      body: _view[_currentIndex],
    );
  }
}
