import 'package:act_cms/domain/model/profile_default_image.dart';
import 'package:act_cms/presentation/bottomsheet/drag_handle_bottom_sheet_layout.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class DefaultProfilePickerBottomSheet extends StatefulWidget {
  final List<ProfileDefaultImage> defaultImages;

  const DefaultProfilePickerBottomSheet({super.key, required this.defaultImages});

  static Future<int?> show(BuildContext context, List<ProfileDefaultImage> defaultImages) {
    return showModalBottomSheet<int>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return DefaultProfilePickerBottomSheet(
          defaultImages: defaultImages,
        );
      },
    );
  }

  @override
  State<DefaultProfilePickerBottomSheet> createState() => _DefaultProfilePickerBottomSheetState();
}

class _DefaultProfilePickerBottomSheetState extends State<DefaultProfilePickerBottomSheet> {
  _onSelected(ProfileDefaultImage selectedImage) {
    context.router.pop(selectedImage.id);
  }

  @override
  Widget build(BuildContext context) {
    return DragHandleBottomSheetLayout(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        Container(
          height: 120,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              ...widget.defaultImages
                  .map(
                    (e) => TextButton(
                      onPressed: () => _onSelected(e),
                      child: CachedNetworkImage(
                        imageUrl: e.url,
                        width: 85,
                        height: 85,
                        placeholder: (context, url) {
                          return CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.grey.shade100,
                          );
                        },
                        errorWidget: (context, url, _) {
                          return CircleAvatar(
                            radius: 10,
                            backgroundColor: Colors.grey.shade100,
                          );
                        },
                      ),
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
