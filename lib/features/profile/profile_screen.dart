import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insyder/app_router.dart';

import '../../core/bloc/base_state.dart';
import '../../core/bloc/profile/profile_bloc.dart';
import '../../core/bloc/profile/profile_events.dart';
import '../../core/models/user.dart';
import '../../core/utils/secure_storage.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/custom_buttons.dart';
import '../../widgets/custom_textfields.dart';
import '../../widgets/shimmer_loaders.dart';

// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final _nameController = TextEditingController();
//   final _bioController = TextEditingController();
//   final _emailController = TextEditingController();
//
//   bool _isAuthor = false;
//   bool _isEditing = false;
//
//   @override
//   void initState() {
//     super.initState();
//     context.read<ProfileBloc>().add(LoadProfile());
//   }
//
//   void _fillControllers(UserModel user) {
//     _nameController.text = user.name ?? "";
//     _emailController.text = user.name ?? "";
//     _bioController.text = user.bio ?? "";
//     _isAuthor = user.isAuthor == true;
//   }
//
//   void _onSave() {
//     if (!_isAuthor) return;
//
//     final data = {
//       "name": _nameController.text.trim(),
//       "bio": _bioController.text.trim(),
//     };
//
//     context.read<ProfileBloc>().add(UpdateProfile(data));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//
//     return Scaffold(
//       appBar: const CustomAppBar(title: "Profile", centerTitle: false),
//       body: SafeArea(
//         child: BlocConsumer<ProfileBloc, BaseState<UserModel>>(
//           listener: (context, state) {
//             if (state.status == BaseStatus.success && !_isEditing) {
//               _fillControllers(state.data!);
//             }
//
//             if (state.status == BaseStatus.error) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.error ?? "Error occurred")),
//               );
//             }
//
//             if (state.status == BaseStatus.success && _isEditing) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 const SnackBar(content: Text("Profile updated successfully")),
//               );
//               setState(() => _isEditing = false);
//             }
//           },
//           builder: (context, state) {
//             if (state.isLoading || state.status == BaseStatus.loading) {
//               return const ProfileShimmer();
//             }
//
//             if (state.status == BaseStatus.error) {
//               return Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(state.error ?? "Something went wrong"),
//                     SizedBox(height: 12.h),
//                     PrimaryButton(
//                       label: "Retry",
//                       onPressed: () =>
//                           context.read<ProfileBloc>().add(LoadProfile()),
//                     ),
//                   ],
//                 ),
//               );
//             }
//
//             if (state.status == BaseStatus.success && state.data != null) {
//               final user = state.data!;
//               return _buildProfileContent(context, user, theme, state);
//             }
//
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileContent(BuildContext context, UserModel user,
//       ThemeData theme, BaseState<UserModel> state) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
//       child: Column(
//         children: [
//           SizedBox(height: 20.h),
//
//           /// Profile avatar placeholder
//           CircleAvatar(
//             radius: 45.r,
//             backgroundColor: theme.colorScheme.primary.withOpacity(0.2),
//             child: Icon(
//               Icons.person,
//               size: 50.sp,
//               color: theme.colorScheme.primary,
//             ),
//           ),
//           SizedBox(height: 20.h),
//
//           /// Name
//           InputField(
//             label: "Full Name",
//             controller: _nameController,
//             enabled: _isAuthor,
//           ),
//           SizedBox(height: 12.h),
//
//           /// Email (always read-only)
//           InputField(
//             label: "Email",
//             controller: _emailController,
//             enabled: false,
//           ),
//           SizedBox(height: 12.h),
//
//           /// Bio only for authors
//           if (_isAuthor)
//             InputField(
//               label: "Bio",
//               maxLines: 3,
//               controller: _bioController,
//               enabled: true,
//             ),
//
//           const Spacer(),
//
//           /// Save button for authors
//           if (_isAuthor)
//             PrimaryButton(
//               label: state.isLoading ? "Updating..." : "Save Changes",
//               onPressed: state.isLoading ? () {} : _onSave,
//             ),
//
//           if (!_isAuthor)
//             Text(
//               "Standard User — no editing privileges",
//               style: TextStyle(
//                 color: theme.colorScheme.onBackground.withOpacity(0.7),
//                 fontSize: 13.sp,
//               ),
//             ),
//
//           SizedBox(height: 12.h),
//
//           /// Logout
//           TextButton(
//             onPressed: () {
//               // Navigate to login page after clearing token
//               // (assuming you already have logout in AuthBloc)
//               Navigator.pushReplacementNamed(context, "/login");
//             },
//             child: Text(
//               "Logout",
//               style: TextStyle(
//                 fontSize: 15.sp,
//                 color: theme.colorScheme.error,
//               ),
//             ),
//           ),
//
//           SizedBox(height: 10.h),
//         ],
//       ),
//     );
//   }
// }

///
///
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  Future<void> _loadUserId() async {
    userId = await SecureStorageService.getUserId();
    if (userId != null) {
      context.read<ProfileBloc>().add(LoadProfile());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: const CustomAppBar(title: "Profile", centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
          child: BlocBuilder<ProfileBloc, BaseState<UserModel?>>(
            builder: (context, state) {
              final user = state.data;

              // ──────────────────────────────────────────────────────
              // 🟦 DEFAULT PROFILE UI (works for all users)
              // ──────────────────────────────────────────────────────
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Avatar
                  CircleAvatar(
                    radius: 40.r,
                    backgroundColor: theme.colorScheme.surface,
                    child: Icon(Icons.person, size: 40.sp),
                  ),
                  SizedBox(height: 16.h),

                  // Name (Author only)
                  Text(
                    user?.name ?? "INSYDER User",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onBackground,
                    ),
                  ),

                  Text(
                    user?.name ?? "",
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: theme.colorScheme.onBackground.withOpacity(0.6),
                    ),
                  ),

                  SizedBox(height: 25.h),

                  // ──────────────────────────────────────────────────────
                  // 🟦 Author or Non-Author
                  // ──────────────────────────────────────────────────────
                  if (user?.isAuthor == true) ...[
                    // Create Article Button
                    PrimaryButton(
                      label: "Create Article",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.createProfile);
                      },
                    ),
                    SizedBox(height: 12.h),

                    // Edit Profile Button
                    PrimaryButton(
                      label: "Edit Profile",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.updateProfile);
                      },
                    ),
                  ] else ...[
                    // Message for normal users
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        "Author features are only available to authors.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ),
                    SizedBox(height: 18.h),

                    // Create Author Profile Button
                    PrimaryButton(
                      label: "Create Author Profile",
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.createProfile);
                      },
                    ),
                  ],
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
