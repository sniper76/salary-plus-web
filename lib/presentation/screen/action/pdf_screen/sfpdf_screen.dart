import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SfPDFScreen extends StatefulWidget {
  final String url;
  final bool dragging;
  final bool draggable;
  final void Function()? onClose;

  const SfPDFScreen({super.key, required this.url, this.dragging = false, this.draggable = false, this.onClose});

  @override
  State<SfPDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<SfPDFScreen> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final pdfController = PdfViewerController();

  @override
  void initState() {
    super.initState();
    _initializePdfController();
  }

  Future<void> _initializePdfController() async {}

  @override
  void dispose() {
    pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.amber[50],
            height: 40,
            child: Stack(
              children: [
                // if( pdfController.pageNumber == 0)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(icon: const Icon(Icons.close), onPressed: widget.onClose),
                    IconButton(
                      icon: const Icon(Icons.zoom_out),
                      onPressed: () {
                        pdfController.zoomLevel -= 0.5; // 줌 아웃
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.zoom_in),
                      onPressed: () {
                        pdfController.zoomLevel += 0.5; // 줌 아웃
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_left),
                      onPressed: () {
                        if (pdfController.pageNumber == 1) {
                          EasyLoading.showToast("첫페이지 입니다.");
                        } else {
                          pdfController.previousPage();
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.chevron_right),
                      onPressed: () {
                        if (pdfController.pageNumber == pdfController.pageCount) {
                          EasyLoading.showToast("마지막 페이지 입니다.");
                        } else {
                          pdfController.nextPage();
                        }
                        // _pdfViewerKey.currentState?.openBookmarkView();
                      },
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "* 마우스 왼쪽 버튼 드래그 : 텍스트 선택",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 9),
                        ),
                        const Text(
                          "* 마우스 오른쪽 버튼 드래그 : 화면이동 (Zoom상태)",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 9),
                        ),
                        if (widget.draggable)
                          const Text(
                            "* 상단바(노란영역) 잡고 마우스 드래그 : 창 이동",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 9),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height - 240,
            width: 1000,
            child: widget.dragging
                ? Container()
                : SfPdfViewer.network(
                    widget.url,
                    key: _pdfViewerKey,
                    controller: pdfController,
                  ),
          )

          // Center(
          //     child: Text(
          //   "PDF Viewer",
          //   style: TextStyle(
          //       color: Colors.grey[400],
          //       fontSize: 32,
          //       fontWeight: FontWeight.bold),
          // )),
        ],
      ),
    );
  }
}
