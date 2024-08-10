import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PostStockDataSource extends DataGridSource {
  static const testStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal);

  String formatViewCount(int? viewCount) {
    if (viewCount == null) return '0';
    return NumberFormat('#,###').format(viewCount);
  }

  PostStockDataSource(List<Post> postList) {
    dataGridRows = postList
        .map<DataGridRow>((postData) => DataGridRow(cells: [
              DataGridCell<String>(columnName: 'category', value: postData.boardGroupCategory?.displayName),
              DataGridCell<String>(columnName: 'stock', value: postData.stock?.name ?? ""),
              DataGridCell<String>(columnName: 'title', value: postData.title),
              DataGridCell<String>(columnName: 'createdAt', value: postData.createdAt.toFormatString()),
              DataGridCell<String>(columnName: 'viewCount', value: formatViewCount(postData.viewCount)),
              DataGridCell<String>(columnName: 'likeCount', value: formatViewCount(postData.likeCount)),
              DataGridCell<String>(columnName: 'commentCount', value: formatViewCount(postData.commentCount)),
              DataGridCell<Post>(columnName: 'linkPaste', value: postData),
              // 다른 필드를 여기에 추가할 수 있습니다.
            ]))
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((cell) {
      return MouseRegion(cursor: SystemMouseCursors.click, child: _buildCell(cell));
    }).toList());
  }

  Widget _buildCell(DataGridCell cell) {
    switch (cell.columnName) {
      case "category":
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
          child: Text(
            "[${cell.value.toString()}]",
            style: const TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold, color: Color(0xff439CFB)),
          ),
        );
      case "linkPaste":
        return Container(
          alignment: Alignment.centerLeft,
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
          child: IconButton(
            onPressed: () {
              final Post post = cell.value;
              Clipboard.setData(ClipboardData(text: post.id.toString()));
            },
            icon: const Icon(Icons.link),
          ),
        );
      default:
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
          child: Text(
            cell.value.toString(),
            style: testStyle,
          ),
        );
    }
  }
}
