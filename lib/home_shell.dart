import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insyder/widgets/custom_navbar.dart';
import 'core/bloc/network_bloc.dart';
import 'features/home/home_navigator.dart';
import 'features/profile/profile_navigator.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell>
    with SingleTickerProviderStateMixin {
  final GlobalKey<NavigatorState> _accountNavigatorKey =
      GlobalKey<NavigatorState>();
  int _currentIndex = 0;

  late final AnimationController _animationController;
  late final Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0, 1.5),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    if (!mounted) return;
  }

  void _onTabSelected(int index) {
    setState(() => _currentIndex = index);
    _animationController.reverse();
  }

  void _handleScroll(UserScrollNotification notification) {
    if (_currentIndex == 3) {
      if (notification.direction == ScrollDirection.forward) {
        _animationController.reverse();
      } else if (notification.direction == ScrollDirection.reverse) {
        _animationController.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SafeArea(
          top: false,
          bottom: false,
          child: Column(
            children: [
              BlocBuilder<NetworkBloc, NetworkState>(
                builder: (context, state) {
                  if (state.status == NetworkStatus.disconnected) {
                    return Container(
                      width: double.infinity,
                      color: Colors.red.shade700,
                      padding: EdgeInsets.symmetric(vertical: 8.h),
                      child: Center(
                        child: Text(
                          "No Internet Connection",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Expanded(
                child: IndexedStack(
                  index: _currentIndex,
                  children: [
                    HomeNavigatorScreen(),
                    Container(),
                    Container(),
                    ProfileNavigatorScreen(),
                    NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        _handleScroll(notification);
                        return false;
                      },
                      child: Container(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: SafeArea(
          top: false,
          child: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: _onTabSelected,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
