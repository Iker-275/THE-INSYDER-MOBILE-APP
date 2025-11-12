import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:insyder/app_router.dart';

import 'home_screen.dart';

class HomeNavigatorScreen extends StatefulWidget {
  const HomeNavigatorScreen({super.key});

  @override
  State<HomeNavigatorScreen> createState() => _HomeNavigatorScreenState();
}

class _HomeNavigatorScreenState extends State<HomeNavigatorScreen> {
  final GlobalKey<NavigatorState> _homeNavigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: _homeNavigatorKey,
      initialRoute: '',
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (_) => _resolvePage(settings.name, settings.arguments),
          settings: settings,
        );
      },
    );
  }

  Widget _resolvePage(String? route, Object? args) {
    switch (route) {
      // case RouteNames.homeScreen:
      //   return const HomeScreen();
      //
      // case RouteNames.webview:
      //   final args2 = args as Map<String, dynamic>;
      //   return WebViewScreen(
      //     title: args2['title'],
      //     url: args2['url'],
      //   );
      //
      // case RouteNames.topicDetails:
      //   final args2 = args as Map<String, dynamic>?;
      //
      //   return TopicDetailsScreen(
      //     categoryId: args2!['topicId'],
      //     categoryTitle: args2['topicTitle'] ?? 'Topic',
      //   );
      // case RouteNames.postDetails:
      //   final args2 = args as Map<String, dynamic>?;
      //
      //   return PostDetailsScreen(
      //     postId: args2!['postId'],
      //   );
      // case RouteNames.subTopicDetails:
      //   final args2 = args as Map<String, dynamic>?;
      //
      //   return SubTopicDetailsScreen(
      //     subcategoryId: args2!['subTopicId'],
      //     subcategoryTitle: args2['subTopicTitle'] ?? 'Topic',
      //   );
      // case RouteNames.lessonDetails:
      //   final args2 = args as Map<String, dynamic>?;
      //
      //   return LessonDetailsPage(
      //     lessonId: args2!['lessonId'],
      //   );
      default:
        return const HomeScreen();
    }
  }
}
