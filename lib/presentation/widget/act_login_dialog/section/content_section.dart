part of '../widget.dart';

class _ContentSection extends StatelessWidget {
  const _ContentSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RichText(
          text: TextSpan(
            style: context.textTheme.bodyMedium,
            children: [
              const TextSpan(
                text: '게시글 및 댓글 등록, 주주에게만 공개된 게시글 읽기 등의 기능은 앱 회원 인증을 통한 로그인 후 이용 가능합니다.\n\n하단 ',
              ),
              TextSpan(
                text: '개인안심번호',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: ' 혹은 '),
              TextSpan(
                text: 'QR코드',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TextSpan(text: '를 통해 인증하실 수 있습니다.'),
            ],
          ),
        ),
        const SizedBox(height: 24.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  '개인안심번호',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                BlocBuilder<ActLoginBloc, ActLoginState>(
                  builder: (context, state) => Container(
                    padding: const EdgeInsets.only(top: 32.0, bottom: 30.0),
                    child: Text(
                      FormatUtils.formatVerificationCode(state.webVerification?.verificationCode ?? ''),
                      style: context.textTheme.displayLarge?.copyWith(
                        letterSpacing: 6,
                        height: 1,
                      ),
                    ),
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: context.textTheme.labelMedium,
                    children: [
                      const TextSpan(
                        text: '액트 앱 ',
                      ),
                      TextSpan(
                        text: '[MY -> 웹 로그인]',
                        style: context.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(
                        text: '에서\n4자리 개인안심번호를 입력해주세요.',
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 35.0),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 10.0,
              ),
              width: 3,
              height: 145,
              color: context.colorScheme.primary,
            ),
            const SizedBox(width: 50.0),
            Column(
              children: [
                Text(
                  'QR코드',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: BlocBuilder<ActLoginBloc, ActLoginState>(
                    builder: (context, state) => QrImageView(
                      data: state.loginDynamicLink,
                      version: QrVersions.auto,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
