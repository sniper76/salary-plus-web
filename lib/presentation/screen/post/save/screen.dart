import 'dart:async';
import 'dart:typed_data';

import 'package:act_web/core/extension/context_extension.dart';
import 'package:act_web/core/extension/datetime_extension.dart';
import 'package:act_web/core/extension/string_extension.dart';
import 'package:act_web/core/service/user_auth_service.dart';
import 'package:act_web/domain/enum/board_group_type.dart';
import 'package:act_web/domain/enum/poll_selection_type.dart';
import 'package:act_web/domain/model/document/document.dart';
import 'package:act_web/domain/model/post/board_group_category.dart';
import 'package:act_web/domain/model/post/poll_register_result.dart';
import 'package:act_web/domain/model/post/post.dart';
import 'package:act_web/domain/model/stock/base_stock.dart';
import 'package:act_web/presentation/base/base_bloc_layout.dart';
import 'package:act_web/presentation/screen/post/save/bloc/bloc.dart';
import 'package:act_web/presentation/widget/act_poll_create_dialog/widget.dart';
import 'package:act_web/presentation/widget/act_poll_widget.dart';
import 'package:act_web/presentation/widget/act_text_form_field.dart';
import 'package:act_web/presentation/widget/custom_check_box.dart';
import 'package:act_web/presentation/widget/default_act_web_app_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

part 'handler.dart';
part 'widget/post_save_widget.dart';
part 'widget/anonymous_check_widget.dart';
part 'widget/exclusive_to_shareholder_switch_widget.dart';
part 'widget/image_upload_widget.dart';
part 'widget/poll_creation_widget.dart';

@RoutePage<bool>()
class PostSaveScreen extends StatefulWidget {
  final String? stockCode;
  final BoardGroupType? boardGroupType;
  final BoardGroupCategory? boardGroupCategory;
  final Post? post;

  late final bool isRegisterPage = post == null;

  PostSaveScreen({
    super.key,
    this.stockCode,
    this.boardGroupType,
    this.boardGroupCategory,
    this.post,
  });

  @override
  State<PostSaveScreen> createState() => _PostSaveScreenState();
}

