part of '../screen.dart';

class _MySolidarityListWidget extends StatelessWidget {
  final List<Solidarity> mySolidarityList;
  final Paging mySolidarityPaging;
  final Function(int page) onChangePage;
  final Function() onTapSolidarityOrderUpdateButton;

  const _MySolidarityListWidget({
    required this.mySolidarityList,
    required this.mySolidarityPaging,
    required this.onChangePage,
    required this.onTapSolidarityOrderUpdateButton,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ActListTitleWidget(
          titleSvgAssetPath: 'assets/images/ic_my_solidarity.svg',
          titleText: 'MY 주주연대',
          trailingWidget: InkWell(
            onTap: onTapSolidarityOrderUpdateButton,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/images/ic_setting.svg',
                  width: 24.0,
                ),
                const SizedBox(width: 4.0),
                Text(
                  '종목편집',
                  style: context.textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
        Divider(height: 1, color: Colors.grey.shade300),
        ...List.generate(
          mySolidarityList.length,
          (index) => Column(
            children: [
              if (index != 0) Divider(height: 1, color: Colors.grey.shade300),
              MySolidarityListItemWidget(solidarity: mySolidarityList[index]),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ActPagination<StockBloc, StockState>(
          paging: mySolidarityPaging,
          onChangePage: onChangePage,
        ),
      ],
    );
  }
}
