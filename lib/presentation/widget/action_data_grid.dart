import 'package:act_cms/core/extension/datetime_extension.dart';
import 'package:act_cms/core/route/app_router.dart';
import 'package:act_cms/domain/model/board_group_category.dart';
import 'package:act_cms/domain/model/enum/digital_document_type.dart';
import 'package:act_cms/domain/model/enum/post_status_type.dart';
import 'package:act_cms/domain/model/post.dart';
import 'package:act_cms/presentation/util/convert_column.dart';
import 'package:act_cms/presentation/widget/act_data_grid.dart';
import 'package:act_cms/presentation/widget/grid/data_grid_title_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum ActionCategory {
  category,
  stock,
  title,
  status,
  startAt,
  expireAt,
  memberCount,
  stockCount,
  download,
  linkPaste,
}

class ActionDataGrid extends StatefulWidget {
  final List<Post> postList;
  final List<ActionCategory> filterList;
  final Widget pagination;
  final void Function(Post post)? onHandleReferenceDate;
  final void Function(Post post)? onDownloadExcel;
  final void Function(Post post)? onDownloadZipFile;
  final void Function(Post post)? onMoveDetailScreen;

  const ActionDataGrid({
    super.key,
    required this.postList,
    this.filterList = const [],
    required this.pagination,
    this.onHandleReferenceDate,
    this.onDownloadExcel,
    this.onDownloadZipFile,
    this.onMoveDetailScreen,
  });

  @override
  State<ActionDataGrid> createState() => _ActionDataGridState();
}

