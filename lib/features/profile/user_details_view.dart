import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';

class UserDetailsView extends StatefulWidget {
  const UserDetailsView({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });
  final String userName;
  final String? motivationQuote;

  @override
  State<UserDetailsView> createState() => _UserDetailsViewState();
}

class _UserDetailsViewState extends State<UserDetailsView> {
  late final TextEditingController userNameController;
  late final TextEditingController motivationQuoteController;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    userNameController = TextEditingController(text: widget.userName);
    motivationQuoteController = TextEditingController(
      text: widget.motivationQuote,
    );
    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    motivationQuoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,

          child: Column(
            children: [
              CustomTextFormField(
                title: 'User Name',
                hintText: widget.userName,
                controller: userNameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter User Name";
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                title: 'Motivation Quote',
                hintText: '${widget.motivationQuote}',
                controller: motivationQuoteController,
                maxLines: 7,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please Enter Motivation Quote";
                  } else {
                    return null;
                  }
                },
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                ),
                onPressed: () async {
                  await PreferencesManager().setString(
                    'username',
                    userNameController.value.text,
                  );
                  await PreferencesManager().setString(
                    'motivation_quote',
                    motivationQuoteController.value.text,
                  );
                  if (_key.currentState!.validate()) {
                    Navigator.pop(context, true);

                    //save motivation quote
                    // when back safe result to main view
                  }
                },
                child: const Text('Save Changes'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
