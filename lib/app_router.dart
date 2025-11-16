import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insyder/core/bloc/profile/profile_events.dart';
import 'package:insyder/features/profile/create_profile_screen.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/signup_screen.dart';
import 'features/auth/splash_screen.dart';
import 'features/home/home_screen.dart';
import 'features/profile/profile_screen.dart';
import 'home_shell.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String homeScreen = '/home_screen';
  static const String profile = '/profile';
  static const String createProfile = '/create_profile';
  static const String updateProfile = '/update_profile';
  static const String createArticle = '/create_article';

  static const String webview = '/webview';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // case webview:
      //   final args = settings.arguments as Map<String, dynamic>;
      //   return MaterialPageRoute(
      //     builder: (_) => WebViewScreen(
      //       title: args['title'],
      //       url: args['url'],
      //     ),
      //   );
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const SignInPage());

      case register:
        return MaterialPageRoute(builder: (_) => const SignUpPage());

      case home:
        return MaterialPageRoute(builder: (_) => const HomeShell());

      case homeScreen:
        return MaterialPageRoute(builder: (_) => const HomeScreen());

      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case createProfile:
        return MaterialPageRoute(builder: (_) => CreateAuthorProfilePage());

      case updateProfile:
        return MaterialPageRoute(builder: (_) => CreateAuthorProfilePage());

      case createArticle:
        return MaterialPageRoute(builder: (_) => CreateAuthorProfilePage());

      // case RouteNames.topicDetails:
      //   final args = settings.arguments as Map<String, dynamic>?;
      //
      //   return MaterialPageRoute(
      //     builder: (_) => TopicDetailsScreen(
      //       categoryId: args!['topicId'],
      //       categoryTitle: args['topicTitle'] ?? 'Topic',
      //     ),
      //   );

      ///usage
      //     Navigator.pushNamed(
      //       context,
      //       RouteNames.topicDetail,
      //       arguments: {
      //         'topicId': 42,
      //         'topicTitle': 'Understanding Consent',
      //       },
      //   );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
