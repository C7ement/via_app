import 'package:flutter/material.dart';
import 'package:via/pages/map/custom_map.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const pieces = [
      {
        "name": "Mona Lisa",
        "description":
            "A world-famous oil painting by Leonardo da Vinci, renowned for its enigmatic expression and mastery of sfumato technique."
      },
      {
        "name": "Venus de Milo",
        "description":
            "An ancient Greek statue of Aphrodite, celebrated for its classical beauty and missing arms, which add to its mystery."
      },
      {
        "name": "Winged Victory of Samothrace",
        "description":
            "A Hellenistic sculpture that symbolizes victory, this dynamic figure stands on the prow of a ship, draped in flowing robes."
      },
      {
        "name": "The Raft of the Medusa",
        "description":
            "A powerful and monumental painting by Théodore Géricault depicting the aftermath of the shipwreck of the Medusa."
      },
      {
        "name": "The Coronation of Napoleon",
        "description":
            "A large painting by Jacques-Louis David illustrating Napoleon crowning himself Emperor in the presence of the pope."
      },
      {
        "name": "The Wedding at Cana",
        "description":
            "A massive oil painting by Paolo Veronese, portraying the biblical story of the marriage feast at Cana filled with numerous figures."
      },
      {
        "name": "The Seated Scribe",
        "description":
            "An ancient Egyptian statue from the Old Kingdom, remarkably lifelike, depicting a seated scribe at work."
      },
      {
        "name": "The Dying Slave",
        "description":
            "A sculpture by Michelangelo intended for the tomb of Pope Julius II, showing a slave in a moment of surrender."
      },
      {
        "name": "The Code of Hammurabi",
        "description":
            "One of the oldest deciphered writings of significant length in the world, this stele features laws inscribed under the Babylonian king Hammurabi."
      },
      {
        "name": "The Lacemaker",
        "description":
            "A painting by Johannes Vermeer that showcases his mastery of light and texture, depicting a woman focused on her delicate craft."
      }
    ];
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: CustomMap(),
      ),
    );
  }
}
