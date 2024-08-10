import 'package:act_cms/domain/model/solidarity.dart';
import 'package:act_cms/domain/repository/admin_solidarity_repository.dart';
import 'package:multiple_result/multiple_result.dart';

class SetSolidarlityActive {
  final AdminSolidarityRepository repository;

  const SetSolidarlityActive({required this.repository});

  Future<Result<Solidarity, Exception>> call({required int solidarityId, required int solidarityApplicantId}) {
    return repository.setActive(solidarityId);
  }
}
