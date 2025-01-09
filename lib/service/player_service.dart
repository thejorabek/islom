import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final Duration current;
  final Duration total;
  final ValueChanged<Duration> onSeek;

  const ProgressBar({
    super.key,
    required this.current,
    required this.total,
    required this.onSeek,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              formatDuration(current),
              style: const TextStyle(color: Colors.white, fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
            ),
            Text(
              formatDuration(total),
              style: const TextStyle(color: Colors.white, fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Slider(
          min: 0.0,
          max: total.inMilliseconds.toDouble(),
          value: current.inMilliseconds.clamp(0, total.inMilliseconds).toDouble(),
          activeColor: const Color(0xFF30638E),
          // ignore: deprecated_member_use
          inactiveColor: const Color.fromARGB(255, 71, 138, 192).withOpacity(0.3),
          secondaryActiveColor: Colors.white,
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