class _PostSaveScreenState extends State<PostSaveScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey _stockTextFieldKey = GlobalKey();

  final TextEditingController _stockTextController = TextEditingController();

  final TextEditingController _titleTextController = TextEditingController();
  final TextEditingController _contentTextController = TextEditingController();
  final int _maxUploadCount = 1;

  Timer? _timer;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    if (GetIt.I.isRegistered<PostSaveBloc>() == false) {
      GetIt.I.registerSingleton(PostSaveBloc(
        boardGroupType: widget.boardGroupType,
        boardGroupCategory: widget.boardGroupCategory,
        post: widget.post,
      ));
    }

    if (widget.post != null) {
      final Post updatedPost = widget.post!;
      _stockTextController.text = updatedPost.stock?.name ?? '';
      _titleTextController.text = updatedPost.title;
      _contentTextController.text = updatedPost.content?.unEscapedString ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<PostSaveBloc, PostSaveState>(
      appBarbuilder: (context, bloc, state) {
        return DefaultActWebAppBar();
      },
      backgroundColor: Colors.white,
      create: (context) => GetIt.I<PostSaveBloc>()..add(PostSaveEvent.init()),
      listener: (context, state) async {
        if (state.updatedPost != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).maybePop(true);
          });
        }

        if (state.tempSavedPostContent?.isNotEmpty == true) {
          final bool confirmRes = await context.showConfirmDialog(title: '자동저장 불러오기', message: '자동저장된 내용을 불러오시겠습니까?');
          if (confirmRes) {
            _contentTextController.text = state.tempSavedPostContent ?? '';
          }
          GetIt.I<PostSaveBloc>().add(PostSaveEvent.disableSavedContentDialog());
        }
      },
      builder: (context, bloc, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          behavior: HitTestBehavior.translucent,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: Container(
                    margin: const EdgeInsets.only(top: 80.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: SizedBox(
                      width: 1000,
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
                        children: [
                          const SizedBox(height: 40.0),
                          Row(
                            children: [
                              Text(
                                '종목',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 28.0),
                              widget.stockCode != null
                                  ? Container(
                                      alignment: Alignment.centerLeft,
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        widget.post?.boardGroupCategory?.displayName ?? "dd",
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    )
                                  : Flexible(
                                      child: BlocListener<PostSaveBloc, PostSaveState>(
                                          listenWhen: (previous, current) =>
                                              previous.stockSearchKeyword != current.stockSearchKeyword,
                                          listener: (context, state) {
                                            final List<BaseStock>? targetStocks = GetIt.I<UserAuthService>()
                                                .userMe
                                                ?.holdingStocks
                                                ?.where((BaseStock stock) {
                                              return stock.code.contains(_stockTextController.text) ||
                                                  stock.name
                                                      .toUpperCase()
                                                      .contains(_stockTextController.text.toUpperCase());
                                            }).toList();

                                            _overlayEntry = createSimpleStockOverlay(
                                              context: context,
                                              textFieldKey: _stockTextFieldKey,
                                              holdingStockList: targetStocks ?? [],
                                              onListTap: (i) {
                                                bloc.add(PostSaveEvent.changeStock(targetStocks?[i].code));
                                                removeOverlay();
                                                _stockTextController.text = targetStocks?[i].name ?? '';
                                              },
                                              oldOverlayEntry: _overlayEntry,
                                              removeOverlay: removeOverlay,
                                              sidebarSize: 300,
                                            );
                                          },
                                          child: ActTextFormField(
                                            key: _stockTextFieldKey,
                                            controller: _stockTextController,
                                            readOnly: widget.post != null,
                                            enabled: !(widget.post != null),
                                            onChanged: (value) {
                                              bloc.add(PostSaveEvent.searchStock(
                                                value,
                                              ));
                                            },
                                          )),
                                    ),
                            ],
                          ),
                          if (state.boardGroupOptionList.isNotEmpty)
                            Row(
                              children: [
                                Text(
                                  '게시판',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 16.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.grey.shade300),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                        focusColor: Colors.white,
                                        padding: const EdgeInsets.only(left: 12.0, right: 16.0),
                                        value: state.selectedboardGroupOption ?? state.boardGroupOptionList.first,
                                        hint: const Text('선택'),
                                        icon: const Icon(Icons.keyboard_arrow_down),
                                        onChanged: (newValue) {
                                          bloc.add(PostSaveEvent.changeOption(newValue!));
                                        },
                                        items: state.boardGroupOptionList.map<DropdownMenuItem>((value) {
                                          return DropdownMenuItem(
                                            value: value,
                                            child: Text(
                                              '종목게시판-${value.$2.displayName}',
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
                            ),
                          Row(
                            children: [
                              Text(
                                '제목',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 28.0),
                              Flexible(
                                child: ActTextFormField(
                                  controller: _titleTextController,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '내용',
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 28.0),
                              Flexible(
                                child: Column(
                                  children: [
                                    ActTextFormField(
                                      height: 400,
                                      controller: _contentTextController,
                                      maxLines: null,
                                      onTap: () {
                                        if (_timer == null && widget.isRegisterPage) _startTimer();
                                      },
                                    ),
                                    const SizedBox(height: 8.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            _ImageUploadWidget(
                                              onTapImageUploadWidget: () =>
                                                  _onCameraPressed(state.uploadImageFiles.length),
                                            ),
                                            const SizedBox(width: 24.0),
                                            if (state.selectedboardGroupOption?.$1.enablePoll == true)
                                              _PollCreationWidget(
                                                onTapPollCreationWidget: () => _onPollCreate(),
                                                isPollAdded: state.updatedPost?.polls != null &&
                                                    state.updatedPost?.polls?.isNotEmpty == true,
                                              ),
                                          ],
                                        ),
                                        if (state.tempSavedDateTime != null)
                                          Row(
                                            children: [
                                              const Icon(Icons.save_as_outlined, color: Colors.grey),
                                              const SizedBox(width: 4.0),
                                              Text(
                                                '${state.tempSavedDateTime?.toFormatString(pattern: 'yyyy-MM-dd HH:mm')} 자동 저장 되었습니다',
                                                style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
                                              )
                                            ],
                                          )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16.0),
                          if (state.uploadImageFiles.isNotEmpty || state.pollRegisterResultList.isNotEmpty)
                            Row(
                              children: [
                                Text(
                                  '사진\n/\n투표',
                                  style: context.textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(width: 28.0),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    margin: const EdgeInsets.only(bottom: 16.0),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: context.colorScheme.outline),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        if (state.uploadImageFiles.isNotEmpty)
                                          ...state.uploadImageFiles.map(
                                            (e) => Stack(children: [
                                              ConstrainedBox(
                                                constraints: const BoxConstraints(maxWidth: 300.0),
                                                child: CachedNetworkImage(
                                                  height: 300.0,
                                                  imageUrl: e.url,
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Positioned(
                                                top: 20.0,
                                                right: 20.0,
                                                child: InkWell(
                                                  onTap: _onImageDelete,
                                                  child: const Icon(
                                                    Icons.close_rounded,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                ),
                                              )
                                            ]),
                                          ),
                                        if (state.pollRegisterResultList.isNotEmpty) ...[
                                          ...state.pollRegisterResultList
                                              .mapIndexed((int index, PollRegisterResult result) {
                                            final Poll poll = result.toPoll();
                                            return Padding(
                                              padding: const EdgeInsets.only(top: 24.0),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  if (poll.content != null) ...[
                                                    Text(poll.content ?? ''),
                                                    const SizedBox(height: 12),
                                                  ],
                                                  ActPollWidget(
                                                    pollId: poll.id,
                                                    title: poll.title,
                                                    choices: poll.pollItems,
                                                    answers: const [],
                                                    isMultipleChoice: poll.selectionType == PollSelectionType.multiple,
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerRight,
                                                    child: widget.isRegisterPage
                                                        ? TextButton(
                                                            onPressed: () {
                                                              bloc.add(PostSaveEvent.deletePoll(index));
                                                            },
                                                            child: const Text('삭제'))
                                                        : TextButton(
                                                            onPressed: () async {
                                                              final PollRegisterResult? result =
                                                                  await ActPollCreateDialog.show(
                                                                context: context,
                                                                result: state.pollRegisterResultList[index],
                                                              );
                                                              if (result != null) {
                                                                bloc.add(PostSaveEvent.updatePoll(result));
                                                              }
                                                            },
                                                            child: const Text('수정'),
                                                          ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                          const SizedBox(
                                            height: 24.0,
                                          )
                                        ],
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    if (state.selectedboardGroupOption?.$1.enableExclusiveToHolders == true)
                                      _ExclusiveToShareholderSwitchWidget(
                                        isChecked: state.isExclusiveToHolders,
                                        onChanged: _onChangeShareHolderOnly,
                                      ),
                                    const SizedBox(width: 24.0),
                                    if (widget.isRegisterPage)
                                      _AnonymousCheckWidget(
                                        isChecked: state.isAnonymous,
                                        onChanged: (isChecked) => _onChangeAnonymousMode(isChecked),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40.0),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 160.0,
                  child: _PostSaveWidget(
                    isRegisterPage: widget.isRegisterPage,
                    onTapPostSaveWidget: _onSavePressed,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    GetIt.I.unregister<PostSaveBloc>();
    _timer?.cancel();
    _titleTextController.dispose();
    _contentTextController.dispose();
    super.dispose();
  }
}
