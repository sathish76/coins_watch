import 'package:coin_watch/blocs/asset_price_history/asset_price_history_bloc.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mrx_charts/mrx_charts.dart';

class PriceChart extends StatelessWidget {
  const PriceChart({Key? key, required this.state}) : super(key: key);

  final AssetPriceHistoryState state;

  @override
  Widget build(BuildContext context) {
    return Chart(
      layers: layers(state),
      padding: const EdgeInsets.symmetric(horizontal: 12.0).copyWith(
        bottom: 12.0,
      ),
    );
  }

  List<ChartLayer> layers(AssetPriceHistoryState state) {
    return [
      ChartAxisLayer(
        settings: ChartAxisSettings(
          x: ChartAxisSettingsAxis(
            frequency: state.candleStickTimeFrame!,
            max: state.endTime!,
            min: state.startTime!,
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
          y: ChartAxisSettingsAxis(
            frequency: state.yAxisPriceUnit!,
            max: state.maxPrice!,
            min: state.minPrice!,
            textStyle: TextStyle(
              color: Colors.white.withOpacity(0.6),
              fontSize: 10.0,
            ),
          ),
        ),
        labelX: (value) => DateFormat('hh').format(DateTime.fromMillisecondsSinceEpoch(value.toInt())),
        labelY: (value) => value.toInt().toString(),
      ),
      ChartCandleLayer(
        items: state.priceHistory!.map((e) => prepareCandle(e.close!, e.open!, e.low!, e.high!, e.period!)).toList(),
        settings: const ChartCandleSettings(),
      ),
    ];
  }

  ChartCandleDataItem prepareCandle(double open, double close, double low, double high, double x) {
    return ChartCandleDataItem(
      color: open > close ? Colors.green : Colors.red,
      value1: ChartCandleDataItemValue(
        max: close,
        min: open,
      ),
      value2: ChartCandleDataItemValue(
        max: high,
        min: low,
      ),
      x: x,
    );
  }
}
