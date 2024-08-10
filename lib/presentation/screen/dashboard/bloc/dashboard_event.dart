part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {
  const DashboardEvent._();

  const factory DashboardEvent.init(String mode) = DashboardOnInit;

  const factory DashboardEvent.monthly(String mode) = DashboardOnMonthly;

  const factory DashboardEvent.daily(String mode) = DashboardOnDaily;

  const factory DashboardEvent.dashboardOnSelectCategory(String selectedCategory) = DashboardOnSelectCategory;

  const factory DashboardEvent.searchKeyword(String searchKeyword) = PostOnSetTargetSearchKeyword;

  const factory DashboardEvent.setStock(SimpleStock stock) = PostOnSetSimpleStock;

  const factory DashboardEvent.getStockStats(SimpleStock stock) = PostOnGetStockStats;

  const factory DashboardEvent.getAllStockStats() = PostOnGetAllStockStats;
}

class DashboardOnInit extends DashboardEvent {
  final String mode;

  const DashboardOnInit(this.mode) : super._();
}

class DashboardOnMonthly extends DashboardEvent {
  final String mode;

  const DashboardOnMonthly(this.mode) : super._();
}

class DashboardOnDaily extends DashboardEvent {
  final String mode;

  const DashboardOnDaily(this.mode) : super._();
}

class DashboardOnSelectCategory extends DashboardEvent {
  final String selectedCategory;

  const DashboardOnSelectCategory(this.selectedCategory) : super._();
}

class PostOnSetTargetSearchKeyword extends DashboardEvent {
  final String searchKeyword;

  const PostOnSetTargetSearchKeyword(this.searchKeyword) : super._();
}

class PostOnSetSimpleStock extends DashboardEvent {
  final SimpleStock stock;

  const PostOnSetSimpleStock(this.stock) : super._();
}

class PostOnGetStockStats extends DashboardEvent {
  final SimpleStock stock;

  const PostOnGetStockStats(this.stock) : super._();
}

class PostOnGetAllStockStats extends DashboardEvent {
  const PostOnGetAllStockStats() : super._();
}
