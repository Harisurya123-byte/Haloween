GestureDetector(
  onTap: () {
    if (isCorrectItem) {
      player.play('assets/success.mp3');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text("You Found It!"),
        ),
      );
    } else {
      player.play('assets/spooky_sound.mp3');
    }
  },
  child: Image.asset('assets/pumpkin.png'),
);
