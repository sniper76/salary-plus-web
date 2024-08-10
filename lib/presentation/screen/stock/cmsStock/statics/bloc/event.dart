part of 'bloc.dart';

@immutable
abstract class CmsEvent {
  const CmsEvent._();

  const factory CmsEvent.init(StockDetail stockDetail, String periodDaliy, String periodMonthly) = CmsOnInit;

  const factory CmsEvent.getStockQuantity(String periodStockQuantityDaliy, String periodStockQuantityMonthly) =
      CmsOnGetStockQuantity;

  const factory CmsEvent.getMemberCount(String periodMemberCountDaliy, String periodMemberCountMonthly) =
      CmsOnGetMemberCount;

  const factory CmsEvent.getMakeValue(String periodMarketValueDaliy, String periodMarketValueMonthly) =
      CmsOnGetMakeValue;

  const factory CmsEvent.getStake(String periodStakeDaliy, String periodStakeMonthly) = CmsOnGetStake;

  const factory CmsEvent.setOpenState(int index) = CmsOnSetOpenState;

  const factory CmsEvent.setPeriodDaily(StaticsType index, String period) = CmsOnSetPeriodDaily;

  const factory CmsEvent.setPeriodMonthly(StaticsType index, String period) = CmsOnSetPeriodMonthly;
}

class CmsOnInit extends CmsEvent {
  final StockDetail stockDetail;
  final String periodDaliy;
  final String periodMonthly;

  const CmsOnInit(this.stockDetail, this.periodDaliy, this.periodMonthly) : super._();
}

class CmsOnGetStockQuantity extends CmsEvent {
  final String periodStockQuantityDaliy;
  final String periodStockQuantityMonthly;

  const CmsOnGetStockQuantity(this.periodStockQuantityDaliy, this.periodStockQuantityMonthly) : super._();
}

class CmsOnGetMemberCount extends CmsEvent {
  final String periodMemberCountDaliy;
  final String periodMemberCountMonthly;

  const CmsOnGetMemberCount(this.periodMemberCountDaliy, this.periodMemberCountMonthly) : super._();
}

class CmsOnGetMakeValue extends CmsEvent {
  final String periodMarketValueDaliy;
  final String periodMarketValueMonthly;

  const CmsOnGetMakeValue(this.periodMarketValueDaliy, this.periodMarketValueMonthly) : super._();
}

class CmsOnGetStake extends CmsEvent {
  final String periodStakeDaliy;
  final String periodStakeMonthly;

  const CmsOnGetStake(this.periodStakeDaliy, this.periodStakeMonthly) : super._();
}

class CmsOnSetOpenState extends CmsEvent {
  final int index;

  const CmsOnSetOpenState(this.index) : super._();
}

class CmsOnSetPeriodDaily extends CmsEvent {
  final StaticsType index;
  final String period;

  const CmsOnSetPeriodDaily(this.index, this.period) : super._();
}

class CmsOnSetPeriodMonthly extends CmsEvent {
  final StaticsType index;
  final String period;

  const CmsOnSetPeriodMonthly(this.index, this.period) : super._();
}
