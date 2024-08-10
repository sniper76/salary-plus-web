part of '../screen.dart';

class _ContentSection extends StatelessWidget {
  final TextEditingController contentTextController;
  final Post? updatePost;
  final Function(String?) onChanged;

  const _ContentSection({
    required this.contentTextController,
    required this.onChanged,
    this.updatePost,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('내용'),
        const SizedBox(width: 60),
        Expanded(
          child: TextField(
            controller: contentTextController,
            textInputAction: TextInputAction.done,
            maxLines: 5,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '내용을 입력해주세요',
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _MainContentSection extends StatelessWidget {
  final HtmlEditorController contentTextController;
  final UploadImage _uploadImage = GetIt.I<UploadImage>();
  final Post? updatePost;

  _MainContentSection({
    required this.contentTextController,
    this.updatePost,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('내용'),
        const SizedBox(width: 60),
        CustomHtmlEditor(
          controller: contentTextController,
          initialText: updatePost?.content,
          uploadImage: _uploadImage,
        ),
      ],
    );
  }
}

class _RegisterSection extends StatelessWidget {
  final EventBoardRegisterBloc bloc;
  late final EventBoardRegisterState state = bloc.state;

  _RegisterSection({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('등록'),
        const SizedBox(width: 60),
        _RegisterPickDateItem(
          selectedDateTime: bloc.state.activeStartDate,
          onTapFunction: () {
            _onTapStartDatePicker(context, bloc);
          },
          color: Colors.white,
        ),
        const SizedBox(width: 10),
        const Text('~'),
        const SizedBox(width: 10),
        _RegisterPickDateItem(
          selectedDateTime: bloc.state.activeEndDate,
          onTapFunction: () {
            _onTapEndDatePicker(context, bloc);
          },
          color: Colors.white,
        ),
      ],
    );
  }
}

class _ActiveRadioSection extends StatelessWidget {
  final EventBoardRegisterBloc bloc;
  late final EventBoardRegisterState state = bloc.state;

  _ActiveRadioSection({
    required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('노출여부'),
        const SizedBox(width: 40),
        Row(
          children: [
            _RadioItem(
              title: '게시',
              icon: state.isActive ? Icons.radio_button_on : Icons.radio_button_off,
              isChecked: state.isActive,
              onTap: () {
                onTapActivateButton(bloc);
              },
            ),
            const SizedBox(width: 16.0),
            _RadioItem(
              title: '미노출',
              icon: !state.isActive ? Icons.radio_button_on : Icons.radio_button_off,
              isChecked: !state.isActive,
              onTap: () async {
                onTapDeActivateButton(context, bloc);
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _TitleSection extends StatelessWidget {
  final TextEditingController titleTextController;
  final Function(String?) onChanged;

  const _TitleSection({
    required this.titleTextController,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('제목'),
        const SizedBox(width: 60),
        Expanded(
          child: TextField(
            controller: titleTextController,
            textInputAction: TextInputAction.done,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: '제목을 입력해주세요',
              errorMaxLines: 2,
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

class _CategorySection extends StatelessWidget {
  final BoardGroupCategory boardGroupCategory;

  const _CategorySection({required this.boardGroupCategory});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('카테고리'),
        const SizedBox(width: 35),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey.shade400,
          ),
          width: 150,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  boardGroupCategory.displayName,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Icon(
                  Icons.keyboard_arrow_down,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SendPushSection extends StatelessWidget {
  final EventBoardRegisterBloc bloc;
  late final EventBoardRegisterState state = bloc.state;

  _SendPushSection({required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('푸시발송'),
        const SizedBox(width: 40),
        Wrap(
          spacing: 16.0,
          children: [
            ...NoticePushSendStatus.values.map(
              (NoticePushSendStatus noticePushSendStatus) => _RadioItem(
                title: noticePushSendStatus.title,
                icon: state.selectedNoticePushSendStatus == noticePushSendStatus
                    ? Icons.radio_button_on
                    : Icons.radio_button_off,
                isChecked: state.selectedNoticePushSendStatus == noticePushSendStatus,
                onTap: () {
                  bloc.add(EventBoardRegisterEvent.setPushSendStatus(noticePushSendStatus));
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _SendAlarmSection extends StatefulWidget {
  final EventBoardRegisterBloc bloc;
  late final EventBoardRegisterState state = bloc.state;

  _SendAlarmSection({
    required this.bloc,
  });

  @override
  State<_SendAlarmSection> createState() => _SendAlarmSectionState();
}

class _SendAlarmSectionState extends State<_SendAlarmSection> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('알림게시'),
        const SizedBox(width: 40),
        Row(
          children: [
            _RadioItem(
              title: '게시',
              icon: widget.state.isNotification ? Icons.radio_button_on : Icons.radio_button_off,
              isChecked: widget.state.isNotification,
              onTap: () {
                widget.bloc.add(EventBoardRegisterEvent.setAlarmStatus(true));
              },
            ),
            const SizedBox(width: 16.0),
            _RadioItem(
              title: '미게시',
              icon: !widget.state.isNotification ? Icons.radio_button_on : Icons.radio_button_off,
              isChecked: !widget.state.isNotification,
              onTap: () {
                widget.bloc.add(EventBoardRegisterEvent.setAlarmStatus(false));
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _PushViewSection extends StatelessWidget {
  final String title;
  final String content;
  const _PushViewSection({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title),
        const SizedBox(width: 30),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.grey.shade400),
              color: Colors.grey.withOpacity(0.7),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: Text(
                content,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
