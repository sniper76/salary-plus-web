import 'package:act_cms/presentation/widget/user_profile_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImage extends StatelessWidget {
  final String url;
  final VoidCallback? onPickerPressed;

  const ProfileImage({
    super.key,
    required this.url,
    this.onPickerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        UserProfileImage(url: url, size: 100),
        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: onPickerPressed,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300, width: 1),
              ),
              child: SvgPicture.asset(
                'assets/images/ic_camera.svg',
                height: 20,
                width: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
