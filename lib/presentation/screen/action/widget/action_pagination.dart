part of '../screen.dart';

class ActionPagination extends StatelessWidget {
  final ActionBloc bloc = GetIt.I<ActionBloc>();

  ActionPagination({super.key});

  @override
  Widget build(BuildContext context) {
    if (bloc.state.postList.isNotEmpty) {
      return ActPagination<ActionBloc, ActionState>(
        paging: bloc.state.paging,
        onPageChange: (int page) {
          bloc.add(ActionEvent.fetchPostLoadMore(page: page));
        },
      );
    }

    return Container();
  }
}
