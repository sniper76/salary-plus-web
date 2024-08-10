import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

// void removeOverlay({required OverlayEntry? overlayEntry}) {
//   overlayEntry?.remove();
//   overlayEntry = null;
// }

OverlayEntry? createSimpleStockOverlay({
  required BuildContext context,
  required GlobalKey<State<StatefulWidget>> textFieldKey,
  required List<SimpleStock> simpleStockList,
  required void Function(int i) onListTap,
  OverlayEntry? oldOverlayEntry,
  required void Function() removeOverlay,
  double sidebarSize = 300,
}) {
  final RenderBox renderBox = textFieldKey.currentContext?.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);
  final topPosition = offset.dy + size.height + 8;
  // Remove the existing OverlayEntry.
  removeOverlay();
  // assert(oldOverlayEntry == null);
  if (simpleStockList.isEmpty) return null;

  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    // Create a new OverlayEntry.
    builder: (BuildContext context) {
      // 여기서 Positioned 위젯을 사용하여 정확한 위치를 설정합니다.
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
            top: topPosition, // 위에서 떨어진 위치
            left: offset.dx - sidebarSize, // 왼쪽에서 떨어진 위치
            width: size.width, // TextField의 가로 크기를 설정합니다.
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xffd9d9d9), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                      spreadRadius: 0, // 그림자의 범위를 설정합니다.
                      blurRadius: 11, // 흐림 정도를 설정합니다.
                      offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
                    ),
                  ]),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: simpleStockList.length,
                  itemBuilder: (context, i) {
                    // 리스트 아이템을 구축합니다.
                    return ListTile(
                      title: Row(
                        children: [
                          Text(simpleStockList[i].name),
                          const SizedBox(
                            width: 8,
                          ),
                          Text("(${simpleStockList[i].code})", style: const TextStyle(color: Color(0xff999999))),
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

  // Add the OverlayEntry to the Overlay.
  Overlay.of(context).insert(overlayEntry);
  return overlayEntry;
}

OverlayEntry? createStockGroupOverlay({
  required BuildContext context,
  required GlobalKey<State<StatefulWidget>> textFieldKey,
  required List<SimpleStockGroup> stockGroupList,
  required void Function(int i) onListTap,
  required OverlayEntry? oldOverlayEntry,
  required void Function() removeOverlay,
  double sidebarSize = 300,
}) {
  final RenderBox renderBox = textFieldKey.currentContext?.findRenderObject() as RenderBox;
  final size = renderBox.size;
  final offset = renderBox.localToGlobal(Offset.zero);
  final topPosition = offset.dy + size.height + 8;
  // Remove the existing OverlayEntry.
  removeOverlay();

  if (stockGroupList.isEmpty) return null;
  OverlayEntry? overlayEntry;

  overlayEntry = OverlayEntry(
    // Create a new OverlayEntry.
    builder: (BuildContext context) {
      // 여기서 Positioned 위젯을 사용하여 정확한 위치를 설정합니다.
      return Stack(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // 사용자가 Overlay 바깥을 탭했을 때 실행됩니다.
              removeOverlay();
            },
          ),
          Positioned(
            top: topPosition, // 위에서 떨어진 위치
            left: offset.dx - sidebarSize, // 왼쪽에서 떨어진 위치
            width: size.width, // TextField의 가로 크기를 설정합니다.
            child: Container(
              constraints: const BoxConstraints(maxHeight: 500),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: const Color(0xffd9d9d9), width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1), // 그림자의 색상과 투명도를 설정합니다.
                      spreadRadius: 0, // 그림자의 범위를 설정합니다.
                      blurRadius: 11, // 흐림 정도를 설정합니다.
                      offset: const Offset(0, 3), // x, y 축으로 그림자의 위치를 조정합니다.
                    ),
                  ]),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: stockGroupList.length,
                  itemBuilder: (context, i) {
                    // 리스트 아이템을 구축합니다.
                    return ListTile(
                      title: Text(stockGroupList[i].name),
                      onTap: () => onListTap(i),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    },
  );

  // Add the OverlayEntry to the Overlay.
  Overlay.of(context).insert(overlayEntry);
  return overlayEntry;
}
