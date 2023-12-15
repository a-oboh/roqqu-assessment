import 'package:flutter/material.dart';
import 'package:roqqu_test_app/src/common/common.dart';

class CryptoCandlePainter extends CustomPainter {
  final List<TimeSeries>? timeSeries;
  final double _candleWidth = 3;
  final double _wickWidth = 1;
  final Paint _lossPaint;
  final Paint _gainPaint;
  final Paint _wickPaint;

  CryptoCandlePainter({required this.timeSeries})
      : _gainPaint = Paint()..color = Colors.green,
        _lossPaint = Paint()..color = Colors.red,
        _wickPaint = Paint()..color = Colors.grey;
  @override
  void paint(Canvas canvas, Size size) {
    if (timeSeries == null) {
      return;
    }
    final List<CandleStick> candleSticks = _generateSticks(size);

    for (final CandleStick candleStick in candleSticks) {
      canvas.drawRect(
        Rect.fromLTRB(
          candleStick.center - (_wickWidth / 2),
          size.height - candleStick.wickHigh,
          candleStick.center + (_wickWidth / 2),
          size.height - candleStick.wickLow,
        ),
        _wickPaint,
      );

      // ignore: cascade_invocations
      canvas.drawRect(
        Rect.fromLTRB(
          candleStick.center - (_candleWidth / 2),
          size.height - candleStick.candleHigh,
          candleStick.center + (_candleWidth / 2),
          size.height - candleStick.candleLow,
        ),
        candleStick.candlePaint,
      );
    }
  }

  List<CandleStick> _generateSticks(Size availableSpace) {
    //the greatest high in a time series
    final TimeSeries cryptoHigh =
        timeSeries!.reduce((a, b) => a.high! > b.high! ? a : b);
    //the lowest low in a time series
    final TimeSeries cryptoLow =
        timeSeries!.reduce((a, b) => a.low! < b.low! ? a : b);

    final double pixelPerStick =
        availableSpace.width / (timeSeries!.length + 1);

    final double pixelPerPrice =
        availableSpace.height / (cryptoHigh.high! - cryptoLow.low!);

    final List<CandleStick> candleSticks = [];
    for (int i = 0; i < timeSeries!.length; ++i) {
      final TimeSeries series = timeSeries![i];
      candleSticks.add(
        CandleStick(
            candleHigh: (series.open! - cryptoLow.low!) * pixelPerPrice,
            candleLow: (series.close! - cryptoLow.low!) * pixelPerPrice,
            candlePaint: series.open! > series.close! ? _lossPaint : _gainPaint,
            center: (i + 1) * pixelPerStick,
            wickHigh: (series.high! - cryptoLow.low!) * pixelPerPrice,
            wickLow: (series.low! - cryptoLow.low!) * pixelPerPrice),
      );
    }
    return candleSticks;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CandleStick {
  final double wickHigh;
  final double wickLow;
  final double candleHigh;
  final double candleLow;
  final double center;
  final Paint candlePaint;

  CandleStick(
      {required this.center,
      required this.candlePaint,
      required this.wickHigh,
      required this.wickLow,
      required this.candleHigh,
      required this.candleLow});
}