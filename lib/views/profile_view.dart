import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widgets/custom_svg_picture.dart';
import 'package:tasky/views/user_details_view.dart';
import 'package:tasky/views/welcom_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late String username;
  late String motivationQuote;
  String? profileImagePath;
  bool isLoading = true;

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  void _loadData() async {
    username = PreferencesManager().getString('username') ?? '';
    motivationQuote =
        PreferencesManager().getString('motivation_quote') ??
        'One task at a time. One step closer.';
    profileImagePath = PreferencesManager().getString('profile_image');
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundImage: profileImagePath == null
                                ? AssetImage('assets/images/person.png')
                                : FileImage(File(profileImagePath!)),
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            onTap: () async {},
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: IconButton(
                                onPressed: () async {
                                  showImageSourceDialog(context, (XFile file) {
                                    _saveImage(file);
                                    setState(() {
                                      profileImagePath = file.path;
                                    });
                                  });
                                },
                                icon: Icon(Icons.camera_alt, size: 26),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        motivationQuote,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Profile Info',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                const SizedBox(height: 16),

                // Add more widgets for profile details
                ListTile(
                  onTap: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailsView(
                          userName: username,
                          motivationQuote: motivationQuote,
                        ),
                      ),
                    );
                    if (result != null && result == true) {
                      _loadData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    path: 'assets/images/user_icon.svg',
                  ),

                  title: Text('User Details'),
                  trailing: Icon(Icons.arrow_forward),
                ),
                Divider(),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    path: 'assets/images/dark_icon.svg',
                  ),

                  title: Text('Dark Mode'),
                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (context, ThemeMode themeMode, child) => Switch(
                      value: themeMode == ThemeMode.dark,
                      onChanged: (bool value) async {
                        ThemeController.toggleTheme();
                      },
                    ),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () async {
                    PreferencesManager().remove('username');
                    PreferencesManager().remove('motivation_quote');
                    PreferencesManager().remove('task');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return WelcomeView();
                        },
                      ),
                      (route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  leading: CustomSvgPicture(
                    path: 'assets/images/logout_icon.svg',
                  ),

                  title: Text('Log Out'),
                  trailing: Icon(Icons.arrow_forward),
                ),
              ],
            ),
          );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy('${appDir.path}/${file.name}');
    PreferencesManager().setString('profile_image', newFile.path);
    log('Image saved to ${appDir.path}/${file.name}');
  }
}

void showImageSourceDialog(BuildContext context, Function(XFile) selectedFile) {
  showDialog(
    context: context,
    builder: (context) {
      return SimpleDialog(
        title: Text(
          'Select Image Source',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.camera_alt),
                SizedBox(width: 8),
                Text('Camera'),
              ],
            ),
            onPressed: () async {
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (image != null) {
                selectedFile(image);
                Navigator.pop(context);
              }
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(Icons.photo_library),
                SizedBox(width: 8),
                Text('Gallery'),
              ],
            ),
            onPressed: () async {
              XFile? image = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (image != null) {
                selectedFile(image);
                Navigator.pop(context);
              }
            },
          ),
        ],
      );
    },
  );
}
