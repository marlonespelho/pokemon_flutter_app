import 'package:flutter/material.dart';
import 'package:pokemon_app/core/design/widgets/main.dart';
import 'package:pokemon_app/modules/home/models/stat.dart';

class StatsTabWidget extends StatelessWidget {
  final List<Stat> stats;

  const StatsTabWidget({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ...stats.map(
            (stat) => RowTextLabel(
              label: stat.name,
              crossAxisAlignment: CrossAxisAlignment.center,
              value: LinearProgressIndicator(
                color: Colors.green,
                value: stat.baseStat / 100,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
