part of '../screen.dart';

class _SearchRankingWidget extends StatelessWidget {
  final SearchRanking searchRanking;

  const _SearchRankingWidget({
    required this.searchRanking,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        searchRanking.type?.assetPath ?? 'assets/images/ic_fire.svg',
                        width: 20,
                        height: 20,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        searchRanking.title ?? '인기 랭킹',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    searchRanking.baseDateTime ?? '현재 기준',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          searchRanking.stocks?.isEmpty == true
              ? SizedBox(
                  height: 185.0,
                  child: Center(
                    child: Text(
                      '집계중입니다.',
                      style: TextStyle(color: Colors.grey.shade400),
                    ),
                  ),
                )
              : Container(
                  height: 185.0,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GlowingOverscrollIndicator(
                    showLeading: false,
                    showTrailing: false,
                    axisDirection: AxisDirection.down,
                    color: Colors.transparent,
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      itemCount: searchRanking.stocks?.length ?? 0,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          onTap: () {
                            context.router.pushNamed('/stock/${searchRanking.stocks?[index].code}');
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 25,
                                height: 25,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle, color: AppTheme.primaryColor.shade200),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: Text(
                                    '${index + 1}',
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${searchRanking.stocks?[index].name ?? '종목명'}(${searchRanking.stocks?[index].code ?? '종목코드'})',
                                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
        ],
      ),
    );
  }
}
