import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sentimento/screens/analysis_screen/comments_screen.dart';
import 'package:sentimento/screens/analysis_screen/manual_analysis.dart';
import 'package:sentimento/screens/analysis_screen/tweets_screen.dart';
import 'package:sentimento/screens/authscreen_controller.dart';
import 'package:sentimento/screens/getstarted_screen/getstarted_screen.dart';
import 'package:sentimento/screens/home_screen/home_screen.dart';
import 'package:sentimento/screens/login_screen/login_screen.dart';
import 'package:sentimento/screens/mynetwork_screen/post_service.dart';
import 'package:sentimento/screens/mynetwork_screen/post_vacancy.dart';
import 'package:sentimento/screens/mynetwork_screen/user_posts.dart';
import 'package:sentimento/screens/mynetwork_screen/view_freelancers.dart';
import 'package:sentimento/screens/mynetwork_screen/view_vacancies.dart';
import 'package:sentimento/screens/profile_screen/profile_screen.dart';
import 'package:sentimento/screens/register_screen/register_screen.dart';
import 'package:sentimento/screens/reports_screen/reports_screen.dart';
import 'package:sentimento/utilities/routes.dart';

FlutterSecureStorage? secureStorage;

void main() {
  //making single instance so that it can be used again by other methods from multiple pages
  secureStorage = const FlutterSecureStorage();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.teal, brightness: Brightness.light),
    home: const AuthScreenController(),
    routes: {
      AppRoutes.getstartedscreen: (context) => const GetStartedScreen(),
      AppRoutes.loginscreen: (context) => const LoginScreen(),
      AppRoutes.registerscreen: (context) => const RegisterScreen(),
      AppRoutes.homescreen: (context) => const HomeScreen(),
      AppRoutes.profilescreen: (context) => const ProfileScreen(),
      AppRoutes.commentsAnalysis: (context) => const CommentsScreen(),
      AppRoutes.tweetsAnalysis: (context) => const TweetsScreen(),
      AppRoutes.manualAnalysis: (context) => const ManualAnalysis(),
      AppRoutes.reports: (context) => const ReportsScreen(),
      AppRoutes.myPosts: (context) => const UserPosts(),
      AppRoutes.viewVacancy: (context) => const ViewVacancies(),
      AppRoutes.viewFreelancer: (context) => const ViewFreelancers(),
      AppRoutes.postVacancy: (context) => const PostVacancy(),
      AppRoutes.postSkill: (context) => const PostService()
    },
  ));
}
