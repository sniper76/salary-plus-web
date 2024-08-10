part of '../screen.dart';

class _UserInfoListWidget extends StatelessWidget {
  final User user;
  static const double _heightSpace = 16.0;

  const _UserInfoListWidget({required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UserInfoItem(title: 'UID', content: user.id.toString()),
        const SizedBox(height: _heightSpace),
        _UserInfoItem(title: '이름', content: user.name, subChildren: [
          if (user.isAdmin == true) ...[const ActAdminBadge(), const SizedBox(width: 8)],
          if (user.leadingSolidarityStockCodes?.isNotEmpty == true) const SolidarityLeaderBadge()
        ]),
        const SizedBox(height: _heightSpace),
        _UserInfoItem(title: '닉네임', content: user.nickname, subChildren: [
          _UserNicknameEditButton(user: user),
        ]),
        const SizedBox(height: _heightSpace),
        _UserInfoItem(title: '휴대폰번호', content: user.phoneNumber),
        const SizedBox(height: _heightSpace),
        _UserInfoItem(title: '이메일', content: user.email),
        const SizedBox(height: _heightSpace),
        _UserInfoItem(title: '가입일자', content: user.createdAt?.toFormatString(pattern: dateTimeFormatPattern)),
        const SizedBox(height: _heightSpace),
        _UserInfoItem(title: '총자산', content: FormatUtils.formatAssetAmount(user.totalAssetAmount)),
        const SizedBox(height: _heightSpace),
        _UserInfoItem(
          title: '비밀유지 서약서',
          subChildren: [
            user.isSolidarityLeaderConfidentialAgreementSigned == true
                ? const _ConfidentialDownloadButton()
                : const Text('제출된 비밀유지 서약서가 없습니다.'),
          ],
        ),
      ],
    );
  }
}

class _UserInfoItem extends StatelessWidget {
  final String title;
  final String? content;
  final List<Widget>? subChildren;

  const _UserInfoItem({
    required this.title,
    this.content,
    this.subChildren,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("$title :", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(width: 8),
        if (content != null) Text(content!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
        if (subChildren != null) ...subChildren!,
      ],
    );
  }
}

class _UserNicknameEditButton extends StatefulWidget {
  final User user;
  const _UserNicknameEditButton({required this.user});

  @override
  State<_UserNicknameEditButton> createState() => _UserNicknameEditButtonState();
}

class _UserNicknameEditButtonState extends State<_UserNicknameEditButton> {
  final nicknameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.edit),
      onPressed: () => _onOpenNicknameDialog(context, widget.user.nickname, nicknameController),
    );
  }
}

class _ConfidentialDownloadButton extends StatelessWidget {
  const _ConfidentialDownloadButton();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTapConfidentailDownloadButton(),
      child: const Row(
        children: [
          Icon(
            Icons.picture_as_pdf,
            color: Colors.redAccent,
          ),
          SizedBox(
            width: 3.0,
          ),
          Text('다운로드'),
        ],
      ),
    );
  }
}
