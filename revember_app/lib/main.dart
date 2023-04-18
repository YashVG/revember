// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revember_app/firebase_options.dart';
import 'package:revember_app/screens/initial_screens/login_recovery.dart';
import 'package:revember_app/screens/initial_screens/signup_screen2.dart';
import 'package:revember_app/screens/revision_screens/question_screens/create_questions.dart';
import 'screens/initial_screens/welcome_screen.dart';
import 'screens/initial_screens/login_screen.dart';
import 'screens/initial_screens/signup_screen.dart';
import 'screens/main_screens/home_page.dart';
import 'screens/main_screens/settings.dart';
import 'screens/revision_screens/phone_screens/view_notes.dart';
import 'screens/revision_screens/subject_screen.dart';
import 'screens/revision_screens/topic_screen.dart';
import 'screens/revision_screens/notes_screen_desktop.dart';
import 'screens/revision_screens/writing_screens/write_notes.dart';
import 'screens/revision_screens/writing_screens/writing_guide.dart';
import 'package:revember_app/screens/revision_screens/question_screens/question_guide.dart';
import 'package:revember_app/screens/quiz_screens/easy_quiz_screen.dart';
import 'package:revember_app/screens/quiz_screens/medium_quiz_screen.dart';
import 'package:revember_app/screens/quiz_screens/hard_quiz_screen.dart';
import 'package:revember_app/test/test_screen.dart';
import 'package:revember_app/screens/revision_screens/statistics_screen.dart';
import 'package:revember_app/preferences/themes.dart';
import 'package:revember_app/screens/revision_screens/phone_screens/notes_screen_phone.dart';
import 'package:revember_app/screens/calendar_screens/calendar_phone.dart';
import 'package:revember_app/screens/settings_screens/nuke_account.dart';
import 'package:revember_app/screens/settings_screens/erase_data_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:revember_app/components/calendar/event.dart';
import 'package:revember_app/screens/settings_screens/change_password.dart';
import 'package:revember_app/screens/revision_screens/phone_screens/view_stats.dart';

//Platform allows us to identify the current platform

bool isLoggedIn = false;

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
      // initialRoute: TestScreen.id,
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
        EraseDataScreen.id: (context) => EraseDataScreen(),
        NukeAccount.id: (context) => NukeAccount(),
        SubjectScreen.id: (context) => SubjectScreen(),
        TopicScreen.id: (context) => TopicScreen(),
        NotesScreenDesktop.id: (context) => NotesScreenDesktop(),
        NotesScreenPhone.id: (context) => NotesScreenPhone(),
        PhoneViewNotes.id: (context) => PhoneViewNotes(),
        ViewStatsPhone.id: (context) => ViewStatsPhone(),
        StatsScreen.id: (context) => StatsScreen(),
        NotesGuidesScreen.id: (context) => NotesGuidesScreen(),
        WriteNotesScreen.id: (context) => WriteNotesScreen(),
        QuestionGuide.id: (context) => QuestionGuide(),
        CreateQuestionScreen.id: (context) => CreateQuestionScreen(),
        EasyTestQuizScreen.id: (context) => EasyTestQuizScreen(),
        MediumTestQuizScreen.id: (context) => MediumTestQuizScreen(),
        HardTestQuizScreen.id: (context) => HardTestQuizScreen(),
        TestScreen.id: (context) => TestScreen(),
        Calendar.id: (context) => Calendar(),
      },
    );
  }
}
