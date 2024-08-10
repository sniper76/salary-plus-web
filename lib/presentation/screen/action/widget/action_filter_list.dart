part of '../screen.dart';

class _ActionFilterList extends StatelessWidget {
  final List<PostStatusType> postStatusTypeList = [
    PostStatusType.all,
    PostStatusType.active,
    PostStatusType.inactive_by_admin,
    PostStatusType.deleted_by_admin
  ];
  final ActionBloc bloc = GetIt.I<ActionBloc>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 첫 번째 라인의 필터
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...bloc.state.boardCategoryList
                .map((item) => ActFilterButton(
                      text: item.displayName,
                      isSelected: bloc.state.boardCategory == item,
                      onPressed: () {
                        if (bloc.state.boardCategory != item) {
                          bloc.add(ActionEvent.postOnSetBoardCategory(item));
                        }
                      },
                    ))
                .toList(),
          ],
        ),
        // 두 번째 라인의 필터
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ...postStatusTypeList
                .map((item) => ActFilterButton(
                      text: item.title,
                      isSelected: bloc.state.postStatusType == item,
                      onPressed: () {
                        bloc.add(ActionEvent.postOnSetPostStatusType(item));
                      },
                    ))
                .toList()
          ],
        ),
      ],
    );
  }
}
