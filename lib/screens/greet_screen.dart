import 'package:flutter/material.dart';

import 'components/fade_animation.dart';
import 'components/wave_painter.dart';
import 'main_screen.dart';


class GreetScreen extends StatelessWidget {
  const GreetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FadeAnimation(
          delay: 5,
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/welcome.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 150,
                  width: 500,
                  child: CustomPaint(
                      size: Size(MediaQuery.of(context).size.width, 200),
                      painter: WavePainter(),
                      child: const Padding(
                        padding: EdgeInsets.only(top: 30, left: 25),
                        child: FadeAnimation(
                          delay: 5,
                          child: Text(
                            "“Life is a journey” – we all have heard this saying lot of times. This means that life is all about how well we live it...",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Caveat-Variable',
                              color: Colors.black54,
                            ),
                          ),
                        ),
                      )),
                ),
                const Spacer(),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: FadeAnimation(
                    delay: 5,
                    child: MaterialButton(
                      height: 60,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      color: Colors.white60,
                      child: const Text("Let's start",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Caveat-Variable',
                              color: Colors.black54)),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MainScreen()));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
