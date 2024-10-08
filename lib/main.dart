// G.Hari Surya Bharadwaj   
// Lilly Masie


import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:math';

void main() {
  runApp(HalloweenGame());
}

class HalloweenGame extends StatefulWidget {
  @override
  _HalloweenGameState createState() => _HalloweenGameState();
}

class _HalloweenGameState extends State<HalloweenGame> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _gameWon = false;

  @override
  void initState() {
    super.initState();
    // Start background music and loop
    _audioPlayer.play('assets/1.mp3', isLocal: true);
    _audioPlayer.setReleaseMode(ReleaseMode.LOOP);  // Loop background music
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playJumpScare() async {
    // Play jump scare sound
    await _audioPlayer.play('assets/2.mp3', isLocal: true);
  }

  void _playSuccessSound() async {
    // Play success sound
    await _audioPlayer.play('assets/3.mp3', isLocal: true);
    setState(() {
      _gameWon = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Spooky Halloween Game'),
        ),
        body: Stack(
          children: [
            Center(
              child: _gameWon
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'You Found It!',
                          style: TextStyle(fontSize: 30, color: Colors.orange),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _gameWon = false;
                            });
                          },
                          child: Text('Play Again'),
                        ),
                      ],
                    )
                  : GameBoard(
                      playJumpScare: _playJumpScare,
                      playSuccessSound: _playSuccessSound,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class GameBoard extends StatelessWidget {
  final Function playJumpScare;
  final Function playSuccessSound;

  GameBoard({required this.playJumpScare, required this.playSuccessSound});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = [];
    final random = Random();

    // Adding random spooky objects
    for (int i = 0; i < 6; i++) {
      items.add(Positioned(
        left: random.nextDouble() * 300,
        top: random.nextDouble() * 600,
        child: SpookyItem(
          isTrap: i != 3, // Only one item is not a trap
          playJumpScare: playJumpScare,
          playSuccessSound: playSuccessSound,
        ),
      ));
    }

    return Stack(children: items);
  }
}

class SpookyItem extends StatelessWidget {
  final bool isTrap;
  final Function playJumpScare;
  final Function playSuccessSound;

  SpookyItem({
    required this.isTrap,
    required this.playJumpScare,
    required this.playSuccessSound,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isTrap) {
          playJumpScare();
        } else {
          playSuccessSound();
        }
      },
      child: Image.asset(
        isTrap ? 'assets/pumpkin.png' : 'assets/ghost.png',
        width: 80,
        height: 80,
      ),
    );
  }
}
