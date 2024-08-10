import 'dart:async';
import 'dart:html' as html;

import 'package:act_cms/config/theme.dart';
import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/domain/model/dashboard_item.dart';
import 'package:act_cms/domain/model/digital_document_accept_user.dart';
import 'package:act_cms/domain/model/simple_stock.dart';
import 'package:act_cms/domain/model/solidarity_leader_applicant.dart';
import 'package:act_cms/domain/model/stock_detail.dart';
import 'package:act_cms/presentation/base/base_bloc_layout.dart';
import 'package:act_cms/presentation/screen/stock/cmsStock/detail/bloc/bloc.dart';
import 'package:act_cms/presentation/widget/act_divide.dart';
import 'package:act_cms/presentation/widget/act_field_container.dart';
import 'package:act_cms/presentation/widget/act_round_box.dart';
import 'package:act_cms/presentation/widget/act_textfield_dialog.dart';
import 'package:act_cms/presentation/widget/dashboard_list_item.dart';
import 'package:act_cms/presentation/widget/main_app_bar.dart';
import 'package:act_cms/presentation/widget/search_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

@RoutePage()
class CmsStockDetailScreen extends StatefulWidget {
  final String? code;
  final String? name;

  const CmsStockDetailScreen({super.key, @pathParam this.code, @pathParam this.name});

  @override
  State<CmsStockDetailScreen> createState() => _CmsState();
}

