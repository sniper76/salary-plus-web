part of '../screen.dart';

class _UserTermListWidget extends StatelessWidget {
  final User user;
  static const double _heightSpace = 16.0;

  const _UserTermListWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 54),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _UserTermItem(term: "[필수] 개인정보 취급 방침 동의", isChecked: true),
          const SizedBox(height: _heightSpace),
          const _UserTermItem(term: "[필수] 서비스 이용약관 동의", isChecked: true),
          const SizedBox(height: _heightSpace),
          const _UserTermItem(term: "[필수] 주주연대 공지문자 수신 동의", isChecked: true),
          const SizedBox(height: _heightSpace),
          _UserTermItem(term: "[선택] 주주연대 공지우편물 수신 동의", isChecked: user.isAgreeToReceiveMail),
          const SizedBox(height: _heightSpace),
        ],
      ),
    );
  }
}

class _UserTermItem extends StatelessWidget {
  final String term;
  final bool isChecked;

  const _UserTermItem({required this.term, required this.isChecked});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.check_circle, color: isChecked ? AppTheme.primaryColor[400] : Colors.grey.shade400, size: 24.0),
        const SizedBox(width: 16.0),
        Text(term, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
      ],
    );
  }
}
