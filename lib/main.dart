import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'core/theme/app_theme.dart';

// Import your BLoCs

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final apiService = ApiService();
  runApp(InsyderApp(apiService));
}

class InsyderApp extends StatelessWidget {
  final ApiService apiService;
  InsyderApp(
    this.apiService, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
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
        // Add any other BLoCs here
      ],
      child: MaterialApp.router(
        title: 'INSYDER Magazine',
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
