import 'dart:math';

import 'package:act_cms/presentation/base/base_constant.dart';
import 'package:act_cms/presentation/widget/grid/AlignedDataGridCell.dart';
import 'package:act_cms/presentation/widget/grid/data_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

List<CustomColumn> refineColumns(List<CustomColumn> columns, double maxWidth) {
  final totalWidth = columns.fold(0.0, (previousValue, element) {
    return previousValue + (element.width ?? 0);
  });

  CustomColumn? expandableColumn = columns.firstWhere((element) => element.width == null);

  expandableColumn.setWidth(max(maxWidth - totalWidth, 180.0));

  return columns;
}

class CustomColumn {
  double? width;
  final String columnName;
  final String labelText;

  CustomColumn({this.width, required this.columnName, required this.labelText});

  setWidth(double? width) {
    this.width = width;
  }
}

const apiLoadSize = 20;

class GenericDataSource<T> extends DataGridSource {
  static const textStyle = TextStyle(fontSize: 12.0, fontWeight: FontWeight.normal);

  final List<T> data;
  final List<String> columnNames;
  final Map<String, dynamic Function(T, int index)> valueExtractors;
  final Map<String, Alignment> columnAlignments;
  final Map<String, Widget Function(T)> customWidgets;

  GenericDataSource({
    required this.data,
    required this.columnNames,
    required this.valueExtractors,
    this.columnAlignments = const {},
    this.customWidgets = const {},
  }) {
    dataGridRows = data.asMap().entries.map<DataGridRow>((entry) {
      int index = entry.key;
      T item = entry.value;
      return DataGridRow(
          cells: columnNames.map<DataGridCell>((columnName) {
        var valueExtractor = valueExtractors[columnName];
        var cellValue = valueExtractor != null ? valueExtractor(item, index) : '-';

        return AlignedDataGridCell<dynamic>(
          columnName: columnName,
          value: cellValue,
          alignment: columnAlignments[columnName] ?? Alignment.center,
        );
      }).toList());
    }).toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        var alignedCell = cell as AlignedDataGridCell;
        if (customWidgets[cell.columnName] != null) {
          return Container(
            alignment: alignedCell.alignment,
            decoration: const BoxDecoration(border: Border(top: BorderSide(color: Color(0xffD9D9D9), width: 0.5))),
            child: customWidgets[cell.columnName]!(cell.value),
          );
        }

        return DataGridItem(
          alignment: alignedCell.alignment,
          label: alignedCell.value.toString(),
        );
      }).toList(),
    );
  }
}

class ActDataGrid extends StatelessWidget {
  final List<CustomColumn> columns;
  final DataGridSource dataSource;
  final Function(DataGridCellTapDetails)? onCellTap;
  final double? rowHeight;

  const ActDataGrid({
    super.key,
    this.onCellTap,
    this.rowHeight,
    required this.columns,
    required this.dataSource,
  });

  @override
  Widget build(BuildContext context) {
    return SfDataGrid(
      shrinkWrapRows: true,
      shrinkWrapColumns: true,
      columnWidthMode: ColumnWidthMode.fitByCellValue,
      columns: columns.map((column) {
        return GridColumn(
          columnName: column.columnName,
          label: Container(
            padding: const EdgeInsets.all(4.0),
            decoration: sfTableBoxStyle,
            child: Center(
                child: Text(
              column.labelText,
              style: sfTableTextStyle,
            )),
          ),
          width: column.width ?? double.nan,
        );
      }).toList(),
      onCellTap: onCellTap,
      headerRowHeight: rowHeight ?? 32,
      rowHeight: rowHeight ?? 32,
      headerGridLinesVisibility: GridLinesVisibility.none,
      gridLinesVisibility: GridLinesVisibility.none,
      source: dataSource,
    );
  }
}
