part of '../screen.dart';

class _StopWordSearchButton extends StatelessWidget {
  final TextEditingController searchTextController;

  const _StopWordSearchButton({required this.searchTextController});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final bloc = context.read<StopWordsBloc>();
        bloc.add(StopWordsEvent.searchKeyword(
          searchTextController.text,
        ));
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor[600],
        fixedSize: const Size(120, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: const Text(
        '검색',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
