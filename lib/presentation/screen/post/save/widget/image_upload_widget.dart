part of '../screen.dart';

class _ImageUploadWidget extends StatelessWidget {
  final void Function()? onTapImageUploadWidget;

  const _ImageUploadWidget({required this.onTapImageUploadWidget});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapImageUploadWidget,
      child: SvgPicture.asset(
        'assets/images/ic_camera.svg',
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(
          Colors.grey.shade700,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
