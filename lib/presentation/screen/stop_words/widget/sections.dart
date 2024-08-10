part of '../screen.dart';

class _SearchBarSection extends StatelessWidget {
  final TextEditingController searchTextController;

  const _SearchBarSection({required this.searchTextController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchTextController,
            onSubmitted: (value) {},
            onChanged: (value) {},
            decoration: InputDecoration(
              hintText: '검색할 ${AppConfig.stopWordText}를 입력하세요.',
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8), // 둥근 모서리 설정
                borderSide: BorderSide(color: Colors.grey.shade300), // 테두리 색상 설정
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10.0,
        ),
        _StopWordSearchButton(searchTextController: searchTextController),
      ],
    );
  }
}

class _SearchControlSection extends StatelessWidget {
  final StopWordsBloc bloc;

  const _SearchControlSection({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ActSearchControlWidget<StopWordFilterTypeWrapper>(
          onTapControlButton: (StopWordFilterTypeWrapper curIndexFilterTypeWrapper) {
            bloc.add(StopWordsEvent.changeFilterType(curIndexFilterTypeWrapper.stopWordFilterType));
          },
          searchControlTypeWrapperList: bloc.state.stopWordFilterTypeWrapperList,
          selectedControlTypeWrapper: StopWordFilterTypeWrapper(
            stopWordFilterType: bloc.state.selectedFilterType,
          ),
        ),
        ActSearchControlWidget<StopWordSortTypeWrapper>(
          onTapControlButton: (StopWordSortTypeWrapper curIndexSortTypeWrapper) {
            bloc.add(StopWordsEvent.changeSortType(curIndexSortTypeWrapper.stopWordSortType));
          },
          searchControlTypeWrapperList: bloc.state.stopWordSortTypeWrapperList,
          selectedControlTypeWrapper: StopWordSortTypeWrapper(
            stopWordSortType: bloc.state.selectedSortType,
          ),
        ),
      ],
    );
  }
}

class _StopWordGridSection extends StatelessWidget {
  final StopWordsState state;

  const _StopWordGridSection({required this.state});

  @override
  Widget build(BuildContext context) {
    return Expanded(child: _StopWordDataGrid(state: state));
  }
}
