import 'package:act_cms/core/extension/context_extension.dart';
import 'package:act_cms/core/extension/number_extension.dart';
import 'package:act_cms/core/extension/string_extension.dart';
import 'package:act_cms/domain/model/solidarity.dart';
import 'package:act_cms/presentation/widget/app_rounded_button.dart';
import 'package:act_cms/presentation/widget/ripple_effect_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HoldingStockListItem extends StatelessWidget {
  final Solidarity solidarity;
  final VoidCallback? onTap;
  final VoidCallback? onShare;

  const HoldingStockListItem({
    super.key,
    required this.solidarity,
    this.onTap,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    return RippleEffectButton(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  children: [
                    ClipOval(
                      child: Container(
                        width: 32,
                        height: 32,
                        color: Colors.grey.shade100,
                        child: CachedNetworkImage(
                          imageUrl: solidarity.stockLogoUrl,
                          placeholder: (context, url) {
                            return CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.grey.shade100,
                            );
                          },
                          errorWidget: (context, url, data) {
                            return CircleAvatar(
                              radius: 10,
                              backgroundColor: Colors.grey.shade100,
                            );
                          },
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Text(
                          solidarity.name,
                          style: context.textTheme.headlineSmall,
                        ),
                        Text(
                          solidarity.code,
                          style: context.textTheme.titleLarge?.copyWith(color: Colors.grey.shade400),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                if (solidarity.isActive)
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.end,
                    direction: Axis.vertical,
                    children: [
                      Text(
                        '${solidarity.memberCount.toNumberFormat} 명',
                        style: context.textTheme.headlineSmall?.copyWith(color: context.colorScheme.primary),
                      ),
                      Text(
                        '${solidarity.stake.toStringAsFixed(2)} %',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                if (!solidarity.isActive)
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    direction: Axis.horizontal,
                    spacing: 8,
                    children: [
                      Text(
                        '${solidarity.memberCount}/${solidarity.minThresholdMemberCount}명\n${(solidarity.stake).toStringAsFixed(2)}%',
                        style: context.textTheme.bodySmall?.copyWith(color: Colors.grey.shade500),
                        textAlign: TextAlign.end,
                      ),
                    ],
                  ),
                const SizedBox(width: 20),
                AppRoundedButton(
                  sizeType: SizeType.small,
                  text: '초대',
                  textStyle: context.textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                    height: 1.2,
                  ),
                  backgroundColor: context.colorScheme.secondary,
                  onPressed: onShare,
                ),
              ],
            ),
            if (solidarity.links != null && solidarity.links?.isNotEmpty == true)
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: 12),
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 4,
                  children: [
                    ...solidarity.links!.map(
                      (e) => InkWell(
                        onTap: () => context.openLink(e.url),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: e.color.toColor(),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            e.title,
                            style: context.textTheme.headlineSmall?.copyWith(
                              color: Colors.white,
                              height: 1.25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
