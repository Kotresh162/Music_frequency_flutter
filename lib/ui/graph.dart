import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AudioGraphs extends StatelessWidget {
  final List<double> fftData;
  final List<double> waveData;

  const AudioGraphs({super.key, required this.fftData, required this.waveData});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // FFT Data
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: List.generate(
                fftData.length,
                    (i) => BarChartGroupData(
                  x: i,
                  barRods: [
                    BarChartRodData(
                      toY: fftData[i],
                      color: Colors.yellow,
                      width: 2,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Waveform Data
        SizedBox(
          height: 200,
          child: LineChart(
            LineChartData(
              titlesData: FlTitlesData(show: false),
              gridData: FlGridData(show: false),
              borderData: FlBorderData(show: false),
              lineBarsData: [
                LineChartBarData(
                  spots: List.generate(
                    waveData.length,
                        (i) => FlSpot(i.toDouble(), waveData[i]),
                  ),
                  isCurved: false,
                  color: Colors.yellow,
                  barWidth: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
