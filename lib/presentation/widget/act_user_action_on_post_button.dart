import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/domain/enum/user_action_on_post.dart';
import 'package:flutter/material.dart';

class ActUserActionOnPostButton extends StatefulWidget {
  final List<UserActionOnPost> actions;
  final Function(UserActionOnPost action)? onSelectAction;

  const ActUserActionOnPostButton({
    super.key,
    required this.actions,
    required this.onSelectAction,
  });

  @override
  State<ActUserActionOnPostButton> createState() => _ActUserActionOnPostButtonState();
}

class _ActUserActionOnPostButtonState extends State<ActUserActionOnPostButton> {
  GlobalKey<State<StatefulWidget>> buttonKey = GlobalKey();
  OverlayEntry? overlayEntry;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        overlayEntry = createUserActionOverlay(
          buttonKey: buttonKey,
          context: context,
          oldOverlayEntry: overlayEntry,
          removeOverlay: () {
            overlayEntry?.remove();
            overlayEntry = null;
          },
        );
      },
      child: Icon(
        Icons.more_vert,
        size: 20,
        key: buttonKey,
      ),
    );
  }

  OverlayEntry? createUserActionOverlay({
    required BuildContext context,
    required GlobalKey<State<StatefulWidget>> buttonKey,
    required OverlayEntry? oldOverlayEntry,
    required void Function() removeOverlay,
  }) {
    final RenderBox renderBox = buttonKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final topPosition = offset.dy + size.height;
    // Remove the existing OverlayEntry.
    removeOverlay();

    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return Material(
          type: MaterialType.transparency,
          child: Stack(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  removeOverlay();
                },
              ),
              Positioned(
                top: topPosition,
                left: offset.dx - 75.0,
                width: 90.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(),
                  ),
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: widget.actions
                        .map(
                          (action) => InkWell(
                            onTap: () {
                              if (widget.onSelectAction != null) widget.onSelectAction!(action);
                              removeOverlay();
                            },
                            child: Row(
                              children: [
                                Icon(action.icon, size: 20),
                                const SizedBox(width: 8),
                                Text(
                                  action.title,
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    Overlay.of(context).insert(overlayEntry);
    return overlayEntry;
  }
}
