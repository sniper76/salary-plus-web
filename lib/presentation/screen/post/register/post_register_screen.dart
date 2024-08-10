import 'dart:async';
import 'dart:html';

import 'package:act_cms/config/app_event.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/injection.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/board_group_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/simple_stock_group.dart';
import 'package:act_cms/domain/model/stock.dart';
import 'package:act_cms/domain/usecase/admin_images/upload_image.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/post/common/post_simple_stock_overlay.dart';
import 'package:act_cms/presentation/screen/post/register/bloc/bloc.dart';
import 'package:act_cms/presentation/util/date_ui_helper.dart';
import 'package:act_cms/presentation/widget/act_campaign_title_input.dart';
import 'package:act_cms/presentation/widget/act_field_container.dart';
import 'package:act_cms/presentation/widget/custom_html_editor.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/notification_checkbox.dart';
import 'package:auto_route/auto_route.dart';
import 'package:event_bus_plus/res/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:intl/intl.dart';

@RoutePage()
class PostRegisterScreen extends StatefulWidget {
  final BoardGroupType boardGroupType;
  final Post? updatePost;
  final Stock? updateStock;
  final SimpleStockGroup? updateStockGroup;
  final String? campaignTitle;

  const PostRegisterScreen({
    super.key,
    required this.boardGroupType,
    this.updatePost,
    this.updateStock,
    this.updateStockGroup,
    this.campaignTitle,
  });

  @override
  State<PostRegisterScreen> createState() => _PostState();
}

