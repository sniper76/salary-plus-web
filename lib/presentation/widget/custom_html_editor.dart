import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker_web/image_picker_web.dart';

class CustomHtmlEditor extends StatelessWidget {
  late HtmlEditorController controller;
  late String? initialText;
  late Function? uploadImage;
  double height;

  CustomHtmlEditor({
    super.key,
    required this.controller,
    this.initialText,
    this.uploadImage,
    this.height = 500,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minHeight: 48,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xffD9D9D9)),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: SingleChildScrollView(
          child: HtmlEditor(
            controller: controller,
            htmlEditorOptions:
                HtmlEditorOptions(autoAdjustHeight: false, hint: 'Your text here...', initialText: initialText),
            htmlToolbarOptions: HtmlToolbarOptions(
              toolbarPosition: ToolbarPosition.aboveEditor,
              toolbarType: ToolbarType.nativeGrid,
              onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) async {
                if (uploadImage == null || ButtonType.picture != type) {
                  return true;
                }

                final bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                final res = await uploadImage!(file: List<int>.from(bytesFromPicker!));
                if (res.isSuccess()) {
                  final result = res.tryGetSuccess();
                  if (result != null) {
                    controller.insertNetworkImage(result.url);
                  }
                }
                return false;
              },
              onDropdownChanged: (DropdownType type, dynamic changed, Function(dynamic)? updateSelectedItem) {
                return true;
              },
              mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                return true;
              },
            ),
            otherOptions: OtherOptions(height: height),
            callbacks: Callbacks(
              onBeforeCommand: (String? currentHtml) {},
              onChangeContent: (String? changed) {},
              onChangeCodeview: (String? changed) {},
              onChangeSelection: (EditorSettings settings) {},
              onDialogShown: () {},
              onEnter: () {},
              onFocus: () {
                FocusScope.of(context).unfocus();
                controller.setFocus();
              },
              onBlur: () {
                controller.clearFocus();
              },
              onBlurCodeview: () {},
              onInit: () {},
              onImageUploadError: (FileUpload? file, String? base64Str, UploadError error) {
                if (file != null) {}
              },
              onKeyDown: (int? keyCode) {},
              onKeyUp: (int? keyCode) {},
              onMouseDown: () {},
              onMouseUp: () {},
              onNavigationRequestMobile: (String url) {
                return NavigationActionPolicy.ALLOW;
              },
              onPaste: () {},
              onScroll: () {},
            ),
          ),
        ),
      ),
    );
  }
}
