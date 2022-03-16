import 'package:flutter/material.dart';

class RatingWidget extends StatefulWidget {
  const RatingWidget({Key? key}) : super(key: key);

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  var states = [false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingStar(
          state: states[0],
          onTap: () {
            setState(() {
              for (var j = 0; j < 5; j++) {
                states[j] = false;
              }
              for (var i = 0; i < 1; i++) {
                states[i] = true;
              }
            });
          },
        ),
        RatingStar(
          state: states[1],
          onTap: () {
            setState(() {
              for (var j = 0; j < 5; j++) {
                states[j] = false;
              }
              for (var i = 0; i < 2; i++) {
                states[i] = true;
              }
            });
          },
        ),
        RatingStar(
          state: states[2],
          onTap: () {
            setState(() {
              for (var j = 0; j < 5; j++) {
                states[j] = false;
              }
              for (var i = 0; i < 3; i++) {
                states[i] = true;
              }
            });
          },
        ),
        RatingStar(
          state: states[3],
          onTap: () {
            setState(() {
              for (var j = 0; j < 5; j++) {
                states[j] = false;
              }
              for (var i = 0; i < 4; i++) {
                states[i] = true;
              }
            });
          },
        ),
        RatingStar(
          state: states[4],
          onTap: () {
            setState(() {
              for (var j = 0; j < 5; j++) {
                states[j] = false;
              }
              for (var i = 0; i < 5; i++) {
                states[i] = true;
              }
            });
          },
        ),
      ],
    );
  }
}

class RatingStar extends StatefulWidget {
  final bool state;
  final Function onTap;
  const RatingStar({Key? key, required this.state, required this.onTap})
      : super(key: key);

  @override
  State<RatingStar> createState() => _RatingStarState();
}

class _RatingStarState extends State<RatingStar> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
      },
      child: AnimatedCrossFade(
          firstChild: const Icon(
            Icons.star_outline_rounded,
            color: Colors.grey,
          ),
          secondChild: const Icon(
            Icons.star_rounded,
            color: Colors.amber,
          ),
          crossFadeState: widget.state
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(seconds: 1)),
    );
  }
}
