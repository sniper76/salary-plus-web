import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class AlignedDataGridCell<T> extends DataGridCell<T> {
  AlignedDataGridCell({
    required String columnName,
    required T? value,
    this.alignment = Alignment.center,
  }) : super(columnName: columnName, value: value);

  final Alignment alignment;
}
