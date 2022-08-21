import 'package:coin_watch/blocs/asset_price_history/asset_price_history_bloc.dart';
import 'package:coin_watch/components/base_scaffold.dart';
import 'package:coin_watch/components/price_chart.dart';
import 'package:coin_watch/utils/extensions.dart';
import 'package:coin_watch/components/asset_detail_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AssetDetailScreen extends StatelessWidget {
  AssetDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: BlocBuilder<AssetPriceHistoryBloc, AssetPriceHistoryState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  if (state.selectedAsset != null) ...{
                    SizedBox(height: 30),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF222222),
                            ),
                          ),
                          child: IconButton(
                            splashRadius: 20,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(Icons.arrow_back_ios_new),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Text(
                          'Statistics',
                          style: context.textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    AssetDetailRow(
                      asset: state.selectedAsset!,
                    )
                  },
                  if (state.isSuccess && (state.priceHistory?.isNotEmpty ?? false)) ...{
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Today's Chart",
                      style: context.textTheme.headlineSmall,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 400,
                      margin: EdgeInsets.all(8),
                      child: PriceChart(state: state),
                    )
                  } else ...{
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      ),
                    )
                  }
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
