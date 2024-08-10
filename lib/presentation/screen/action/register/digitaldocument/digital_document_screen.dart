import 'dart:math';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/digital_document_admin.dart';
import 'package:act_cms/domain/model/digital_document_item.dart';
import 'package:act_cms/domain/model/enum/action_document_shareholderetting_type.dart';
import 'package:act_cms/domain/model/enum/action_post_type.dart';
import 'package:act_cms/domain/model/enum/board_category.dart';
import 'package:act_cms/domain/model/enum/digital_document_answer_type.dart';
import 'package:act_cms/domain/model/enum/digital_document_type.dart';
import 'package:act_cms/domain/model/enum/option_type.dart';
import 'package:act_cms/domain/model/enum/id_card_watermark_type.dart';
import 'package:act_cms/domain/model/enum/stock_quantity_display_type.dart';
import 'package:act_cms/domain/model/json_attach_options.dart';
import 'package:act_cms/domain/model/stock_reference_date.dart';
import 'package:act_cms/domain/usecase/admin_images/upload_image.dart';
import 'package:act_cms/presentation/screen/action/register/bloc/bloc.dart';
import 'package:act_cms/presentation/util/date_ui_helper.dart';
import 'package:act_cms/presentation/widget/button/act_delete_button.dart';
import 'package:act_cms/presentation/widget/multi_buttons.dart';
import 'package:act_cms/presentation/widget/notification_checkbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';


class PollInputItem {
  final String value;
  late final TextEditingController textController;

  PollInputItem({this.value = ''}) {
    textController = TextEditingController();
    textController.text = value;
  }

  addTextControllerListener(VoidCallback listener) {
    textController.addListener(listener);
  }
}

class DigitalDocumentScreen extends StatefulWidget {
  final BuildContext parentContext;
  final PostBloc bloc;
  final PostState state;
  final void Function({double? newX, double? newY}) createPDFOverlay;
  final void Function() removeDPFOverlay;
  final OverlayEntry? overlayPDF;

  const DigitalDocumentScreen(
      {super.key,
      required this.parentContext,
      required this.bloc,
      required this.state,
      this.overlayPDF,
      required this.createPDFOverlay,
      required this.removeDPFOverlay});

  @override
  State<DigitalDocumentScreen> createState() => _PostState();
}

class _PostState extends State<DigitalDocumentScreen> {
  DateTime? _startedAt;
  final HtmlEditorController controller = HtmlEditorController();
  final TextEditingController _controllerDocumentContent = TextEditingController();
  final TextEditingController _controllerEtcTitle = TextEditingController();
  final HtmlEditorController _controllerEtcHtml = HtmlEditorController();
  final textFieldSourceKey = GlobalKey();
  final textFieldTargetKey = GlobalKey();
  final textFieldKey = GlobalKey();
  static const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  bool _isNotification = false;

  final _companyRegistrationNumber = TextEditingController();

  final TextEditingController colorController = TextEditingController();

  ShareholderMeetingType _delegationMeetingType = ShareholderMeetingType.regular;

  final _textDelegationCompanyName = TextEditingController();
  final _textDelegationAgent = TextEditingController();
  final _textDelegationMeetingTitle = TextEditingController();

  DateTime? _endedAt;
  DateTime? _shareholderMeetingAt;

  OptionType idCardImage = OptionType.required;
  IdCardWatermarkType idCardWatermarkType = IdCardWatermarkType.actLogo;
  StockQuantityDisplayType stockQuantityDisplayType = StockQuantityDisplayType.no;
  OptionType bankAccountImage = OptionType.required;
  OptionType hectoEncryptedBankAccountPdf = OptionType.required;
  List<DigitalDocumentItem> digitalDocumentItemList = [
    DigitalDocumentItem(id: 0, title: "", content: "", defaultSelectValue: DigitalDocumentAnswerType.approval)
  ];
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final _uploadImage = getIt<UploadImage>();

  @override
  void initState() {
    super.initState();
    setState(() {
      _startedAt = roundToNearestFiveMinutes(DateTime.now());
    });
  }

  @override
  void dispose() {
    super.dispose();
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return _buildPostRegisterScreen(widget.parentContext, widget.bloc, widget.state);
  }

