part of 'widget.dart';

void _onTapGuideButton(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const _WebLoginGuideDialog();
    },
  );
}

void _onTapRefreshButton(BuildContext context) {
  final ActLoginBloc bloc = GetIt.I<ActLoginBloc>();
  bloc.add(const ActLoginEvent.init());
}
