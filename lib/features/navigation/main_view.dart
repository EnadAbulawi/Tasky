import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/features/tasks/complete_tasks_view.dart';
import 'package:tasky/features/home/home_view.dart';
import 'package:tasky/features/profile/profile_view.dart';
import 'package:tasky/features/tasks/tasks_view.dart';

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
        currentIndex: _currentIndex,
        onTap: (int? index) {
          setState(() {
            _currentIndex = index ?? 0;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: _BuildSvgPicture('assets/images/home.svg', 0),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: _BuildSvgPicture('assets/images/todo.svg', 1),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: _BuildSvgPicture('assets/images/todo_complete.svg', 2),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: _BuildSvgPicture('assets/images/profile.svg', 3),
            label: 'Profile',
          ),
        ],
      ),
      body: SafeArea(child: _view[_currentIndex]),
    );
  }

  SvgPicture _BuildSvgPicture(String path, int index) {
    return SvgPicture.asset(
      path,
      colorFilter: ColorFilter.mode(
        _currentIndex == index ? Color(0xff15B86C) : Color(0xffc6c6c6),
        BlendMode.srcIn,
      ),
    );
  }
}
