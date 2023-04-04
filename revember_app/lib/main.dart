// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revember_app/firebase_options.dart';
import 'package:revember_app/screens/initial_screens/login_recovery.dart';
import 'package:revember_app/screens/initial_screens/signup_screen2.dart';
import 'package:revember_app/screens/revision_screens/question_screens/create_questions.dart';
import 'package:revember_app/services/user_services/user_login.dart';
import 'screens/initial_screens/welcome_screen.dart';
import 'screens/initial_screens/login_screen.dart';
import 'screens/initial_screens/signup_screen.dart';
import 'screens/main_screens/home_page.dart';
import 'screens/initial_screens/login_recovery.dart';
import 'screens/main_screens/settings.dart';
import 'screens/calendar_screens/add_testdate.dart';
import 'screens/calendar_screens/calendar_screen.dart';
import 'screens/revision_screens/subject_screen.dart';
import 'screens/revision_screens/create_subject.dart';
import 'screens/revision_screens/topic_screen.dart';
import 'screens/revision_screens/create_topic.dart';
import 'screens/revision_screens/notes_screen_desktop.dart';
import 'screens/revision_screens/writing_screens/write_notes.dart';
import 'screens/revision_screens/writing_screens/writing_guide.dart';
import 'package:revember_app/screens/revision_screens/question_screens/main_question_screen.dart';
import 'package:revember_app/screens/revision_screens/question_screens/question_guide.dart';
import 'package:revember_app/screens/quiz_screens/quiz_screen.dart';
import 'package:revember_app/test/test_screen.dart';
import 'package:revember_app/preferences/themes.dart';
import 'package:revember_app/screens/calendar_screens/calendar_phone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:revember_app/constants/user_constants.dart';
import 'package:revember_app/constants/calendar_display_constants.dart';
import 'package:revember_app/components/calendar/event.dart';
import 'package:revember_app/screens/settings_screens/change_password.dart';
import 'dart:convert';

import 'dart:io' show Platform;
//Platform allows us to identify the current platform

bool isLoggedIn = false;
Map<DateTime, List<Event>> calendar = {};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences pref = await SharedPreferences.getInstance();

  bool checker = pref.getBool('isLoggedIn') ?? false;
  if (checker == true) {
    isLoggedIn = true;
  }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(Revember());
}
//runApp executes the widget tree and renders the app to the screen, once the Firebase app is initialized

class Revember extends StatefulWidget {
  @override
  State<Revember> createState() => _RevemberState();
}

class _RevemberState extends State<Revember> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: isDark == true ? ThemeData.dark() : ThemeData.light(),
      //ternary op to change mode depending on button change in settings page

      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
      initialRoute: isLoggedIn == true ? HomePage.id : WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        SignUpScreen.id: (context) => SignUpScreen(),
        SignUpScreen2.id: (context) => SignUpScreen2(),
        LoginRecoveryScreen.id: (context) => LoginRecoveryScreen(),
        ChangePassword.id: (context) => ChangePassword(),
        HomePage.id: (context) => HomePage(),
        SettingsScreen.id: (context) => SettingsScreen(),
        AddTestDate.id: (context) => AddTestDate(),
        CalendarScreen.id: (context) => CalendarScreen(),
        SubjectScreen.id: (context) => SubjectScreen(),
        CreateSubjectScreen.id: (context) => CreateSubjectScreen(),
        TopicScreen.id: (context) => TopicScreen(),
        CreateTopicScreen.id: (context) => CreateTopicScreen(),
        NotesScreenDesktop.id: (context) => NotesScreenDesktop(),
        NotesGuidesScreen.id: (context) => NotesGuidesScreen(),
        WriteNotesScreen.id: (context) => WriteNotesScreen(),
        QuestionGuide.id: (context) => QuestionGuide(),
        MainQuestionScreen.id: (context) => MainQuestionScreen(),
        CreateQuestionScreen.id: (context) => CreateQuestionScreen(),
        TestQuizScreen.id: (context) => TestQuizScreen(),
        TestScreen.id: (context) => TestScreen(),
        Calendar.id: (context) => Calendar(),
      },
    );
  }
}
