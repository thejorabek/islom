

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final Duration current;
  final Duration total;
  final ValueChanged<Duration> onSeek;

  const ProgressBar({
    Key? key,
    required this.current,
    required this.total,
    required this.onSeek,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(formatDuration(current)),
            Text(formatDuration(total)),
          ],
        ),
        Slider(
          min: 0.0,
          max: total.inMilliseconds.toDouble(),
          value: current.inMilliseconds.clamp(0, total.inMilliseconds).toDouble(),
          onChanged: (value) {
            onSeek(Duration(milliseconds: value.round()));
          },
        ),
      ],
    );
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
}

class PositionData {
  final Duration position;
  final Duration duration;

  PositionData(this.position, this.duration);
}