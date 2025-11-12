import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insyder/core/bloc/article/article_bloc.dart';
import 'package:insyder/core/bloc/author/author_bloc.dart';
import 'package:insyder/core/bloc/genre/genre_bloc.dart';
import 'package:insyder/core/repository/article_repo.dart';
import 'package:insyder/core/repository/auth_repo.dart';
import 'package:insyder/core/repository/author_repo.dart';
import 'package:insyder/core/repository/genre_repo.dart';
import 'package:insyder/core/utils/secure_storage.dart';
import 'app_router.dart';
import 'core/api/api_service.dart';
import 'core/bloc/auth/auth_bloc.dart';
import 'core/bloc/network_bloc.dart';
import 'core/theme/app_theme.dart';
import 'package:provider/provider.dart';

import 'core/theme/theme_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final apiService = ApiService();
  final themeManager = ThemeManager();

  runApp(
    ChangeNotifierProvider<ThemeManager>.value(
      value: themeManager,
      child: InsyderApp(apiService: apiService),
    ),
  );
}

class InsyderApp extends StatelessWidget {
  final ApiService apiService;

  const InsyderApp({
    super.key,
    required this.apiService,
  });

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NetworkBloc()),
          BlocProvider<AuthBloc>(
            create: (_) =>
                AuthBloc(AuthRepository(apiService, SecureStorageService())),
          ),
          BlocProvider<ArticleBloc>(
            create: (_) => ArticleBloc(ArticleRepository(apiService)),
          ),
          BlocProvider<GenreBloc>(
            create: (_) => GenreBloc(GenreRepository(apiService)),
          ),
          BlocProvider<AuthorBloc>(
            create: (_) => AuthorBloc(AuthorRepository(apiService)),
          ),
        ],
        child: ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return MaterialApp(
                title: 'INSYDER Magazine',
                themeMode: themeManager.themeMode,
                theme: AppThemes.lightTheme,
                darkTheme: AppThemes.darkTheme,
                initialRoute: AppRoutes.splash,
                onGenerateRoute: AppRoutes.generateRoute,
                debugShowCheckedModeBanner: false,
              );
            }));
  }
}
