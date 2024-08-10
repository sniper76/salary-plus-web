part of '../screen.dart';

class _StopWordCreateButton extends StatelessWidget {
  final TextEditingController dialogController;

  const _StopWordCreateButton({required this.dialogController});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _onCreateStopWord(
        context,
        dialogController,
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor[600],
        fixedSize: const Size.fromHeight(50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ), // 모서리의 둥근 정도
      ),
      child: const Text(
        '${AppConfig.stopWordText} 등록',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
