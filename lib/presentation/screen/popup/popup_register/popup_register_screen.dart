import 'dart:async';
import 'dart:html' as html;
import 'dart:html';

import 'package:act_cms/config/constants.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/enum/popup/popup_display_target_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_link_type.dart';
import 'package:act_cms/domain/model/enum/popup/popup_stock_target_type.dart';
import 'package:act_cms/domain/model/popup.dart';
import 'package:act_cms/domain/usecase/admin_images/upload_image.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/popup/popup_register/bloc/bloc.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/widget/custom_html_editor.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

@RoutePage()
class PopupRegisterScreen extends StatefulWidget {
  final Popup? updatePopup;

  const PopupRegisterScreen({super.key, this.updatePopup});

  @override
  State<PopupRegisterScreen> createState() => _PopupState();
}

class _PopupState extends State<PopupRegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _controllerTarget = TextEditingController();
  final TextEditingController _controllerLinkTitle = TextEditingController();
  final TextEditingController _controllerLinkUrl = TextEditingController();
  final TextEditingController _controllerTitle = TextEditingController();
  final HtmlEditorController _htmlEditorController = HtmlEditorController();
  final _uploadImage = getIt<UploadImage>();
  StreamSubscription<PopStateEvent>? _popStateSubscription;

  OverlayEntry? overlayEntry;
  final textFieldTargetKey = GlobalKey();
  final linkTitleFieldTargetKey = GlobalKey();
  final linkPostIdFieldTargetKey = GlobalKey();

  List<FocusNode>? listItemFocusNodes;
  static const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  DateTime? _startedAt;

  static const gap = 24.0;

  void _registerPopStateListener() {
    _popStateSubscription = html.window.onPopState.listen((event) {
      Navigator.of(context).pop(); // 여기에 원하는 데이터를 넣어 반환합니다.
    });
  }

  _onPickerDateTime(
      {required PopupState state, required String text, required Function cb, DateTime? startDate}) async {
    final selectedDate = await showDatePicker(
      context: context,
      builder: (ctx, child) => PointerInterceptor(child: child!),
      helpText: '$text일',
      initialDate: startDate ?? _startedAt,
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );

    TimeOfDay initialTime = state.targetStartDatetime != null
        ? TimeOfDay(hour: state.targetStartDatetime!.hour, minute: state.targetStartDatetime!.minute)
        : TimeOfDay.now();

    if (selectedDate != null && mounted) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        builder: (ctx, child) => PointerInterceptor(child: child!),
        helpText: '$text 시간',
        initialEntryMode: TimePickerEntryMode.input,
        initialTime: initialTime,
      );

      if (selectedTime != null) {
        final newDate = selectedDate.copyWith(hour: selectedTime.hour, minute: selectedTime.minute, second: 00);
        cb(newDate);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _registerPopStateListener();
    _startedAt = DateTime.now();
    if (widget.updatePopup != null) {
      _controllerTitle.text = widget.updatePopup!.title;
      _controllerLinkTitle.text = widget.updatePopup?.linkTitle ?? '';
      _controllerLinkUrl.text = widget.updatePopup?.postId.toString() ?? '';
      _controllerTarget.text = widget.updatePopup?.stockName ?? widget.updatePopup?.stockGroupName ?? '';
    }
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    removeOverlay();
    _popStateSubscription?.cancel();
    super.dispose();
  }

  onComplete() {
    var commandTitle = getCommandTitle();

    context
        .showAlertDialog(
      title: "팝업 $commandTitle",
      message: "팝업이 $commandTitle되었습니다.",
    )
        .then((value) {
      Navigator.of(context).pop(true);
    });
  }

  String getCommandTitle() {
    return widget.updatePopup == null ? "생성" : "수정";
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PopupBloc, PopupState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PopupBloc()
        ..add(
          PopupEvent.init(widget.updatePopup),
        ),
      listener: (context, state) {
        if (state.isComplete) onComplete();
      },
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildMainScreen(context, bloc, state);
      },
    );
  }

  String formatPhoneNumber(String rawNumber) {
    // 숫자만 포함된 문자열을 기대합니다.
    if (rawNumber.length == 11) {
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 7)}-${rawNumber.substring(7, 11)}';
    } else if (rawNumber.length == 10) {
      // 일부 번호는 10자리일 수 있습니다.
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 6)}-${rawNumber.substring(6, 10)}';
    }
    return rawNumber; // 다른 길이의 번호는 수정하지 않고 반환합니다.
  }

  String formatAssetAmount(int? amount) {
    if (amount == null) {
      return "-";
    }
    final numberFormat = NumberFormat('#,###', 'ko_KR');
    return numberFormat.format(amount);
  }

  // Remove the OverlayEntry.
  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  Widget _buildMainScreen(BuildContext context, PopupBloc bloc, PopupState state) {
    var commandTitle = getCommandTitle();

    return BlocListener<PopupBloc, PopupState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: MainAppBar(mainTitle: "팝업 $commandTitle", context: context),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(32.0),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Column(
              children: [
                _buildSelectTarget(context, bloc, state),
                const SizedBox(height: gap),
                _buildLink(context, bloc, state),
                const SizedBox(height: gap),
                _buildTitle(context, bloc, state),
                const SizedBox(height: gap),
                _buildContent(context, bloc, state),
                const SizedBox(height: gap),
                _buildDateTime(context, bloc, state),
                ElevatedButton(
                  onPressed: () async {
                    final html = await _htmlEditorController.getText();
                    final stockGroupId = state.selectedStockGroupId;
                    final stockCode = state.selectedStockCode;

                    bloc.add(
                      PopupEvent.savePopup(
                        title: _controllerTitle.text,
                        targetStartDatetime: state.targetStartDatetime ?? DateTime.now(),
                        targetEndDatetime: state.targetEndDatetime ?? DateTime.now(),
                        displayTargetType: state.displayTargetType,
                        stockCode: stockCode,
                        stockGroupId: stockGroupId,
                        stockTargetType: state.targetStockType,
                        content: html,
                        linkType: state.targetLinkType,
                        linkTitle: _controllerLinkTitle.text,
                        postId: _controllerLinkUrl.text,
                        popupId: widget.updatePopup?.id,
                      ),
                    );
                  },
                  child: Container(
                      width: 100,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(commandTitle)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSelectTarget(BuildContext context, PopupBloc bloc, PopupState state) {
    return (BlocListener<PopupBloc, PopupState>(
        listener: (context, state) {},
        child: Row(children: [
          const SizedBox(
            width: 60,
            child: Text(
              "타겟",
              style: titleStyle,
            ),
          ),
          BlocListener<PopupBloc, PopupState>(
              listenWhen: (previousState, currentState) =>
                  previousState.targetCandidateStockList != currentState.targetCandidateStockList,
              listener: (context, state) {
                overlayEntry = createSimpleStockOverlay(
                  context: context,
                  textFieldKey: textFieldTargetKey,
                  simpleStockList: state.targetCandidateStockList,
                  onListTap: (int i) {
                    _controllerTarget.text = state.targetCandidateStockList[i].name;
                    bloc.add(PopupEvent.setStock(state.targetCandidateStockList[i].code));
                    removeOverlay();
                  },
                  oldOverlayEntry: overlayEntry,
                  removeOverlay: () {
                    overlayEntry?.remove();
                    overlayEntry = null;
                  },
                  sidebarSize: 300,
                );
              },
              child: const SizedBox(width: 32)),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            // flex: 2, // Giving more width to dropdown
            width: 200,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PopupDisplayTargetType>(
                focusColor: Colors.white,
                padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                value: state.displayTargetType,
                hint: const Text('카테고리 선택'),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (PopupDisplayTargetType? newValue) {
                  if (newValue != null) {
                    bloc.add(PopupEvent.setTargetDisplayType(newValue));
                  }
                },
                items: [
                  PopupDisplayTargetType.main_home,
                  PopupDisplayTargetType.stock_home,
                  PopupDisplayTargetType.news_home
                ].map<DropdownMenuItem<PopupDisplayTargetType>>((PopupDisplayTargetType value) {
                  return DropdownMenuItem<PopupDisplayTargetType>(
                    value: value,
                    child: Text(
                      value.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  );
                }).toList(),
                isExpanded: true, // Making dropdown expand fully in its space
              ),
            ),
          ),
          BlocListener<PopupBloc, PopupState>(
              listenWhen: (previousState, currentState) =>
                  previousState.targetCandidateStockGroupList != currentState.targetCandidateStockGroupList,
              listener: (context, state) {
                overlayEntry = createStockGroupOverlay(
                  context: context,
                  textFieldKey: textFieldTargetKey,
                  stockGroupList: state.targetCandidateStockGroupList,
                  onListTap: (int i) {
                    _controllerTarget.text = state.targetCandidateStockGroupList[i].name;
                    bloc.add(PopupEvent.setStockGroup(state.targetCandidateStockGroupList[i].id));
                    removeOverlay();
                  },
                  oldOverlayEntry: overlayEntry,
                  removeOverlay: () {
                    overlayEntry?.remove();
                    overlayEntry = null;
                  },
                  sidebarSize: 300,
                );
              },
              child: const SizedBox(width: 32)),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            // flex: 2, // Giving more width to dropdown
            width: 200,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PopupStockTargetType>(
                focusColor: Colors.white,
                padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                value: state.targetStockType,
                hint: const Text('카테고리 선택'),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (PopupStockTargetType? newValue) {
                  if (newValue != null) {
                    _controllerTarget.text = "";
                    bloc.add(PopupEvent.setTargetStockType(newValue));
                  }
                },
                items: [
                  PopupStockTargetType.all,
                  PopupStockTargetType.stock,
                  PopupStockTargetType.stock_group,
                ].map<DropdownMenuItem<PopupStockTargetType>>((PopupStockTargetType value) {
                  return DropdownMenuItem<PopupStockTargetType>(
                    value: value,
                    child: Text(
                      value.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  );
                }).toList(),
                isExpanded: true, // Making dropdown expand fully in its space
              ),
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            // Flexible 위젯을 사용해 TextField가 Row의 대부분을 차지하도록 함
            child: TextField(
              key: textFieldTargetKey,
              controller: _controllerTarget,
              readOnly: state.targetStockType == PopupStockTargetType.all,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                ),
              ),
              onChanged: (value) {
                bloc.add(PopupEvent.searchKeyword(value));
              },
            ),
          ),
        ])));
  }

  Widget _buildLink(BuildContext context, PopupBloc bloc, PopupState state) {
    return (BlocListener<PopupBloc, PopupState>(
        listener: (context, state) {},
        child: Row(children: [
          const SizedBox(
            width: 60,
            child: Text(
              "링크",
              style: titleStyle,
            ),
          ),
          BlocListener<PopupBloc, PopupState>(listener: (context, state) {}, child: const SizedBox(width: 32)),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            // flex: 2, // Giving more width to dropdown
            width: 200,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<PopupLinkType>(
                focusColor: Colors.white,
                padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                value: state.targetLinkType,
                hint: const Text('카테고리 선택'),
                icon: const Icon(Icons.keyboard_arrow_down),
                onChanged: (PopupLinkType? newValue) {
                  if (newValue != null) {
                    bloc.add(PopupEvent.setTargetLinkType(newValue));
                  }
                },
                items: PopupLinkType.values.map<DropdownMenuItem<PopupLinkType>>((PopupLinkType value) {
                  return DropdownMenuItem<PopupLinkType>(
                    value: value,
                    child: Text(
                      value.title,
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  );
                }).toList(),
                isExpanded: true, // Making dropdown expand fully in its space
              ),
            ),
          ),
          const SizedBox(width: 32),
          if (state.targetLinkType == PopupLinkType.link)
            Expanded(
              child: TextField(
                key: linkTitleFieldTargetKey,
                controller: _controllerLinkTitle,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                  labelText: 'TITLE',
                ),
              ),
            ),
          const SizedBox(width: 32),
          if (state.targetLinkType == PopupLinkType.link)
            Expanded(
              child: TextField(
                key: linkPostIdFieldTargetKey,
                controller: _controllerLinkUrl,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                  labelText: '게시글 ID',
                ),
              ),
            )
        ])));
  }

  Widget _buildDateTime(BuildContext context, PopupBloc bloc, PopupState state) {
    return (BlocListener<PopupBloc, PopupState>(
      listener: (context, state) {},
      child: Row(
        children: [
          const SizedBox(
            width: 60,
            child: Text(
              "생성기간",
              style: titleStyle,
            ),
          ),
          SvgPicture.asset(
            'assets/images/ic_calendar.svg',
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  _onPickerDateTime(
                      state: state,
                      text: '시작',
                      cb: (DateTime newDate) {
                        bloc.add(PopupEvent.setStartDatetime(newDate));
                      });
                },
                child: Text(
                  state.targetStartDatetime?.toFormatString(pattern: dateTimeFormatPattern) ??
                      DateTime.now().toFormatString(pattern: dateTimeFormatPattern),
                ),
              ),
              const Text('~'),
              TextButton(
                onPressed: () {
                  _onPickerDateTime(
                    state: state,
                    text: '종료',
                    cb: (DateTime newDate) {
                      bloc.add(PopupEvent.setEndDatetime(newDate));
                    },
                    startDate: state.targetStartDatetime,
                  );
                },
                child: Text(
                  state.targetEndDatetime?.toFormatString(pattern: dateTimeFormatPattern) ??
                      DateTime.now().toFormatString(pattern: dateTimeFormatPattern),
                ),
              )
            ],
          )
        ],
      ),
    ));
  }

  Widget _buildTitle(BuildContext context, PopupBloc bloc, PopupState state) {
    return (BlocListener<PopupBloc, PopupState>(
        listener: (context, state) {},
        child: Row(children: [
          const SizedBox(
            width: 60,
            child: Text(
              "제목",
              style: titleStyle,
            ),
          ),
          BlocListener<PopupBloc, PopupState>(
            listener: (context, state) {},
            child: const SizedBox(width: 32),
          ),
          Expanded(
            // Flexible 위젯을 사용해 TextField가 Row의 대부분을 차지하도록 함
            child: TextField(
              controller: _controllerTitle,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                ),
              ),
            ),
          ),
        ])));
  }

  Widget _buildContent(BuildContext context, PopupBloc bloc, PopupState state) {
    return BlocListener<PopupBloc, PopupState>(
      listener: (context, state) {},
      child: Row(
        children: [
          const SizedBox(
            width: 60,
            child: Text(
              "내용입력",
              style: titleStyle,
            ),
          ),
          BlocListener<PopupBloc, PopupState>(
            listener: (context, state) {},
            child: const SizedBox(width: 32),
          ),
          CustomHtmlEditor(
            controller: _htmlEditorController,
            initialText: widget.updatePopup?.content,
            uploadImage: _uploadImage,
            height: 300,
          ),
        ],
      ),
    );
  }
}
