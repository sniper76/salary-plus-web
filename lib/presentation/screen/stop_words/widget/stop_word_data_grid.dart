part of '../screen.dart';

class _StopWordDataGrid extends StatelessWidget {
  final StopWordsState state;

  const _StopWordDataGrid({required this.state});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final List<CustomColumn> columns = refineColumns([
          CustomColumn(width: 100, columnName: 'createdAt', labelText: '등록일시'),
          CustomColumn(columnName: 'word', labelText: '내용'),
          CustomColumn(width: 100, columnName: 'active', labelText: ''),
          CustomColumn(width: 100, columnName: 'delete', labelText: ''),
        ], constraints.maxWidth);

        return ActDataGrid(
          rowHeight: 56.0,
          columns: columns,
          dataSource: GenericDataSource<StopWord>(
            data: state.stopWordList,
            columnNames: columns.map((e) => e.columnName).toList(),
            valueExtractors: {
              'createdAt': (StopWord stopWord, int index) =>
                  stopWord.createdAt.toFormatString(pattern: 'yyyy-MM-dd HH:mm'),
              'word': (StopWord stopWord, int index) => stopWord.word,
              'active': (StopWord stopWord, int index) => stopWord,
              'delete': (StopWord stopWord, int index) => stopWord,
            },
            customWidgets: {
              'active': (StopWord stopWord) {
                return _StatusChangeButton(stopWord: stopWord);
              },
              'delete': (StopWord stopWord) {
                return _StopWordDeleteButton(stopWord: stopWord);
              }
            },
          ),
        );
      },
    );
  }
}