class _CmsState extends State<CmsStockDetailScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  final heightSpace = 16.0;
  final horizontalSpace = 12.0;

  int? _hoveredItemIndex;
  StreamSubscription<html.PopStateEvent>? _popStateSubscription;

  void _registerPopStateListener() {
    _popStateSubscription = html.window.onPopState.listen((event) {
      Navigator.of(context).pop();
    });
  }

  _onGetCorporations() {
    final bloc = _scaffoldKey.currentContext?.read<CmsBloc>();
    if (bloc == null) return;

    bloc.add(CmsEvent.onGetCorporationList(searchKeyword: _searchController.text));
  }

  _onSelectCorporation(CorporationUser corporation) {
    final bloc = _scaffoldKey.currentContext?.read<CmsBloc>();
    if (bloc == null) return;

    bloc.add(CmsEvent.onSelectCorporation(corporation));
  }

  _onDismiss() async {
    await context.showAlertDialog(title: '게시글 없음', message: '게시글을 찾을 수 없습니다.');
    context.router.pop();
  }

  _onAssignCorporationLeader(int userId) {
    final bloc = _scaffoldKey.currentContext?.read<CmsBloc>();
    if (bloc == null) return;

    bloc.add(CmsEvent.setCorporationLeader(userId));
  }

  _onOpenAssignCorporationLeaderDialog(BuildContext context, CorporationUser corporationUser) async {
    final res = await context.showConfirmDialog(
        title: '법인 주주대표 임명',
        message: '${corporationUser.corporateName}(${corporationUser.corporateNo})를\n주주대표로 임명하시겠습니까?');
    if (res == true) {
      _searchController.text = '';
      _onAssignCorporationLeader(corporationUser.userId);
      context.router.pop(true);
    }
  }

  _onDeleteSolidarityLeader() {
    final bloc = _scaffoldKey.currentContext?.read<CmsBloc>();
    if (bloc == null) return;

    bloc.add(const CmsEvent.deleteLeader());
  }

  _onDownloadUserList() {
    final bloc = _scaffoldKey.currentContext?.read<CmsBloc>();
    final code = widget.code;
    if (bloc == null || code == null) return;

    bloc.add(CmsEvent.downloadUserList(code));
  }

  _onOpenDismissLeaderDialog() async {
    final res = await context.showConfirmDialog(title: '주주대표 해임', message: '주주대표로 해임하시겠습니까?');
    if (res == true) {
      _onDeleteSolidarityLeader();
    }
  }

  _onMoveRegisterAcceptUserScreen() async {
    if (widget.code == null) return;

    final res = await context.router.push(RegisterAcceptUserRoute(stockCode: widget.code!));
    if (res != null) {}
  }

  _onFireAcceptUser(int userId) {
    final stockCode = widget.code;
    final bloc = _scaffoldKey.currentContext?.read<CmsBloc>();
    if (bloc == null || stockCode == null) return;

    bloc.add(CmsEvent.onFireAcceptUser(stockCode: stockCode, userId: userId));
  }

  _onOpenFireAcceptUserDialog(int userId) async {
    if (widget.code == null) return;

    final res = await context.showConfirmDialog(title: '수임인 해임', message: '수임인을 해임하시겠습니까?');

    if (res == true) _onFireAcceptUser(userId);
  }

  @override
  void initState() {
    super.initState();
    if (widget.code == null || widget.name == null) {
      _onDismiss();
    }
    _registerPopStateListener();
  }

  @override
  void dispose() {
    EasyLoading.dismiss();
    _popStateSubscription?.cancel();
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBlocLayout<CmsBloc, CmsState>(
      scaffoldKey: _scaffoldKey,
      create: (context) => CmsBloc()
        ..add(
          CmsEvent.init(SimpleStock(code: widget.code!, name: widget.name!)),
        ),
      listener: (context, state) {},
      builder: (context, bloc, state) {
        if (state.isLoading) {
          EasyLoading.show();
        }
        if (state.toast != "") {
          EasyLoading.showToast(state.toast);
          const CmsEvent.clearToastMsg();
        }

        return _buildCmsStockDetailScreen(context, bloc, state);
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

  Widget _buildCmsStockDetailScreen(BuildContext context, CmsBloc bloc, CmsState state) {
    return BlocListener<CmsBloc, CmsState>(
      listenWhen: (previousState, currentState) {
        return (previousState.stockInfo?.solidarityLeader?.message !=
            currentState.stockInfo?.solidarityLeader?.message);
      },
      listener: (context, state) {
        _controller.text = state.stockInfo?.solidarityLeader?.message ?? "";
      },
      child: Scaffold(
        backgroundColor: const Color(0xfff5f5f5),
        appBar: MainAppBar(
          mainTitle: '${state.stockInfo?.solidarity?.name} ${widget.code}',
          context: context,
        ),
        body: Container(
          color: const Color(0xfff5f5f5),
          child: SingleChildScrollView(
            child: Align(
              alignment: Alignment.topCenter,
              child: _buildStockDetail(context, bloc, state),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildApplicantProfile({required CmsBloc bloc, required SolidarityLeaderApplicant applicant}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildUserInfo(
            name: applicant.name,
            nickName: applicant.nickname ?? '',
            extraInfo: formatPhoneNumber(applicant.phoneNumber)),
        SizedBox(width: heightSpace),
        if (bloc.state.stockInfo?.solidarity?.id != null)
          Row(
            children: [
              _buildApplicantButton(
                onPressed: () {
                  bloc.add(CmsEvent.setLeader(bloc.state.stockInfo!.solidarity!.id, applicant.solidarityApplicantId));
                },
                text: '선정',
              ),
              SizedBox(width: horizontalSpace),
              _buildApplicantButton(
                onPressed: () async {
                  String? cancelReason = await ActTextFieldDialog.show(context, '지원취소 사유 입력');
                  if (cancelReason?.isNotEmpty == true) {
                    bloc.add(CmsEvent.cancelLeaderCandidate(
                      bloc.state.stockInfo!.solidarity!.id,
                      applicant.solidarityApplicantId,
                      cancelReason!,
                    ));
                  }
                },
                text: '지원취소',
                backgroundColor: const Color(0xff999999),
              )
            ],
          ),
      ],
    );
  }

  Widget _buildUserInfo({required String name, required String nickName, required String extraInfo}) {
    const textStyle = TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500);
    return Row(
      children: [
        Text('$name ${nickName.isEmpty ? '' : "($nickName)"}', style: textStyle, textAlign: TextAlign.start),
        SizedBox(width: horizontalSpace),
        Text(extraInfo, style: textStyle.copyWith(fontWeight: FontWeight.normal)),
      ],
    );
  }

  Widget _buildApplicantButton(
      {required Function()? onPressed, required String text, Color? backgroundColor, Size? fixedSize}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppTheme.primaryColor[600],
        fixedSize: fixedSize ?? const Size(90, 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text, style: const TextStyle(color: Colors.white, fontSize: 12.0)),
    );
  }

  Widget _buildFireButton(void Function() onPressed) {
    return _buildApplicantButton(
      backgroundColor: const Color(0xffFF9650),
      onPressed: onPressed,
      text: '해임하기',
    );
  }

  Widget _buildStockDetail(BuildContext context, CmsBloc bloc, CmsState state) {
    return ActRoundBox(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStockLeader(context, bloc, state),
            SizedBox(height: heightSpace),
            _buildLeaderMessage(bloc, state),
            SizedBox(height: heightSpace),
            _buildAcceptUser(bloc, state.acceptUser),
            SizedBox(height: heightSpace),
            if (state.stockInfo != null) _buildStockInfo(state.stockInfo!),
            _buildDownloadUserListButton()
          ],
        ),
      ),
    );
  }

  Widget _buildLeaderMessage(CmsBloc bloc, CmsState state) {
    return ActFieldContainer(
      title: "대표 한마디",
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: Color(0xffD9D9D9)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            ),
            onSubmitted: (value) {
              if (state.isLeaderSelected) {
                bloc.add(CmsEvent.setLeaderComment(_controller.text));
              }
            },
          ),
        ),
        SizedBox(width: horizontalSpace),
        _buildApplicantButton(
          onPressed: !state.isLeaderSelected
              ? null
              : () {
                  bloc.add(CmsEvent.setLeaderComment(_controller.text));
                },
          fixedSize: const Size(150, 50),
          text: '저장',
        )
      ],
    );
  }

  Widget _buildAcceptUser(CmsBloc bloc, DigitalDocumentAcceptUser? acceptUser) {
    final isAcceptUser = acceptUser != null;
    return ActFieldContainer(
      title: '수임인',
      children: [
        Text(isAcceptUser ? '${acceptUser.name} ${acceptUser.phoneNumber}' : '-'),
        const SizedBox(width: 12),
        isAcceptUser
            ? _buildFireButton(() => _onOpenFireAcceptUserDialog(acceptUser.id))
            : _buildApplicantButton(text: '선정하기', onPressed: _onMoveRegisterAcceptUserScreen)
      ],
    );
  }

  Widget _buildStockInfo(StockDetail stockInfo) {
    final todayDelta = stockInfo.todayDelta;
    final solidarity = stockInfo.solidarity;
    final todayInfo = todayDelta?.items ?? [];
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          context.router.push(CmsStockStaticsRoute(param: stockInfo));
        },
        child: Column(
          children: [
            if (todayInfo.isNotEmpty)
              ...todayInfo
                  .map((item) => DashboardListItem(
                      item: DashboardItem(title: item.title, value: item.value, variation: item.variation)))
                  .toList(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                children: [
                  const Spacer(),
                  Text(
                    todayDelta?.descriptionLabel ?? "",
                    style: context.textTheme.labelLarge?.copyWith(color: Colors.grey.shade600),
                  ),
                ],
              ),
            ),
            if (solidarity?.representativePhoneNumber != null)
              DashboardListItem(item: DashboardItem(title: 'IR/주담', value: solidarity!.representativePhoneNumber!))
          ],
        ),
      ),
    );
  }

  Widget _buildStockLeader(BuildContext context, CmsBloc bloc, CmsState state) {
    final solidarityLeader = state.stockInfo?.solidarityLeader;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            state.isLeaderSelected ? "주주대표" : "지원자목록",
            style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ),
        if (state.isLeaderSelected && solidarityLeader != null)
          Row(
            children: [
              _buildUserInfo(
                name: solidarityLeader.name,
                nickName: solidarityLeader.nickname ?? '',
                extraInfo: solidarityLeader.corporateNo ?? formatPhoneNumber(solidarityLeader.phoneNumber),
              ),
              SizedBox(width: horizontalSpace),
              _buildFireButton(_onOpenDismissLeaderDialog)
            ],
          ),
        if (state.isLeaderSelected != true && state.stockInfo != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...state.stockInfo!.solidarityLeaderApplicants!
                  .map((applicant) => Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: _buildApplicantProfile(bloc: bloc, applicant: applicant),
                      ))
                  .toList(),
              _buildApplicantButton(
                text: '주주대표 법인 임명',
                onPressed: () {
                  _onGetCorporations();

                  showDialog(
                    context: context,
                    builder: (context) {
                      return _buildSearchCorporationsDialog(context, bloc);
                    },
                  );
                },
                fixedSize: const Size(250, 20),
                backgroundColor: const Color.fromRGBO(255, 150, 80, 1),
              )
            ],
          ),
      ],
    );
  }

  Widget _buildSearchCorporationsDialog(BuildContext context, bloc) {
    return BlocBuilder<CmsBloc, CmsState>(
      bloc: bloc,
      builder: (context, state) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDialogHeader(context),
                const SizedBox(height: 20),
                CustomSearchBar(controller: _searchController, onSearch: _onGetCorporations, onChange: (value) {}),
                const SizedBox(height: 20),
                _buildCorporations(corporations: state.corporations, selectedCorporation: state.selectedCorporation),
                _buildActionButton(context, state.selectedCorporation),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCorporations(
      {required List<CorporationUser> corporations, required CorporationUser? selectedCorporation}) {
    return Expanded(
      child: ListView.separated(
        itemCount: corporations.length,
        itemBuilder: (context, index) {
          final corporation = corporations[index];
          return _buildCorporationItem(
              context: context,
              index: index,
              corporation: corporation,
              isSelected: selectedCorporation?.userId == corporation.userId);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const ActDivide(height: 4);
        },
      ),
    );
  }

  Widget _buildDialogHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('주주대표 법인 임명', style: AppTheme.defaultTextTheme.headlineMedium),
        IconButton(onPressed: () => context.router.pop(), icon: const Icon(Icons.close))
      ],
    );
  }

  Widget _buildCorporationItem(
      {required BuildContext context,
      required int index,
      required CorporationUser corporation,
      required bool isSelected}) {
    bool isHovered = _hoveredItemIndex == index;

    return MouseRegion(
      onEnter: (event) => setState(() => _hoveredItemIndex = index),
      onExit: (event) => setState(() => _hoveredItemIndex = null),
      child: InkWell(
        onTap: () => _onSelectCorporation(corporation),
        child: Container(
          color: isSelected
              ? AppTheme.primaryColor[400]
              : isHovered
                  ? Colors.grey[200]
                  : Colors.transparent,
          child: Row(
            children: [
              SizedBox(width: 150, child: Text(corporation.corporateName)),
              Text(corporation.corporateNo),
              const Spacer(),
              ElevatedButton(onPressed: () => _onSelectCorporation(corporation), child: const Text('선택'))
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadUserListButton() {
    return TextButton(
      onPressed: _onDownloadUserList,
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [const Text('유저리스트 다운로드'), SvgPicture.asset('assets/images/ic_xlsx.svg')],
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, CorporationUser? selectedCorporation) {
    return Row(
      children: [
        Expanded(
            child: ElevatedButton(
                onPressed: selectedCorporation == null
                    ? null
                    : () => _onOpenAssignCorporationLeaderDialog(context, selectedCorporation),
                child: const Text('임명')))
      ],
    );
  }
}
