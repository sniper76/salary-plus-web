import 'package:act_web/domain/model/stock/solidarity.dart';
import 'package:act_web/domain/repository/home_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class UpdateMySolidarityDisplayOrder {
  final HomeRepository repository;

  const UpdateMySolidarityDisplayOrder({required this.repository});

  Future<Result<List<Solidarity>, Exception>> call(List<String> orderedActiveStockCodes) {
    return repository.updateMySolidarityDisplayOrder(orderedActiveStockCodes);
  }
}
