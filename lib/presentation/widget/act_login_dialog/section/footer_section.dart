part of '../widget.dart';

class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => _onTapGuideButton(context),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Icon(
                  Icons.question_mark,
                  color: Colors.grey,
                  size: 12,
                ),
              ),
              const SizedBox(width: 4.0),
              Text(
                '웹 로그인 안내',
                style: context.textTheme.labelMedium?.copyWith(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            const Icon(
              Icons.access_time_outlined,
              size: 16.0,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 2.0,
            ),
            Text(
              '남은 시간',
              style:
                  context.textTheme.labelMedium?.copyWith(color: Colors.grey, fontWeight: FontWeight.bold, height: 1.0),
            ),
            const SizedBox(
              width: 3.0,
            ),
            BlocBuilder<ActLoginBloc, ActLoginState>(
              buildWhen: (previous, current) {
                return previous.seconds != current.seconds || previous.webVerification != current.webVerification;
              },
              builder: (context, state) {
                final Duration? diff = state.webVerification?.expirationDateTime.difference(DateTime.now());
                if (diff == null) {
                  return SizedBox(
                    width: 40.0,
                    child: Text(
                      '00:00',
                      style: context.textTheme.labelMedium?.copyWith(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        height: 1.0,
                      ),
                    ),
                  );
                }

                final String diffString = diff.toString().split('.').first;

                return SizedBox(
                  width: 40.0,
                  child: Text(
                    diff.isNegative ? '00:00' : diffString.substring(diffString.length - 5),
                    style: context.textTheme.labelMedium
                        ?.copyWith(color: Colors.red, fontWeight: FontWeight.bold, height: 1.0),
                  ),
                );
              },
            ),
            const SizedBox(
              width: 6.0,
            ),
            InkWell(
              onTap: () => _onTapRefreshButton(context),
              child: const Icon(
                Icons.refresh,
                size: 20.0,
                color: Colors.grey,
              ),
            ),
          ],
        )
      ],
    );
  }
}
