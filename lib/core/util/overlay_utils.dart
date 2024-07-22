import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class OverlayUtils {
  static OverlayEntry? createBaseStockOverlayForTextField({
    required BuildContext context,
    required GlobalKey textFieldKey,
    required List<BaseStock> baseStockList,
    required void Function(int i) onListTap,
    OverlayEntry? oldOverlayEntry,
    required void Function() removeOverlay,
  }) {
    if (textFieldKey.currentContext == null) return null;
    final RenderBox renderBox = textFieldKey.currentContext?.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);
    final topPosition = offset.dy + size.height + 4;

    removeOverlay();

    if (baseStockList.isEmpty) return null;

    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (BuildContext context) {
        return PointerInterceptor(
            child: Stack(
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                removeOverlay();
                return;
              },
            ),
            Positioned(
              top: topPosition,
              left: offset.dx,
              width: size.width,
              child: Container(
                constraints: const BoxConstraints(maxHeight: 500),
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: const Color(0xffd9d9d9), width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 0,
                        blurRadius: 11,
                        offset: const Offset(0, 3),
                      ),
                    ]),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: baseStockList.length,
                    itemBuilder: (context, i) {
                      // 리스트 아이템을 구축합니다.
                      return ListTile(
                        title: Row(
                          children: [
                            Text('${baseStockList[i].name}(${baseStockList[i].code})'),
                          ],
                        ),
                        onTap: () => onListTap(i),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ));
      },
    );

    Overlay.of(context).insert(overlayEntry);
    return overlayEntry;
  }
}
