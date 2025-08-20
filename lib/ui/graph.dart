
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildGraph(List<double> frequencies) {
  if (frequencies.isEmpty) {
    return const Text("No frequency data yet.");
  }

  return SizedBox(
    height: 200,
    child: LineChart(
      LineChartData(
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: true, reservedSize: 40),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(show: true),
        borderData: FlBorderData(show: true),
        lineBarsData: [
          LineChartBarData(
            spots: frequencies.asMap().entries.map((entry) {
              return FlSpot(entry.key.toDouble(), entry.value);
            }).toList(),
            isCurved: true,
            barWidth: 2,
            belowBarData: BarAreaData(show: false),
            dotData: FlDotData(show: false),
          )
        ],
      ),
    ),
  );
}