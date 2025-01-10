import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islom/bloc/surah_bloc/one_surah_bloc.dart';
import 'package:islom/bloc/surah_bloc/one_surah_state.dart';
import 'package:islom/service/player_service.dart';
import 'package:islom/utils/colors/colors.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lottie/lottie.dart';
import 'package:rxdart/rxdart.dart';

class OneSurahPage extends StatefulWidget {
  final int? surahNumber;

  const OneSurahPage({Key? key, this.surahNumber}) : super(key: key);

  @override
  State<OneSurahPage> createState() => _OneSurahPageState();
}

class _OneSurahPageState extends State<OneSurahPage> {
  late AudioPlayer _audioPlayer;
  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      // Show loading state while preparing
      setState(() {
        _isLoading = true;
      });

      // Format surah number with leading zeros
      final formattedNumber = widget.surahNumber.toString().padLeft(3, '0');
      final url = 'https://server8.mp3quran.net/afs/$formattedNumber.mp3';
      await _audioPlayer.setUrl(url);

      // Hide loading state after successful preparation
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error initializing audio: $e');
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose the player when the page is closed
    super.dispose();
  }

  Stream<PositionData> get _positionDataStream => Rx.combineLatest2<Duration, Duration?, PositionData>(
        _audioPlayer.positionStream,
        _audioPlayer.durationStream,
        (position, duration) => PositionData(
          position,
          duration ?? Duration.zero,
        ),
      );

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CustomColors.background,
      appBar: AppBar(
        backgroundColor: CustomColors.background,
        iconTheme: IconThemeData(color: Colors.white),
        title: BlocBuilder<OneSurahBloc, OneSurahState>(
          builder: (context, state) {
            if (state is OneSurahLoaded) {
              return Text(
                state.surah.data?.englishName ?? '',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'Quicksand'),
              );
            }
            return Text('');
          },
        ),
        leading: IconButton(onPressed: () => context.push('/main'), icon: Icon(Icons.arrow_back_ios_new_outlined)),
      ),
      body: BlocBuilder<OneSurahBloc, OneSurahState>(
        builder: (context, state) {
          if (state is OneSurahLoading) {
            return Center(
              child: Lottie.asset('assets/lotties/loading.json', width: width * 0.3, height: height * 0.3),
            );
          } else if (state is OneSurahLoaded) {
            final surah = state.surah.data;
            return Stack(
              children: [
                ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'Quicksand', color: Colors.white)),
                    ...surah?.ayahs?.map((ayah) {
                          return ListTile(
                            title: Container(
                                decoration: BoxDecoration(color: CustomColors.tile, borderRadius: BorderRadius.circular(13)),
                                width: width * 0.9,
                                height: height * 0.04,
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.transparent,
                                      child: Text(
                                        '${ayah.numberInSurah}',
                                        style: TextStyle(fontSize: 18, color: Colors.white, fontFamily: 'Quicksand'),
                                      ),
                                    ),
                                    // Spacer(),
                                    // IconButton(onPressed: () => {}, icon: Icon(Icons.ios_share_outlined, color: Colors.white)),
                                    // IconButton(onPressed: () => {}, icon: Icon(Icons.play_circle_outline_rounded, color: Colors.white)),
                                    // IconButton(onPressed: () => {}, icon: Icon(Icons.bookmark_border_outlined, color: Colors.white)),
                                  ],
                                )),
                            subtitle: Padding(
                              padding: EdgeInsets.only(top: 8.0),
                              child: Text(
                                ayah.text ?? '',
                                style: TextStyle(fontSize: 23, color: Colors.white, fontFamily: 'Quicksand'),
                              ),
                            ),
                          );
                        }) ??
                        [],
                    SizedBox(height: height * .17)
                  ],
                ),
                Positioned(
                  top: height * .675,
                  left: width * .05,
                  right: width * .05,
                  child: Container(
                    decoration: BoxDecoration(color: CustomColors.tile, borderRadius: BorderRadius.circular(45)),
                    width: width,
                    height: height * 0.18,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: width * .1, right: width * .1),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    onPressed: () => _audioPlayer.seek(
                                          _audioPlayer.position - Duration(seconds: 10),
                                        ),
                                    icon: Icon(Icons.replay_10_outlined, color: Colors.white, size: 40)),
                                StreamBuilder<PlayerState>(
                                  stream: _audioPlayer.playerStateStream,
                                  builder: (context, snapshot) {
                                    if (_isLoading) {
                                      return CircularProgressIndicator(color: Colors.white);
                                    }
                                    if (_hasError) {
                                      return Icon(Icons.error_outline, color: Colors.white, size: 80);
                                    }
                                    final playerState = snapshot.data;
                                    final playing = playerState?.playing;
                                    if (playing != true) {
                                      return IconButton(
                                        icon: Icon(Icons.play_circle_outline_outlined, color: Colors.white, size: 80),
                                        onPressed: () async {
                                          try {
                                            await _audioPlayer.play();
                                          } catch (e) {
                                            print('Error playing audio: $e');
                                            setState(() => _hasError = true);
                                          }
                                        },
                                      );
                                    } else {
                                      return IconButton(
                                        icon: Icon(Icons.pause_circle_outline_outlined, color: Colors.white, size: 80),
                                        onPressed: _audioPlayer.pause,
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                    onPressed: () => _audioPlayer.seek(
                                          _audioPlayer.position + Duration(seconds: 10),
                                        ),
                                    icon: Icon(Icons.forward_10_outlined, color: Colors.white, size: 40)),
                              ],
                            ),
                            StreamBuilder<PositionData>(
                              stream: _positionDataStream,
                              builder: (context, snapshot) {
                                final positionData = snapshot.data;
                                return ProgressBar(
                                  current: positionData?.position ?? Duration.zero,
                                  total: positionData?.duration ?? Duration.zero,
                                  onSeek: (position) => _audioPlayer.seek(position),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else if (state is OneSurahError) {
            return Center(child: Text(state.message));
          } else {
            return Center(child: Text('No surah details available.'));
          }
        },
      ),
    );
  }
}
