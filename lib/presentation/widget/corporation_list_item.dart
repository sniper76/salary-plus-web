import 'package:act_cms/domain/model/corporation_user.dart';
import 'package:act_cms/presentation/widget/solidarity_leader_badge.dart';
import 'package:flutter/material.dart';

class CorporationListItem extends StatelessWidget {
  final CorporationUser corporation;
  final void Function()? onTab;

  const CorporationListItem({super.key, required this.corporation, this.onTab});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTab,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: _buildCorporationItem(),
      ),
    );
  }

  Widget _buildCorporationItem() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _buildCorporationInfo(corporation.corporateName),
        _buildCorporationInfo(corporation.corporateNo),
        const Spacer(),
        if (corporation.leadingSolidarityStockCodes.isEmpty)
          const SizedBox(height: 40, width: 100, child: SolidarityLeaderBadge()),
      ],
    );
  }

  Widget _buildCorporationInfo(String value) {
    return Expanded(child: Text(value, maxLines: 1, overflow: TextOverflow.ellipsis));
  }
}
