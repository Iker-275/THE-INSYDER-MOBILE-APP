import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:insyder/core/api/api_service.dart';

import '../../core/bloc/base_state.dart';
import '../../core/bloc/profile/profile_bloc.dart';
import '../../core/bloc/profile/profile_events.dart';
import '../../core/models/user.dart';
import '../../core/repository/author_repo.dart';

class CreateAuthorProfilePage extends StatefulWidget {
  const CreateAuthorProfilePage({super.key});

  @override
  State<CreateAuthorProfilePage> createState() =>
      _CreateAuthorProfilePageState();
}

class _CreateAuthorProfilePageState extends State<CreateAuthorProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullName = TextEditingController();
  final TextEditingController bio = TextEditingController();
  final TextEditingController tagline = TextEditingController();
  final TextEditingController facebook = TextEditingController();
  final TextEditingController instagram = TextEditingController();
  final TextEditingController twitter = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc(
        AuthorRepository(ApiService()),
      ),
      child: BlocConsumer<ProfileBloc, BaseState<UserModel>>(
        listener: (context, state) {
          if (state.status.toString().contains("success")) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Profile created successfully")),
            );
            Navigator.pop(context, true);
          }

          if (state.status.toString().contains("error")) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Create Author Profile"),
              elevation: 0,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildInput(fullName, "Full Name"),
                        const SizedBox(height: 15),
                        _buildInput(tagline, "Tagline (Short Title)"),
                        const SizedBox(height: 15),
                        _buildInput(bio, "Biography", maxLines: 4),
                        const SizedBox(height: 15),
                        const Text("Social Links",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 10),
                        _buildInput(facebook, "Facebook URL"),
                        const SizedBox(height: 10),
                        _buildInput(instagram, "Instagram URL"),
                        const SizedBox(height: 10),
                        _buildInput(twitter, "Twitter URL"),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: state.isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState!.validate()) {
                                    final data = UserModel(
                                        name: fullName.text.trim(),
                                        bio: bio.text.trim(),
                                        alias: '',
                                        id: '');

                                    context
                                        .read<ProfileBloc>()
                                        .add(CreateProfile(data));
                                  }
                                },
                          child: const Text("Create Profile"),
                        ),
                      ],
                    ),
                  ),
                ),
                if (state.isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.2),
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInput(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (v) => v == null || v.isEmpty ? "Required" : null,
    );
  }
}
