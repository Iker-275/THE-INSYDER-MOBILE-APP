import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/bloc/article/article_bloc.dart';
import '../../core/bloc/base_state.dart';
import '../../core/models/article.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_cards.dart';
import '../../widgets/shimmer_loaders.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  final _scrollController = ScrollController();

  int _currentPage = 1;
  bool _isFetchingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    context.read<ArticleBloc>().add(LoadArticles(page: _currentPage));

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 150 &&
          !_isFetchingMore &&
          _hasMore) {
        _loadMore();
      }
    });
  }

  Future<void> _onRefresh() async {
    _currentPage = 1;
    _hasMore = true;
    context.read<ArticleBloc>().add(RefreshArticlesRequested());
  }

  void _onSearch(String query) {
    _currentPage = 1;
    _hasMore = true;
    context.read<ArticleBloc>().add(SearchArticlesRequested(query: query));
  }

  void _loadMore() {
    setState(() => _isFetchingMore = true);
    _currentPage++;
    context.read<ArticleBloc>().add(LoadArticles(page: _currentPage));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: const CustomAppBar(title: "INSYDER", centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          child: Column(
            children: [
              // 🔍 Search Bar
              TextField(
                controller: _searchController,
                onChanged: _onSearch,
                decoration: InputDecoration(
                  hintText: "Search articles...",
                  prefixIcon: const Icon(Icons.search_rounded),
                  filled: true,
                  fillColor: theme.colorScheme.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
              SizedBox(height: 12.h),

              Expanded(
                child: BlocConsumer<ArticleBloc, BaseState<List<ArticleModel>>>(
                  listener: (context, state) {
                    if (state.status == BaseStatus.success) {
                      setState(() => _isFetchingMore = false);
                      if (state.data == null || state.data!.isEmpty) {
                        _hasMore = false;
                      }
                    } else if (state.status == BaseStatus.error) {
                      setState(() => _isFetchingMore = false);
                    }
                  },
                  builder: (context, state) {
                    if (state.isLoading &&
                        (state.data == null || state.data!.isEmpty)) {
                      return const ArticleSkeletonList();
                    }

                    if (state.status == BaseStatus.error) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              state.error ?? "Something went wrong",
                              style: TextStyle(
                                color: theme.colorScheme.error,
                                fontSize: 14.sp,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            PrimaryButton(
                              label: "Retry",
                              onPressed: () => context
                                  .read<ArticleBloc>()
                                  .add(LoadArticles(page: _currentPage)),
                            ),
                          ],
                        ),
                      );
                    }

                    if (state.status == BaseStatus.success &&
                        state.data != null) {
                      final articles = state.data!;
                      if (articles.isEmpty) {
                        return Center(
                          child: Text(
                            "No articles found.",
                            style: TextStyle(
                              color: theme.colorScheme.onBackground
                                  .withOpacity(0.6),
                              fontSize: 14.sp,
                            ),
                          ),
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: _onRefresh,
                        child: ListView.builder(
                          controller: _scrollController,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount:
                              articles.length + (_isFetchingMore ? 1 : 0),
                          itemBuilder: (context, index) {
                            if (index == articles.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            final article = articles[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: ArticleCard(article: article),
                            );
                          },
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   final _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<ArticleBloc>().add(LoadArticles());
//   }
//
//   Future<void> _onRefresh() async {
//     context.read<ArticleBloc>().add(RefreshArticlesRequested());
//   }
//
//   void _onSearch(String query) {
//     context.read<ArticleBloc>().add(SearchArticlesRequested(query: query));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       backgroundColor: theme.colorScheme.background,
//       appBar: const CustomAppBar(title: "INSYDER", centerTitle: true),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//           child: Column(
//             children: [
//               // 🔍 Search Bar
//               TextField(
//                 controller: _searchController,
//                 onChanged: _onSearch,
//                 decoration: InputDecoration(
//                   hintText: "Search articles...",
//                   prefixIcon: const Icon(Icons.search_rounded),
//                   filled: true,
//                   fillColor: theme.colorScheme.surface,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(16.r),
//                     borderSide: BorderSide.none,
//                   ),
//                   contentPadding: EdgeInsets.symmetric(vertical: 12.h),
//                 ),
//               ),
//               SizedBox(height: 12.h),
//
//               Expanded(
//                 child: BlocBuilder<ArticleBloc, BaseState<List<ArticleModel>>>(
//                   builder: (context, state) {
//                     if (state.isLoading || state.status == BaseStatus.loading) {
//                       return const Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     }
//
//                     if (state.status == BaseStatus.error) {
//                       return Center(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               state.error ?? "Something went wrong",
//                               style: TextStyle(
//                                 color: theme.colorScheme.error,
//                                 fontSize: 14.sp,
//                               ),
//                             ),
//                             SizedBox(height: 12.h),
//                             PrimaryButton(
//                               label: "Retry",
//                               onPressed: () => context
//                                   .read<ArticleBloc>()
//                                   .add(LoadArticles()),
//                             ),
//                           ],
//                         ),
//                       );
//                     }
//
//                     if (state.status == BaseStatus.success &&
//                         state.data != null) {
//                       final articles = state.data!;
//
//                       if (articles.isEmpty) {
//                         return Center(
//                           child: Text(
//                             "No articles found.",
//                             style: TextStyle(
//                               color: theme.colorScheme.onBackground
//                                   .withOpacity(0.6),
//                               fontSize: 14.sp,
//                             ),
//                           ),
//                         );
//                       }
//
//                       return RefreshIndicator(
//                         onRefresh: _onRefresh,
//                         child: ListView.builder(
//                           physics: const AlwaysScrollableScrollPhysics(),
//                           itemCount: articles.length,
//                           itemBuilder: (context, index) {
//                             final article = articles[index];
//                             return Padding(
//                               padding: EdgeInsets.only(bottom: 12.h),
//                               child: ArticleCard(article: article),
//                             );
//                           },
//                         ),
//                       );
//                     }
//
//                     // initial state or empty
//                     return const SizedBox.shrink();
//                   },
//                 ),
//               ),
//
//               // 📰 Articles Section
//               // Expanded(
//               //   child: BlocBuilder<ArticleBloc, BaseState>(
//               //     builder: (context, state) {
//               //       if (state is ArticleLoading) {
//               //         return const Center(
//               //           child: CircularProgressIndicator(),
//               //         );
//               //       } else if (state is ArticleError) {
//               //         return Center(
//               //           child: Column(
//               //             mainAxisAlignment: MainAxisAlignment.center,
//               //             children: [
//               //               Text(
//               //                 state.message,
//               //                 style: TextStyle(
//               //                   color: theme.colorScheme.error,
//               //                   fontSize: 14.sp,
//               //                 ),
//               //               ),
//               //               SizedBox(height: 12.h),
//               //               PrimaryButton(
//               //                 label: "Retry",
//               //                 onPressed: () => context
//               //                     .read<ArticleBloc>()
//               //                     .add(RefreshArticlesRequested()),
//               //               ),
//               //             ],
//               //           ),
//               //         );
//               //       } else if (state is ArticleLoaded) {
//               //         final articles = state.articles;
//               //
//               //         if (articles.isEmpty) {
//               //           return Center(
//               //             child: Text(
//               //               "No articles found.",
//               //               style: TextStyle(
//               //                 color: theme.colorScheme.onBackground
//               //                     .withOpacity(0.6),
//               //                 fontSize: 14.sp,
//               //               ),
//               //             ),
//               //           );
//               //         }
//               //
//               //         return RefreshIndicator(
//               //           onRefresh: _onRefresh,
//               //           child: ListView.builder(
//               //             physics: const AlwaysScrollableScrollPhysics(),
//               //             itemCount: articles.length,
//               //             itemBuilder: (context, index) {
//               //               final article = articles[index];
//               //               return Padding(
//               //                 padding: EdgeInsets.only(bottom: 12.h),
//               //                 child: ArticleCard(article: article),
//               //               );
//               //             },
//               //           ),
//               //         );
//               //       }
//               //
//               //       return const SizedBox.shrink();
//               //     },
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