class _PostState extends State<PostRegisterScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controllerTitle = TextEditingController();
  final TextEditingController _controllerStock = TextEditingController();
  final TextEditingController _controllerCampaignTitle = TextEditingController();
  final HtmlEditorController controller = HtmlEditorController();
  final _textFieldStockKey = GlobalKey();
  late StreamSubscription _postItemChangeEventSubscription;
  final _eventBus = getIt<IEventBus>();
  late bool _isNotification;

  OverlayEntry? overlayEntry;
  final textFieldKey = GlobalKey();
  List<FocusNode>? listItemFocusNodes;
  static const TextStyle titleStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const TextStyle titleStyle4Period = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  final _uploadImage = getIt<UploadImage>();
  StreamSubscription<PopStateEvent>? _popStateSubscription;

  late final String commandTitle;

  void _registerPopStateListener() {
    _popStateSubscription = window.onPopState.listen((event) {
      Navigator.of(context).pop(); // 여기에 원하는 데이터를 넣어 반환합니다.
    });
  }

  @override
  void initState() {
    super.initState();
    _isNotification = widget.updatePost?.isNotification ?? false;
    _postItemChangeEventSubscription = _eventBus.on<PageChangedEvent>().listen((e) {
      Navigator.of(context).pop(456);
    });

    if (widget.updatePost != null) {
      _controllerTitle.text = widget.updatePost?.title ?? "";
      _controllerStock.text = widget.updateStock?.name ?? widget.updateStockGroup?.name ?? "";
      if (widget.campaignTitle != null) {
        _controllerCampaignTitle.text = widget.campaignTitle ?? '';
      }
    }
    _registerPopStateListener();

    commandTitle = getCommandTitle();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    removeOverlay();
    _popStateSubscription?.cancel();
    _controllerTitle.dispose();
    _controllerStock.dispose();
    _controllerCampaignTitle.dispose();
    controller.disable();
    super.dispose();
  }

  Future<void> selectDateTime(BuildContext context, PostBloc bloc, DateTime? initialDateTime) async {
    DateTime? changedDateTime = await DateUiHelper.selectDateTime(context, initialDateTime?.toLocal());
    if (changedDateTime == null) {
      return;
    }

    bloc.add(PostEvent.setTargetDate(changedDateTime));
  }

  String getCommandTitle() {
    return widget.updatePost == null ? "등록" : "수정";
  }

  void removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PostBloc, PostState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => PostBloc(
        boardGroupType: widget.boardGroupType,
        updatePost: widget.updatePost,
        updateStock: widget.updateStock,
        updateStockGroup: widget.updateStockGroup,
        campaignTitle: widget.campaignTitle,
      )..add(
          const PostEvent.init(),
        ),
      listener: (context, state) {
        if (state.isComplete) {
          onComplete();
        }
      },
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }

        return _buildPostRegisterScreen(context, bloc, state);
      },
    );
  }

  String formatPhoneNumber(String rawNumber) {
    if (rawNumber.length == 11) {
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 7)}-${rawNumber.substring(7, 11)}';
    } else if (rawNumber.length == 10) {
      return '${rawNumber.substring(0, 3)}-${rawNumber.substring(3, 6)}-${rawNumber.substring(6, 10)}';
    }
    return rawNumber;
  }

  String formatAssetAmount(int? amount) {
    if (amount == null) {
      return "-";
    } else if (amount >= 10000) {
      final numberFormat = NumberFormat('#,###', 'ko_KR');

      final formattedAmount = numberFormat.format(amount ~/ 10000);
      return '$formattedAmount만원';
    } else {
      final numberFormat = NumberFormat('#,###', 'ko_KR');
      return '${numberFormat.format(amount)}원';
    }
  }

  onComplete() async {
    final result = await context.showAlertDialog(title: "게시글 $commandTitle", message: "게시글이 $commandTitle되었습니다.");
    if (result) {
      if (!context.mounted) return;
      context.router.pop(true);
    }
  }

  Widget _buildPostRegisterScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
      listener: (context, state) {},
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: MainAppBar(mainTitle: "게시글 $commandTitle", context: context),
        body: SingleChildScrollView(
          child: Container(
            width: 1200,
            margin: const EdgeInsets.all(24.0),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Align(
                alignment: Alignment.topCenter,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.campaignTitle != null) ...[
                      ActCampaignTitleInput(
                        onChanged: (String value) => bloc.add(PostEvent.setCampaignTitle(value)),
                        controllerCampaignTitle: _controllerCampaignTitle,
                      ),
                      const SizedBox(height: 16)
                    ],
                    if (widget.boardGroupType != BoardGroupType.globalboard) ...[
                      _buildPostStockSelectScreen(context, bloc, state),
                      const SizedBox(height: 16),
                    ],
                    _buildPostTypeSelectScreen(context, bloc, state),
                    const SizedBox(height: 16),
                    _buildIsActiveSelectBox(state, bloc),
                    const SizedBox(height: 16),
                    _buildIsExclusiveToUserSelectBox(state, bloc),
                    const SizedBox(height: 16),
                    if (widget.boardGroupType == BoardGroupType.action) ...[
                      _buildPostPeriod(context, bloc, state),
                      const SizedBox(height: 16.0)
                    ],
                    _buildPostTitleScreen(context, bloc, state),
                    const SizedBox(height: 16),
                    _buildPostContentEditScreen(context, bloc, state),
                    const SizedBox(height: 16),
                    BlocListener<PostBloc, PostState>(
                        listener: (context, state) {},
                        child: Column(
                          children: [
                            const SizedBox(width: 32),
                            NotificationCheckBox(
                              onChange: (newState) {
                                setState(() {
                                  _isNotification = !newState;
                                });
                              },
                              isChecked: _isNotification,
                            ),
                            const SizedBox(width: 32),
                            ElevatedButton(
                              onPressed: () async {
                                String content = await controller.getText();
                                if (widget.updateStockGroup != null) {
                                  bloc.add(PostEvent.updateCampaign(
                                      title: state.title ?? "",
                                      content: content,
                                      isActive: state.isActive,
                                      isNotification: _isNotification));
                                } else {
                                  bloc.add(PostEvent.save(
                                      title: state.title ?? "",
                                      content: content,
                                      isActive: state.isActive,
                                      isNotification: _isNotification));
                                }
                              },
                              child: Container(
                                  width: 100,
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Text(commandTitle)),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPostStockSelectScreen(BuildContext context, PostBloc bloc, PostState state) {
    return BlocListener<PostBloc, PostState>(
        listenWhen: (previousState, currentState) {
          return (previousState.candiatedStockList != currentState.candiatedStockList) ||
              (previousState.candidateStockGroupList != currentState.candidateStockGroupList);
        },
        listener: (context, state) {
          overlayEntry = isStock
              ? _buildStockList(bloc, state.candiatedStockList)
              : _buildStockGroupList(bloc, state.candidateStockGroupList);
        },
        child: ActFieldContainer(
          title: stockText,
          children: [
            Expanded(
              child: TextField(
                key: _textFieldStockKey,
                controller: _controllerStock,
                readOnly: widget.updatePost != null,
                enabled: !(widget.updatePost != null),
                decoration: InputDecoration(
                  label: Text(state.stockCode?.name ?? ""),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: Color(0xffD9D9D9)),
                  ),
                ),
                onChanged: (value) {
                  bloc.add(PostEvent.searchStock(stockSearchKeyword: value, isStockGroup: !isStock));
                },
                onSubmitted: (value) {
                  if (isStock) {
                    bloc.add(PostEvent.selectStock(state.candiatedStockList[0]));
                  } else {
                    bloc.add(PostEvent.selectStockGroup(state.candidateStockGroupList[0]));
                  }
                  overlayEntry?.remove();
                  overlayEntry = null;
                  _controllerStock.text = state.candiatedStockList[0].name;
                },
              ),
            ),
            const SizedBox(width: 8),
          ],
        ));
  }

  Widget _buildPostTypeSelectScreen(BuildContext context, PostBloc bloc, PostState state) {
    return ActFieldContainer(
      title: "게시판",
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: widget.updatePost != null
                ? Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                    child: Text(
                      widget.updatePost?.boardGroupCategory?.displayName ?? "",
                      style: const TextStyle(fontSize: 16),
                    ),
                  )
                : DropdownButtonHideUnderline(
                    child: DropdownButton<BoardGroupCategory>(
                      focusColor: Colors.white,
                      padding: const EdgeInsets.only(left: 24.0, right: 16.0),
                      value: state.selectedBoardGroupCategory,
                      hint: const Text('선택'),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onChanged: (BoardGroupCategory? newValue) {
                        bloc.add(PostEvent.changedCategory(newValue!));
                      },
                      items:
                          state.boardCategoryList.map<DropdownMenuItem<BoardGroupCategory>>((BoardGroupCategory value) {
                        return DropdownMenuItem<BoardGroupCategory>(
                          value: value,
                          child: Text(
                            value.displayName,
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildIsActiveSelectBox(PostState state, PostBloc bloc) {
    return ActFieldContainer(
      title: "노출/미노출",
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 200,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              focusColor: Colors.white,
              padding: const EdgeInsets.only(left: 24.0, right: 16.0),
              value: state.isActive ? "노출" : "미노출",
              hint: const Text('선택'),
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: (String? newValue) {
                bloc.add(PostEvent.setIsActive(newValue == "노출"));
              },
              items: ["노출", "미노출"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
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
      ],
    );
  }

  Widget _buildIsExclusiveToUserSelectBox(PostState state, PostBloc bloc) {
    return ActFieldContainer(
      title: "주주만 공개",
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
          ),
          width: 200,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              focusColor: Colors.white,
              padding: const EdgeInsets.only(left: 24.0, right: 16.0),
              value: state.isExclusiveToHolders ? "주주만 공개" : "전부 공개",
              hint: const Text('선택'),
              icon: const Icon(Icons.keyboard_arrow_down),
              onChanged: (String? newValue) {
                bloc.add(PostEvent.setIsExclusiveToUsers(newValue == "주주만 공개"));
              },
              items: ["주주만 공개", "전부 공개"].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
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
      ],
    );
  }

  Widget _buildPostPeriod(BuildContext context, PostBloc bloc, PostState state) {
    final DateTime? targetStartDate = state.updatedPost?.polls?.firstOrNull?.targetStartDate ??
        state.updatedPost?.digitalDocument?.targetStartDate ??
        state.updatedPost?.digitalProxy?.targetStartDate;
    final DateTime? targetEndDate =
        state.pollTargetDate ?? state.digitalProxyTargetDate ?? state.digitalDocumentTargetDate;

    return ActFieldContainer(
      title: '기간',
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              const Text("시작일", style: titleStyle4Period),
              const SizedBox(width: 16),
              Text(targetStartDate == null ? '-' : targetStartDate.toFormatString(pattern: 'yyyy-MM-dd HH:mm'),
                  style: titleStyle4Period),
            ],
          ),
          Row(
            children: [
              const Text("종료일", style: titleStyle4Period),
              const SizedBox(width: 16),
              Text(targetEndDate == null ? '-' : targetEndDate.toFormatString(pattern: 'yyyy-MM-dd HH:mm'),
                  style: titleStyle4Period),
              const SizedBox(width: 16),
              InkWell(
                onTap: () async {
                  await selectDateTime(context, bloc, targetEndDate);
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
        ])
      ],
    );
  }

  Widget _buildPostTitleScreen(BuildContext context, PostBloc bloc, PostState state) {
    return ActFieldContainer(
      title: "제목",
      children: [
        Expanded(
          child: TextField(
            controller: _controllerTitle,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
              ),
            ),
            onChanged: (value) {
              bloc.add(PostEvent.setTitle(value));
            },
          ),
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildPostContentEditScreen(BuildContext context, PostBloc bloc, PostState state) {
    return ActFieldContainer(title: "내용", children: [
      CustomHtmlEditor(controller: controller, initialText: widget.updatePost?.content, uploadImage: _uploadImage),
    ]);
  }

  OverlayEntry? _buildStockList(PostBloc bloc, List<SimpleStock> candiatedStockList) {
    return createSimpleStockOverlay(
      context: context,
      textFieldKey: _textFieldStockKey,
      simpleStockList: candiatedStockList,
      onListTap: (i) {
        bloc.add(PostEvent.selectStock(candiatedStockList[i]));
        removeOverlay();
        _controllerStock.text = candiatedStockList[i].name;
      },
      oldOverlayEntry: overlayEntry,
      removeOverlay: removeOverlay,
      sidebarSize: 300,
    );
  }

  OverlayEntry? _buildStockGroupList(PostBloc bloc, List<SimpleStockGroup> candidateStockGroupList) {
    return createStockGroupOverlay(
      context: context,
      textFieldKey: _textFieldStockKey,
      stockGroupList: candidateStockGroupList,
      onListTap: (int i) {
        _controllerStock.text = candidateStockGroupList[i].name;
        bloc.add(PostEvent.selectStockGroup(candidateStockGroupList[i]));
        removeOverlay();
      },
      oldOverlayEntry: overlayEntry,
      removeOverlay: removeOverlay,
      sidebarSize: 300,
    );
  }

  String get stockText => widget.updateStockGroup == null ? '종목' : '종목그룹';

  bool get isStock => widget.updateStockGroup == null;
}
