import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/domain/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:act_cms/act_cms_app.dart';

class UserProfile extends StatefulWidget {
  final User user;
  final void Function()? onLogout;
  final void Function()? onSetLocale;

  const UserProfile({
    super.key,
    required this.user,
    this.onLogout,
    this.onSetLocale,
  });

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  static TextStyle textStyle = const TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildUserProfileImage(),
        const SizedBox(width: 16),
        _buildNames(),
        const SizedBox(width: 16),
        _buildLogoutButton(),
        const SizedBox(width: 16),
        _buildLanguageButton(),
      ],
    );
  }

  Widget _buildLanguageButton() {
    return InkWell(
      onTap: widget.onSetLocale,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          AppLocalizations.of(context)!.change_language,
          style: textStyle,
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return InkWell(
      onTap: widget.onLogout,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          AppLocalizations.of(context)!.logout,
          style: textStyle,
        ),
      ),
    );
  }

  Widget _buildNames() {
    final user = widget.user;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(user.name, style: textStyle),
        Text(user.nickname ?? "", style: textStyle),
        Text(user.jobTitle ?? "", style: textStyle),
      ],
    );
  }

  Widget _buildUserProfileImage() {
    return Image.network(
      widget.user.profileImageUrl ?? defaultUserProfileImageUrl,
      width: 60,
      height: 60,
      fit: BoxFit.cover,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        return Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Color(0xffDDDDDD),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
