import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  static const String id = 'change_password';
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Change Password',
                style: TextStyle(fontSize: 30.0),
              ),
              const SizedBox(
                height: 70.0,
              ),
              const TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your previous password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your new password',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Enter your new password again',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                child: const Text('Send request'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