  Widget _buildPostRegisterScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      bloc: bloc,
      listener: (context, state) {
        if (state.isPreviewOn && widget.overlayPDF == null) {
          widget.createPDFOverlay();
        } else if (!state.isPreviewOn && widget.overlayPDF != null) {
          widget.removeDPFOverlay();
        }
      },
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
        child: Align(
            alignment: Alignment.topCenter,
            child: Stack(
              children: [
                Column(
                  children: [
                    _buildPostContentEditScreen(context, bloc, state, controller),
                    const SizedBox(height: 16),
                    _buildDigitalDocument(context, bloc, state),
                    const SizedBox(height: 16),
                    NotificationCheckBox(
                      onChange: (newState) {
                        setState(() {
                          _isNotification = !newState;
                          bloc.add(PostEvent.setIsNotification(newState));
                        });
                      },
                      isChecked: _isNotification,
                    ),
                    if (state.selectedDigitalDocumentCategory.value == DigitalDocumentType.etc.value)
                      _buildSubmitButtonEtc(context, bloc, state),
                    if (state.selectedDigitalDocumentCategory.value == DigitalDocumentType.digitalProxy.value ||
                        state.selectedDigitalDocumentCategory.value == DigitalDocumentType.newDigitalProxy.value)
                      _buildSubmitButtonDelegate(context, bloc, state),
                    if (state.selectedDigitalDocumentCategory.value == DigitalDocumentType.jointOwnership.value)
                      _buildSubmitButtonCoArrangement(context, bloc, state),
                  ],
                ),
              ],
            )),
      ),
    );
  }

  onPreviewCoArrangement(BuildContext context, PostBloc bloc, PostState state) {}

  DigitalDocumentItem createRandomDigitalDocumentItem(int depth) {
    if (depth <= 0) {
      return DigitalDocumentItem(
        id: Random().nextInt(1000),
        title: 'Title ${Random().nextInt(100)}',
        content: 'Content ${Random().nextInt(100)}',
      );
    } else {
      return DigitalDocumentItem(
        id: Random().nextInt(1000),
        title: 'Title ${Random().nextInt(100)}',
        content: 'Content ${Random().nextInt(100)}',
        childItems: List.generate(
          Random().nextInt(5),
          (_) => createRandomDigitalDocumentItem(depth - 1),
        ),
      );
    }
  }

  Widget _buildSubmitButtonDelegate(BuildContext context, PostBloc bloc, PostState state) {
    return Column(children: [
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              if (_textDelegationMeetingTitle.text.isEmpty) {
                EasyLoading.showToast('주총명을 입력해주세오');
                return;
              }
              if (_shareholderMeetingAt == null) {
                EasyLoading.showToast('주총일을 입력해주세요');
                return;
              }
              if (_textDelegationAgent.text.isEmpty) {
                EasyLoading.showToast('수임인 지정 대리인을 입력해주세요');
                return;
              }
              bloc.add(PostEvent.setActionPreview(
                isPreviewOn: state.isPreviewOn ? false : true,
                type: "DIGITAL_PROXY",
                shareholderMeetingType: _delegationMeetingType.value,
                shareholderMeetingName: _textDelegationMeetingTitle.text,
                shareholderMeetingDate: _shareholderMeetingAt,
                designatedAgentNames: _textDelegationAgent.text,
                digitalDocumentList: digitalDocumentItemList,
                companyName: _textDelegationCompanyName.text,
                acceptUserId: state.stockDetail?.acceptUser?.id,
              ));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff869DF2)),
            child: Container(
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: state.isPreviewOn ? const Text('미리보기해지') : const Text('미리보기')),
          ),
          const SizedBox(width: 24),
          ElevatedButton(
            onPressed: () async {
              String content = await controller.getText();
              if (state.stockCode == null) {
                EasyLoading.showToast('종목을 선택해주세요');
                return;
              }
              if (state.title == null || state.title!.isEmpty) {
                EasyLoading.showToast('제목을 입력해주세요');
                return;
              }
              if (_endedAt == null) {
                EasyLoading.showToast('종료일을 입력해주세요');
                return;
              }
              if (content == "") {
                EasyLoading.showToast('내용을 입력해주세요');
                return;
              }

              if (_endedAt == null) {
                EasyLoading.showToast('종료일을 입력해주세요');
                return;
              }
              if (_shareholderMeetingAt == null) {
                EasyLoading.showToast('주총일을 입력해주세요');
                return;
              }

              if (state.selectedReferenceDay == null) {
                EasyLoading.showToast('기준일이 선택되지 않았습니다');
                return;
              }

              final result = DigitalDocumentAdmin(
                  type: DigitalDocumentType.digitalProxy.value,
                  companyName: _textDelegationCompanyName.text,
                  acceptUserId: state.stockDetail?.acceptUser?.id ?? 1,
                  shareholderMeetingType: _delegationMeetingType.value,
                  shareholderMeetingName: _textDelegationMeetingTitle.text,
                  shareholderMeetingDate: _shareholderMeetingAt,
                  designatedAgentNames: _textDelegationAgent.text,
                  stockReferenceDateId: state.selectedReferenceDay?.id,
                  targetStartDate: _startedAt,
                  targetEndDate: _endedAt,
                  title: state.title ?? '',
                  content: _controllerDocumentContent.text,
                  companyRegistrationNumber: _companyRegistrationNumber.text,
                  childItems: digitalDocumentItemList,
                  version: state.selectedDigitalDocumentCategory.version,
                  idCardWatermarkType: idCardWatermarkType,
                  isDisplayStockQuantity: stockQuantityDisplayType == StockQuantityDisplayType.yes,
                  attachOptions: JsonAttachOptions(
                      signImage: OptionType.required,
                      idCardImage: idCardImage,
                      bankAccountImage: bankAccountImage,
                      hectoEncryptedBankAccountPdf: hectoEncryptedBankAccountPdf));
              bloc.add(PostEvent.actionSave(
                title: state.title ?? '',
                content: content,
                digitalDocument: result,
                isAnonymous: true,
                isNotification: _isNotification,
                boardGroupCategory: BoardGroupCategory(
                    displayName: BoardCategoryType.digitalDelegation.title, name: "DIGITAL_DELEGATION"),
              ));
            },
            child: Container(
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text('등록')),
          )
        ],
      )
    ]);
  }

  Widget _buildSubmitButtonEtc(BuildContext context, PostBloc bloc, PostState state) {
    return Column(children: [
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              String content = await _controllerEtcHtml.getText();
              if (_controllerEtcTitle.text.isEmpty) {
                EasyLoading.showToast('제목을 입력해주세요');
                return;
              }
              if (_endedAt == null) {
                EasyLoading.showToast('종료일을 입력해주세요');
                return;
              }
              if (content == "") {
                EasyLoading.showToast('내용을 입력해주세요');
                return;
              }
              bloc.add(PostEvent.setActionPreview(
                isPreviewOn: state.isPreviewOn ? false : true,
                type: "ETC_DOCUMENT",
                title: _controllerEtcTitle.text,
                content: content,
                companyName: state.stockGroup?.name,
              ));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff869DF2)),
            child: Container(
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: state.isPreviewOn ? const Text('미리보기해지') : const Text('미리보기')),
          ),
          const SizedBox(width: 24),
          ElevatedButton(
            onPressed: () async {
              String content = await controller.getText();
              if (state.postType!.isCampaign && state.stockGroup == null) {
                EasyLoading.showToast('종목그룹을 선택해주세요');
                return;
              }

              if (state.postType!.isAction && state.stockCode == null) {
                EasyLoading.showToast('종목을 선택해주세요');
                return;
              }
              if (state.title == null || state.title!.isEmpty) {
                EasyLoading.showToast('제목을 입력해주세요');
                return;
              }
              if (_endedAt == null) {
                EasyLoading.showToast('종료일을 입력해주세요');
                return;
              }
              if (content == "") {
                EasyLoading.showToast('내용을 입력해주세요');
                return;
              }
              final digitalDoc = await _controllerEtcHtml.getText();
              final companyName = state.postType!.isAction ? state.stockCode?.name : state.stockGroup?.name;
              final result = DigitalDocumentAdmin(
                  type: DigitalDocumentType.etc.value,
                  companyName: companyName ?? '',
                  acceptUserId: state.user?.id ?? 0,
                  stockReferenceDateId: 1,
                  targetStartDate: _startedAt,
                  targetEndDate: _endedAt,
                  title: _controllerEtcTitle.text,
                  content: digitalDoc,
                  idCardWatermarkType: idCardWatermarkType,
                  isDisplayStockQuantity: stockQuantityDisplayType == StockQuantityDisplayType.yes,
                  version: state.selectedDigitalDocumentCategory.version,
                  attachOptions: JsonAttachOptions(
                      signImage: OptionType.required,
                      idCardImage: idCardImage,
                      bankAccountImage: bankAccountImage,
                      hectoEncryptedBankAccountPdf: hectoEncryptedBankAccountPdf));

              if (state.postType!.isCampaign) {
                bloc.add(PostEvent.campaignSave(
                  title: state.title ?? '',
                  content: content,
                  digitalDocument: result,
                  isAnonymous: true,
                  boardGroupCategory: const BoardGroupCategory(displayName: "기타", name: "ETC"),
                  isNotification: _isNotification,
                ));
              } else {
                bloc.add(PostEvent.actionSave(
                  title: state.title ?? '',
                  content: content,
                  digitalDocument: result,
                  isAnonymous: true,
                  isNotification: _isNotification,
                  boardGroupCategory: const BoardGroupCategory(displayName: "기타", name: "ETC"),
                ));
              }
            },
            child: Container(
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text('등록')),
          )
        ],
      )
    ]);
  }

  Widget _buildSubmitButtonCoArrangement(BuildContext context, PostBloc bloc, PostState state) {
    return Column(children: [
      const SizedBox(height: 16),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              if (state.stockCode == null) {
                EasyLoading.showToast('종목을 선택해주세요');
                return;
              }
              if (state.title == null || state.title!.isEmpty) {
                EasyLoading.showToast('제목을 입력해주세요');
                return;
              }
              if (_endedAt == null) {
                EasyLoading.showToast('종료일을 입력해주세요');
                return;
              }
              if (_controllerDocumentContent.text == "") {
                EasyLoading.showToast('내용을 입력해주세요');
                return;
              }
              if (_companyRegistrationNumber.text.isEmpty) {
                EasyLoading.showToast('법인등록번호를 입력해주세요.');
                return;
              }

              bloc.add(PostEvent.setActionPreview(
                  isPreviewOn: state.isPreviewOn ? false : true,
                  type: "JOINT_OWNERSHIP_DOCUMENT",
                  designatedAgentNames: _textDelegationAgent.text,
                  companyRegistrationNumber: _companyRegistrationNumber.text,
                  content: _controllerDocumentContent.text,
                  acceptUserId: state.stockDetail?.acceptUser?.id,
                  companyName: _textDelegationCompanyName.text));
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff869DF2)),
            child: Container(
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: state.isPreviewOn ? const Text('미리보기해지') : const Text('미리보기')),
          ),
          const SizedBox(width: 24),
          ElevatedButton(
            onPressed: () async {
              String content = await controller.getText();
              if (state.stockCode == null) {
                EasyLoading.showToast('종목을 선택해주세요');
                return;
              }
              if (state.title == null || state.title!.isEmpty) {
                EasyLoading.showToast('제목을 입력해주세요');
                return;
              }
              if (_endedAt == null) {
                EasyLoading.showToast('종료일을 입력해주세요');
                return;
              }
              if (content == "") {
                EasyLoading.showToast('내용을 입력해주세요');
                return;
              }
              final result = DigitalDocumentAdmin(
                type: DigitalDocumentType.jointOwnership.value,
                companyName: state.stockCode?.name ?? "",
                acceptUserId: state.stockDetail?.acceptUser?.id ?? 0,
                stockReferenceDateId: 1,
                targetStartDate: _startedAt,
                targetEndDate: _endedAt,
                title: state.title ?? '',
                content: _controllerDocumentContent.text,
                companyRegistrationNumber: _companyRegistrationNumber.text,
                version: state.selectedDigitalDocumentCategory.version,
                idCardWatermarkType: idCardWatermarkType,
                isDisplayStockQuantity: stockQuantityDisplayType == StockQuantityDisplayType.yes,
                attachOptions: JsonAttachOptions(
                  signImage: OptionType.required,
                  idCardImage: idCardImage,
                  bankAccountImage: bankAccountImage,
                  hectoEncryptedBankAccountPdf: hectoEncryptedBankAccountPdf,
                ),
              );
              bloc.add(PostEvent.actionSave(
                title: state.title ?? '',
                content: content,
                digitalDocument: result,
                isAnonymous: true,
                isNotification: _isNotification,
                boardGroupCategory: BoardGroupCategory.coArrangement(),
              ));
            },
            child: Container(
                width: 150,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: const Text('등록')),
          )
        ],
      )
    ]);
  }

  Widget _buildPostContentEditScreen(
      BuildContext context, PostBloc bloc, PostState state, HtmlEditorController controller) {
    return Row(
      children: [
        _buildTitle("내용"),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffD9D9D9)),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: HtmlEditor(
              controller: controller,
              htmlEditorOptions: const HtmlEditorOptions(
                autoAdjustHeight: true,
                hint: 'Your text here...',
              ),
              htmlToolbarOptions: HtmlToolbarOptions(
                toolbarPosition: ToolbarPosition.aboveEditor,
                toolbarType: ToolbarType.nativeGrid,
                onButtonPressed: (ButtonType type, bool? status, Function? updateStatus) async {
                  if (ButtonType.picture == type) {
                    final bytesFromPicker = await ImagePickerWeb.getImageAsBytes();
                    final res = await _uploadImage(file: List<int>.from(bytesFromPicker!));
                    if (res.isSuccess()) {
                      final result = res.tryGetSuccess();
                      if (result != null) {
                        controller.insertNetworkImage(result.url);
                      }
                    }
                    return false;
                  }
                  return true;
                },
                onDropdownChanged: (DropdownType type, dynamic changed, Function(dynamic)? updateSelectedItem) {
                  return true;
                },
                mediaLinkInsertInterceptor: (String url, InsertFileType type) {
                  return true;
                },
              ),
              otherOptions: const OtherOptions(height: 500),
              callbacks: Callbacks(
                onImageUploadError: (FileUpload? file, String? base64Str, UploadError error) {
                  if (file != null) {}
                },
                onNavigationRequestMobile: (String url) {
                  return NavigationActionPolicy.ALLOW;
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitalDocumentTypeList(BuildContext context, PostBloc bloc, PostState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          width: 160,
          child: Text(
            "종류",
            style: titleStyle,
          ),
        ),
        ...DigitalDocumentType.getDigitalDocumentType(state.postType!)
            .map(
              (item) => _buildFilterButton(context, bloc, state, item.title,
                  state.selectedDigitalDocumentCategory == item, const Color(0xff2A4ABA), () {
                if (state.selectedDigitalDocumentCategory != item) {
                  bloc.add(const PostEvent.setActionPreview(isPreviewOn: false));
                  bloc.add(PostEvent.setDigitalDocumentCategory(item));
                }
              }),
            )
            .toList(),
      ],
    );
  }

  DateTime roundToNearestFiveMinutes(DateTime dateTime) {
    int minutes = dateTime.minute;
    int roundedMinutes = (minutes / 5).round() * 5;
    return DateTime(dateTime.year, dateTime.month, dateTime.day, dateTime.hour, roundedMinutes, 0);
  }

  Future<void> onPickerStartedDateTime(BuildContext context, PostBloc bloc, PostState state) async {
    final ret = await showDatePicker(
      builder: (ctx, child) => PointerInterceptor(child: child!),
      context: context,
      initialDate: _startedAt ?? roundToNearestFiveMinutes(DateTime.now()),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );

    if (ret != null) {
      final timeRet = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(hour: DateTime.now().add(const Duration(hours: 1)).hour, minute: 0),
        initialEntryMode: TimePickerEntryMode.dialOnly,
      );
      if (timeRet != null) {
        setState(() {
          _startedAt = ret.copyWith(hour: timeRet.hour, minute: timeRet.minute, second: 00);
        });
      }
    }
  }

  Future<void> onPickerShareHolderMeetingDateTime(BuildContext context, PostBloc bloc, PostState state) async {
    final ret = await showDatePicker(
      context: context,
      helpText: "주총일 선택",
      initialDate: _endedAt ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );

    if (ret != null) {
      setState(() {
        _shareholderMeetingAt = ret;
      });
    }
  }

  Future<void> onPickerDateTimeReferenceDay(BuildContext context, PostBloc bloc, PostState state) async {
    final ret = await showDatePicker(
      context: context,
      helpText: "기준일 등록",
      initialDate: state.selectedReferenceDay?.referenceDate ?? DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime(DateTime.now().year - 2, 1, 1),
      lastDate: DateTime(DateTime.now().year + 3, 12, 31),
    );

    if (ret != null) {
      bloc.add(PostEvent.createReferenceDates(date: ret));
    }
  }

  _onPickerEndedDate() async {
    DateTime? changedEndDateTime = await DateUiHelper.selectDateTime(context, DateTime.now());

    if (changedEndDateTime == null) {
      return;
    }
    setState(() {
      _endedAt = changedEndDateTime;
    });
  }

  Widget _buildDigitalDocument(BuildContext context, PostBloc bloc, PostState state) {
    return Row(
      children: [
        _buildTitle("전자문서"),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xffD9D9D9)),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("시작일",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(
                          (_startedAt == null) ? "" : _startedAt?.toFormatString(pattern: dateTimeFormatPattern2) ?? '',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        onPickerStartedDateTime(context, bloc, state);
                      },
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/images/ic_calendar.svg',
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const SizedBox(
                      width: 100,
                      child: Text("종료일",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    SizedBox(
                      width: 150,
                      child: Text(_endedAt == null ? "-" : _endedAt!.toFormatString(pattern: dateTimeFormatPattern2),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                    InkWell(
                      onTap: _onPickerEndedDate,
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: SvgPicture.asset(
                          'assets/images/ic_calendar.svg',
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  children: [

                    MultiButtons<OptionType>(
                      title: '신분증사본',
                      buttonList: OptionType.values.toList(),
                      onSelectionChanged: (OptionType selectedOption) {
                        idCardImage = selectedOption;
                      },
                      getTitle: (option) => option.title,
                      labelSize: 130,
                    ),
                    const SizedBox(width: 16.0),
                    MultiButtons<IdCardWatermarkType>(
                      title: '워터마크',
                      buttonList: IdCardWatermarkType.values.toList(),
                      onSelectionChanged: (IdCardWatermarkType selectedOption) {
                        idCardWatermarkType = selectedOption;
                      },
                      getTitle: (option) => option.title,
                      labelSize: 100,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                MultiButtons<OptionType>(
                  title: '잔고증명서(헥토)',
                  buttonList: OptionType.values.toList(),
                  onSelectionChanged: (OptionType selectedOption) {
                    hectoEncryptedBankAccountPdf = selectedOption;
                  },
                  getTitle: (option) => option.title,
                  labelSize: 130,
                ),
                const SizedBox(height: 16),
                MultiButtons<OptionType>(
                  title: '잔고증명서',
                  buttonList: OptionType.values.toList(),
                  onSelectionChanged: (OptionType selectedOption) {
                    bankAccountImage = selectedOption;
                  },
                  getTitle: (option) => option.title,
                  labelSize: 130,
                ),const SizedBox(height: 16),
                MultiButtons<StockQuantityDisplayType>(
                  title: '보유주식수 표시',
                  buttonList: StockQuantityDisplayType.values.toList(),
                  onSelectionChanged: (StockQuantityDisplayType selectedOption) {
                    stockQuantityDisplayType = selectedOption;
                  },
                  getTitle: (option) => option.title,
                  labelSize: 130,
                ),
                const SizedBox(height: 16),
                _buildDigitalDocumentTypeList(context, bloc, state),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: _buildDottedLine(),
                ),
                if (state.selectedDigitalDocumentCategory.value == DigitalDocumentType.etc.value)
                  _buildDigitalDocumentEtc(context, bloc, state),
                if (state.selectedDigitalDocumentCategory.value == DigitalDocumentType.digitalProxy.value ||
                    state.selectedDigitalDocumentCategory.value == DigitalDocumentType.newDigitalProxy.value)
                  _buildDigitalDocumentDelegate(context, bloc, state),
                if (state.selectedDigitalDocumentCategory.value == DigitalDocumentType.jointOwnership.value)
                  _buildDigitalDocumentCoArrangement(context, bloc, state)
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDigitalDocumentDelegate(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      listenWhen: (previous, current) => (previous.stockCode != current.stockCode),
      listener: (context, state) {
        _textDelegationCompanyName.text = state.stockCode?.name ?? "";
      },
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 160,
                  child: Text(
                    "주총선택",
                    style: titleStyle,
                  ),
                ),
                ...[ShareholderMeetingType.regular, ShareholderMeetingType.extraordinary]
                    .map(
                      (item) => _buildFilterButton(
                          context, bloc, state, item.title, _delegationMeetingType == item, const Color(0xff2A4ABA),
                          () {
                        setState(() {
                          _delegationMeetingType = item;
                        });
                      }),
                    )
                    .toList(),
              ],
            ),
            const SizedBox(height: 16),
            (_delegationMeetingType == ShareholderMeetingType.regular)
                ? Row(
                    children: [
                      const SizedBox(
                        width: 160,
                        child: Text("기준일",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Expanded(
                        child: state.selectedReferenceDay != null
                            ? Text(
                                state.selectedReferenceDay!.referenceDate.toFormatString(),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              )
                            : const Text("-", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 160,
                        child: Text(
                          "기준일",
                          style: titleStyle,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        width: 200,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<StockReferenceDate>(
                            focusColor: Colors.white,
                            padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                            value: state.selectedReferenceDay,
                            hint: const Text('기준일 선택'),
                            icon: const Icon(Icons.keyboard_arrow_down),
                            onChanged: (StockReferenceDate? newValue) {
                              bloc.add(PostEvent.setReferenceDay(day: newValue!));
                            },
                            items: state.stockReferenceDateList
                                .map<DropdownMenuItem<StockReferenceDate>>((StockReferenceDate value) {
                              return DropdownMenuItem<StockReferenceDate>(
                                value: value,
                                child: Text(
                                  value.referenceDate.toFormatString(),
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                  ),
                                ),
                              );
                            }).toList(),
                            isExpanded: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      InkWell(
                        onTap: () {
                          onPickerDateTimeReferenceDay(context, bloc, state);
                        },
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: SvgPicture.asset(
                            'assets/images/ic_calendar.svg',
                          ),
                        ),
                      )
                    ],
                  ),
            const SizedBox(height: 24),
            Row(
              children: [
                const SizedBox(
                  width: 160,
                  child: Text("주총일",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  width: 140,
                  child: Text((_shareholderMeetingAt == null) ? "-" : _shareholderMeetingAt!.toFormatString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                InkWell(
                  onTap: () {
                    onPickerShareHolderMeetingDateTime(context, bloc, state);
                  },
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: SvgPicture.asset(
                      'assets/images/ic_calendar.svg',
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const SizedBox(
                  width: 160,
                  child: Text("수임인 정보",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Expanded(
                  child: state.stockDetail?.acceptUser?.name != null && state.stockDetail?.acceptUser?.birthDate != null
                      ? Text(
                          "${state.stockDetail?.acceptUser?.name} - ${state.stockDetail!.acceptUser!.birthDate.toFormatString()}",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                      : Text(state.stockDetail?.acceptUser?.name ?? "-",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: 600,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
              child: (Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      const SizedBox(
                        width: 142,
                        child: Text('회사명', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: TextField(
                            controller: _textDelegationCompanyName,
                            decoration: const InputDecoration(hintText: '회사명을 입력하세요.')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 142,
                        child: Text('주총명칭', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: TextField(
                            controller: _textDelegationMeetingTitle,
                            decoration: const InputDecoration(hintText: '주총명칭을 입력해주세요.')),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const SizedBox(
                        width: 142,
                        child: Text('수임인 지정 대리인', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Expanded(
                        child: TextField(
                            controller: _textDelegationAgent,
                            decoration: const InputDecoration(hintText: '이름을 입력해주세요.')),
                      ),
                    ],
                  ),
                ],
              )),
            ),
            const SizedBox(
              height: 24,
            ),
            const SizedBox(
              width: 160,
              child: Text(
                "안건추가",
                style: titleStyle,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                ...digitalDocumentItemList
                    .asMap()
                    .entries
                    .map((item) => _widgetAgenda(item.value, (item.key + 1).toString(), () {
                          digitalDocumentItemList.removeAt(item.key);
                          setState(() {
                            digitalDocumentItemList = digitalDocumentItemList;
                          });
                        }))
                    .toList()
              ],
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  digitalDocumentItemList.add(DigitalDocumentItem(
                      id: 0, title: "", content: "", defaultSelectValue: DigitalDocumentAnswerType.approval));
                  setState(() {
                    digitalDocumentItemList = digitalDocumentItemList;
                  });
                },
                child: Text(
                  '+ 새 안건 추가',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _widgetAgenda(DigitalDocumentItem item, String idx, void Function() deleteItem) {
    return (Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 365,
              child: Row(
                children: [
                  Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      constraints: const BoxConstraints(minWidth: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: const Color(0xffD9D9D9), borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        idx,
                        style: const TextStyle(fontSize: 10),
                      )),
                  Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: const Text(
                        "구분",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  Expanded(
                    child: TextField(
                      onChanged: (value) {
                        item.title = value;
                      },
                      decoration: InputDecoration(
                        hintText: "구분을 입력하세요.",
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: const BorderSide(color: Color(0xff999999)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: const Column(
                  children: [
                    Text(
                      "주주총회",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "목적사항",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                )),
            Expanded(
              child: TextField(
                onChanged: (value) {
                  item.content = value;
                },
                decoration: InputDecoration(
                  hintText: "주주총회 목적을 입력하세요.",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(color: Color(0xff999999)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: () {
                item.childItems ??= [];

                item.childItems!.add(DigitalDocumentItem(
                  id: 1,
                  title: "",
                  content: "",
                  childItems: [],
                  defaultSelectValue: item.defaultSelectValue,
                ));
                setState(() {
                  digitalDocumentItemList = digitalDocumentItemList;
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text("+ 하위 항목 추가"),
              ),
            ),
            const SizedBox(width: 16),
            ActDeleteButton(
              onPressed: deleteItem,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: AppTheme.primaryColor),
              titleWidget: const Padding(padding: EdgeInsets.all(12.0), child: Text("삭제")),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        if (item.childItems != null)
          ...item.childItems!.asMap().entries.map(
                (e) => _widgetAgenda(e.value, "$idx-${e.key + 1}", () {
                  item.childItems!.removeAt(e.key);
                  setState(() {
                    digitalDocumentItemList = digitalDocumentItemList;
                  });
                }),
              ),
        if ((item.childItems?.length ?? 0) == 0)
          Row(
            children: [
              SizedBox(
                width: 365,
                child: Row(
                  children: [
                    const SizedBox(width: 30),
                    Expanded(
                      child: MultiButtons<DigitalDocumentAnswerType>(
                        title: '연대추천',
                        buttonList: DigitalDocumentAnswerType.values.toList(),
                        onSelectionChanged: (DigitalDocumentAnswerType selectedOption) {
                          item.defaultSelectValue = selectedOption;
                        },
                        getTitle: (option) => option.title,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text(
                    "대표설명",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    item.leaderDescription = value;
                  },
                  decoration: InputDecoration(
                    hintText: "대표 설명을 입력하세요.",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0),
                      borderSide: const BorderSide(color: Color(0xff999999)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        const SizedBox(
          height: 16,
        ),
      ],
    ));
  }

  Widget _buildDigitalDocumentEtc(BuildContext context, PostBloc bloc, PostState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _buildTitle("제목"),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: _controllerEtcTitle,
                decoration: InputDecoration(
                  hintText: "문서 제목을 입력하세요.",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0xff999999)),
                  ),
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 24,
        ),
        _buildPostContentEditScreen(context, bloc, state, _controllerEtcHtml),
      ],
    );
  }

  Widget _buildDigitalDocumentCoArrangement(BuildContext context, PostBloc bloc, PostState state) {
    return Align(
      alignment: Alignment.topLeft,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 160,
                child: Text("수임인 정보",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Expanded(
                child: state.stockDetail?.acceptUser?.name != null && state.stockDetail?.acceptUser?.birthDate != null
                    ? Text(
                        "${state.stockDetail?.acceptUser?.name} - ${state.stockDetail!.acceptUser!.birthDate.toFormatString()}",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                    : Text(state.stockDetail?.acceptUser?.name ?? "-",
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: 600,
            padding: const EdgeInsets.all(16),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
            child: (Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: [
                    const SizedBox(
                      width: 142,
                      child: Text('회사명', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: TextField(
                          controller: _textDelegationCompanyName,
                          decoration: const InputDecoration(hintText: '회사명을 입력하세요.')),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    const SizedBox(
                      width: 142,
                      child: Text('법인등록번호', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: TextField(
                          controller: _companyRegistrationNumber,
                          decoration: const InputDecoration(hintText: '법인등록번호를 입력하세요.')),
                    ),
                  ],
                ),
              ],
            )),
          ),
          const SizedBox(height: 24),
          TextField(
            controller: _controllerDocumentContent,
            maxLines: 4,
            maxLength: 1000,
            decoration: const InputDecoration(
              labelText: '공동보유 내용',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffd9d9d9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xffd9d9d9)),
              ),
            ),
            keyboardType: TextInputType.multiline,
          )
        ],
      ),
    );
  }

  Widget _buildFilterButton(
    BuildContext context,
    PostBloc bloc,
    PostState state,
    String text,
    bool isSelected,
    Color mainColor,
    void Function() onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
            foregroundColor: isSelected ? mainColor : const Color(0xffD9D9D9),
            side: BorderSide(
              color: isSelected ? mainColor : const Color(0xffD9D9D9),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            )),
        child: Container(alignment: Alignment.center, width: 90, height: 40, child: Text(text)),
      ),
    );
  }

  Widget _buildTitle(String title) {
    return SizedBox(
      width: 80,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: titleStyle,
      ),
    );
  }

  Widget _buildDottedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth,
          height: 1.0,
          child: CustomPaint(
            painter: DottedLinePainter(),
          ),
        );
      },
    );
  }
}

class DottedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xffd9d9d9)
      ..strokeWidth = 1;

    const double dashWidth = 4.0;
    const double dashSpace = 4.0;
    double startX = 0.0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
