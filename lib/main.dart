import 'package:flutter/material.dart' as material show Brightness;
import 'package:flutter/material.dart' hide Brightness;

import 'package:sayilar/model/brightness.dart';
import 'package:sayilar/model/exercises/calculate_exercise.dart';
import 'package:sayilar/model/exercises/random_exercise.dart';
import 'package:sayilar/model/exercises/recognize_exercise.dart';
import 'package:sayilar/model/exercises/translate_exercise.dart';
import 'package:sayilar/widgets/topic_selector.dart';
import 'package:sayilar/widgets/topics/exercise_topic.dart';

void main() {
  runApp(const Sayilar());
}

/// The root widget for the Sayılar app.
class Sayilar extends StatefulWidget {
  /// Create a new [Sayilar] widget.
  const Sayilar({super.key});

  @override
  State<Sayilar> createState() => SayilarState();
}

/// The [State] of a [Sayilar] widget.
class SayilarState extends State<Sayilar> {
  /// The [Brightness] to be currently used for the app.
  Brightness brightness = Brightness.first;

  @override
  Widget build(BuildContext context) {
    // The color used to seed the color scheme for the app.
    const Color colorSchemeSeed = Colors.blue;

    return MaterialApp(
      title: 'Sayılar',
      theme: () {
        switch (brightness) {
          case Brightness.system:
          case Brightness.light:
            return ThemeData(
              colorSchemeSeed: colorSchemeSeed,
              brightness: material.Brightness.light,
              useMaterial3: true,
            );
          case Brightness.dark:
            return ThemeData(
              colorSchemeSeed: colorSchemeSeed,
              brightness: material.Brightness.dark,
              useMaterial3: true,
            );
        }
      }(),
      darkTheme: () {
        switch (brightness) {
          case Brightness.system:
            return ThemeData(
              colorSchemeSeed: colorSchemeSeed,
              brightness: material.Brightness.dark,
              useMaterial3: true,
            );
          case Brightness.light:
          case Brightness.dark:
            return null;
        }
      }(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sayılar'),
          actions: <Widget>[
            IconButton(
              icon: Icon(brightness.next.icon),
              tooltip: brightness.next.tooltip,
              onPressed: () => setState(() => brightness = brightness.next),
            ),
          ],
        ),
        body: Center(
          child: TopicSelector(
            topics: [
              // FIXME: These three topics should probably be moved into a
              // "Numbers" DirectoryTopic once more exercises are added.
              const ExerciseTopic(
                icon: Icons.visibility,
                title: 'Recognize',
                subtitle: 'on iki → *12*',
                exercise: RecognizeExercise(),
              ),
              const ExerciseTopic(
                icon: Icons.edit,
                title: 'Translate',
                subtitle: '12 → *on iki*',
                exercise: TranslateExercise(),
              ),
              const ExerciseTopic(
                icon: Icons.calculate,
                title: 'Calculate',
                subtitle: 'bir + iki = *üç*',
                exercise: CalculateExercise(),
              ),
              ExerciseTopic(
                icon: Icons.shuffle,
                title: 'Random',
                subtitle: 'Practice *everything*!',
                exercise: RandomExercise(
                  exercises: const [
                    RecognizeExercise(),
                    TranslateExercise(),
                    CalculateExercise(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