class _ActionDataGridState extends State<ActionDataGrid> {
  String _formatPercentage(int? stockSumCount, int? totalStockCount) {
    if (stockSumCount == null || totalStockCount == null || totalStockCount <= 0) {
      return '';
    }

    return ' (${((stockSumCount / totalStockCount) * 100).toStringAsFixed(2)}%)';
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final columns = [
                CustomColumn(width: 100, columnName: '${ActionCategory.category}', labelText: '카테고리'),
                CustomColumn(width: 100, columnName: '${ActionCategory.stock}', labelText: '종목'),
                // width가 없는 column은 expand된다. 하나는 width가 없어야 한다.
                CustomColumn(columnName: '${ActionCategory.title}', labelText: '제목'),
                CustomColumn(width: 80, columnName: '${ActionCategory.status}', labelText: '상태'),
                CustomColumn(width: 100, columnName: '${ActionCategory.startAt}', labelText: '시작일'),
                CustomColumn(width: 100, columnName: '${ActionCategory.expireAt}', labelText: '종료일'),
                CustomColumn(width: 100, columnName: '${ActionCategory.memberCount}', labelText: '참여인원'),
                CustomColumn(width: 150, columnName: '${ActionCategory.stockCount}', labelText: '참여주식수'),
                CustomColumn(width: 150, columnName: '${ActionCategory.download}', labelText: ''),
                CustomColumn(width: 50, columnName: '${ActionCategory.linkPaste}', labelText: ''),
              ];
              final filteredList = columns
                  .where((column) =>
                      !widget.filterList.map((condition) => condition.toString()).contains(column.columnName))
                  .toList();
              return ConstrainedBox(
                constraints: BoxConstraints(minWidth: constraints.maxWidth),
                child: ActDataGrid(
                  dataSource: GenericDataSource<Post>(
                      data: widget.postList,
                      columnNames: filteredList.map((e) => e.columnName).toList(),
                      valueExtractors: {
                        '${ActionCategory.category}': (Post item, int index) => item.boardGroupCategory?.displayName,
                        '${ActionCategory.stock}': (Post item, int index) => item.stock?.name,
                        '${ActionCategory.title}': (Post item, int index) => item,
                        '${ActionCategory.status}': (Post item, int index) => item.status.title,
                        '${ActionCategory.startAt}': (Post item, int index) => item.polls?.isNotEmpty == true
                            ? item.polls!.first.targetStartDate?.toFormatString()
                            : item.digitalDocument?.targetStartDate?.toFormatString(),
                        '${ActionCategory.expireAt}': (Post item, int index) => item.polls?.isNotEmpty == true
                            ? item.polls!.first.targetEndDate?.toFormatString()
                            : item.digitalDocument?.targetEndDate?.toFormatString(),
                        '${ActionCategory.memberCount}': (Post item, int index) => ConvertColumn.formatNumber(
                            item.digitalDocument?.joinUserCount ?? (item.polls?.firstOrNull?.voteTotalCount)),
                        '${ActionCategory.stockCount}': (Post item, int index) {
                          int? joinStockSum =
                              item.digitalDocument?.joinStockSum ?? item.polls?.firstOrNull?.voteTotalStockSum;
                          int? totalIssuedQuantity = item.stock?.totalIssuedQuantity;

                          String formattedJoinStockSum = ConvertColumn.formatNumber(joinStockSum);

                          String percentage = _formatPercentage(joinStockSum, totalIssuedQuantity);

                          return '$formattedJoinStockSum$percentage';
                        },
                        '${ActionCategory.download}': (Post item, int index) => item,
                        '${ActionCategory.linkPaste}': (Post item, int index) => item,
                      },
                      columnAlignments: {
                        '${ActionCategory.title}': Alignment.centerLeft,
                      },
                      customWidgets: {
                        '${ActionCategory.linkPaste}': (Post item) {
                          return Container(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              onPressed: () {
                                Clipboard.setData(ClipboardData(text: item.id.toString()));
                              },
                              icon: const Icon(Icons.link),
                            ),
                          );
                        },
                        '${ActionCategory.download}': (Post item) {
                          return _buildDownloadButton(item);
                        },
                        '${ActionCategory.title}': (Post post) =>
                            DataGridTitleItem(title: post.title, isAttachment: post.thumbnailImageUrl?.isNotEmpty),
                      }),
                  columns: refineColumns(filteredList, constraints.maxWidth),
                  onCellTap: (details) {
                    final rowIndex = details.rowColumnIndex.rowIndex - 1;
                    if (rowIndex < 0) {
                      return;
                    }

                    if (widget.onMoveDetailScreen != null) widget.onMoveDetailScreen!(widget.postList[rowIndex]);
                  },
                ),
              );
            },
          ),
          widget.pagination
        ],
      ),
    );
  }

  Widget _buildDownloadButton(Post post) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ((post.boardGroupCategory?.name == BoardGroupCategory.delegate().name &&
                    (post.digitalDocument?.documentType) == DigitalDocumentType.digitalProxy) &&
                (DateTime.now().isBefore(
                  post.digitalDocument!.targetStartDate!.subtract(const Duration(days: 1)).add(
                        const Duration(hours: 23, minutes: 59, seconds: 59),
                      ),
                )) &&
                widget.onHandleReferenceDate != null)
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () {
                    widget.onHandleReferenceDate!(post);
                  },
                  child: SvgPicture.asset('assets/images/ic_calendar.svg'),
                ),
              )
            : const SizedBox(
                width: 20,
                child: Text(
                  "-",
                  textAlign: TextAlign.center,
                ),
              ),
        (post.digitalDocument == null)
            ? const SizedBox(
                width: 30,
                child: Text(
                  "-",
                  textAlign: TextAlign.center,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () {
                    if (widget.onDownloadExcel != null) widget.onDownloadExcel!(post);
                  },
                  child: SvgPicture.asset('assets/images/ic_xlsx.svg'),
                ),
              ),
        (post.digitalDocument == null)
            ? const SizedBox(
                width: 32,
                child: Text(
                  "-",
                  textAlign: TextAlign.center,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () {
                    context.router.push(DigitalDocumentUsersRoute(
                      id: post.digitalDocument!.id,
                      title: "[${post.stock?.name}]${post.title}",
                    ));
                  },
                  child: SvgPicture.asset('assets/images/ic_users.svg'),
                ),
              ),
        (post.digitalDocument == null)
            ? const SizedBox(
                width: 32,
                child: Text(
                  "-",
                  textAlign: TextAlign.center,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: InkWell(
                  onTap: () {
                    if (widget.onDownloadZipFile != null) widget.onDownloadZipFile!(post);
                  },
                  child: SvgPicture.asset('assets/images/ic_download.svg'),
                ),
              ),
      ],
    );
  }
}
