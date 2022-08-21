import 'package:coin_watch/models/asset.dart';
import 'package:coin_watch/router.dart';
import 'package:flutter/material.dart';
import '../utils/extensions.dart';

class AssetDetailRow extends StatelessWidget {
  const AssetDetailRow({Key? key, required this.asset}) : super(key: key);

  final Asset asset;

  @override
  Widget build(BuildContext context) {
    final readablePercentage = asset.changePercent24Hr!.readablePercentage;
    final isPositiveForLas24Hr = !readablePercentage.contains('-');
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.ASSET_DETAIL_SCREEN, arguments: {'asset': asset});
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          children: [
            Container(
              width: 70,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFF222222), borderRadius: BorderRadius.circular(15)),
              child: Center(
                  child: Text(
                asset.symbol!,
                style: context.textTheme.bodySmall,
              )),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  asset.name!,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '24hr Vol: ${asset.volumeUsd24Hr!}',
                  style: context.textTheme.bodySmall,
                )
              ],
            ),
            const Spacer(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  r"$" + asset.priceUsd!,
                  style: context.textTheme.titleMedium,
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Icon(
                      isPositiveForLas24Hr ? Icons.arrow_drop_up_rounded : Icons.arrow_drop_down_rounded,
                      color: isPositiveForLas24Hr ? Colors.green : Colors.red,
                    ),
                    Text(
                      asset.changePercent24Hr!,
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
