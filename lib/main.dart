/**
 * Bug Bug App - Main Entry Point
 *
 * This file serves as the entry point for the Bug Bug App.
 * It initializes the MaterialApp and sets up:
 *  - Animated Floating Hearts: Smooth heart animation using TweenAnimationBuilder.
 *  - Background Music: Looped music playback with auto-play on mobile and a play button on web.
 *  - Image Galleries: Displays swipeable image galleries with captions.
 *
 * Make sure assets (music and images) are properly configured in pubspec.yaml.
 */

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart'; // For background music
import 'package:flutter/foundation.dart' show kIsWeb; // Added for web check

void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
/// Builds a MaterialApp with a specific theme and the home page.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bug Bug',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bug Bug App'),
    );
  }
}

/// A stateful widget representing the home page of the application.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/// State for MyHomePage widget.
/// Handles background music playback and UI interactions.
class _MyHomePageState extends State<MyHomePage> {
  late AudioPlayer _audioPlayer;
  bool _musicStarted = false; // Added flag for web audio start

  /// Initializes state, sets up the audio player, and auto-starts music on non-web platforms.
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    if (!kIsWeb) {
      _playBackgroundMusic(); // Autoplay on non-web platforms
      _musicStarted = true;
    }
  }

  /// Asynchronously configures and starts playing the background music.
  void _playBackgroundMusic() async {
    await _audioPlayer.setSource(AssetSource('music/audio.mp3')); // Make sure to add your music in the assets
    await _audioPlayer.setVolume(0.5); // Set volume
    await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Set to loop
    await _audioPlayer.resume(); // Start playing
  }

  /// Disposes of resources by stopping the audio player.
  @override
  void dispose() {
    _audioPlayer.stop(); // Stop music when leaving the page
    super.dispose();
  }

  /// Builds the UI for the home page including the app bar, animated hearts, buttons, and optionally a play button on web.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent.shade100,
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
      ),
      body: Stack(
        children: [
          const Positioned.fill(child: FloatingHearts()), // 🎈 Floating hearts
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "I Love You Forever ❤️",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                    fontFamily: 'DancingScript',
                  ),
                ),
                const SizedBox(height: 20),
                Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  children: [
                    _buildCuteButton(
                      context,
                      'Bugudi 😘😘',
                      const ImageGalleryScreen(
                        images: [
                          'assets/image1.png',
                          'assets/image2.jpg',
                          'assets/image3.jpg',
                        ],
                        captions: ['I love you 😘', 'Ankhain teri ❤️', 'Janu meri Jaan'],
                        description: 'Bugudi 😘😘',
                      ),
                    ),
                    _buildCuteButton(
                      context,
                      'Bubu',
                      const ImageGalleryScreen(
                        images: [
                          'assets/image4.jpg',
                          'assets/image5.jpg',
                          'assets/image6.jpg',
                        ],
                        captions: ['Yours', 'Only Yours', 'Forever Yours'],
                        description: 'Bubu',
                      ),
                    ),
                    _buildCuteButton(
                      context,
                      'Us ❤️',
                      const ImageGalleryScreen(
                        images: [
                          'assets/image7.png',
                          'assets/image8.jpg',
                        ],
                        captions: ['Mine Forever', 'and ever'],
                        description: 'Us ❤️',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      // Play button for web platforms to trigger audio on user interaction.
      floatingActionButton: kIsWeb && !_musicStarted
          ? FloatingActionButton(
              onPressed: () {
                _playBackgroundMusic();
                setState(() {
                  _musicStarted = true;
                });
              },
              child: const Icon(Icons.play_arrow),
            )
          : null,
    );
  }

  /// Creates a styled button that navigates to the provided screen with a slide transition.
  static Widget _buildCuteButton(BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: Colors.white.withOpacity(0.9),
        foregroundColor: Colors.pinkAccent,
        elevation: 8,
        shadowColor: Colors.pinkAccent.withOpacity(0.5),
      ),
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => screen,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(0.0, 1.0); // Slide up
              const end = Offset.zero;
              const curve = Curves.easeInOut;
              final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              final offsetAnimation = animation.drive(tween);
              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Text(
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// A screen that displays an image gallery with captions.
/// Uses a PageView to allow users to swipe through images.
class ImageGalleryScreen extends StatelessWidget {
  const ImageGalleryScreen({
    super.key,
    required this.images,
    required this.description,
    required this.captions,
  });

  final List<String> images;
  final String description;
  final List<String> captions;

  /// Builds a scaffold containing an AppBar and a swipable gallery of images and captions.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          description,
          style: const TextStyle(color: Colors.deepPurple),
        ),
        backgroundColor: Colors.pinkAccent.shade100,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
      ),
      body: Container(
        color: const Color(0xFFFDE2E4),
        child: PageView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  captions[index],
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

/// A widget that displays animated floating hearts across the screen.
class FloatingHearts extends StatefulWidget {
  const FloatingHearts({Key? key}) : super(key: key);

  @override
  _FloatingHeartsState createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts> {
  final List<Widget> _hearts = [];

  @override
  void initState() {
    super.initState();
    _startAddingHearts();
  }

  void _startAddingHearts() {
    Timer.periodic(const Duration(milliseconds: 800), (timer) {
      if (mounted) {
        setState(() {
          _hearts.add(_buildHeart());
        });
      }
    });
  }

  Widget _buildHeart() {
    final random = Random();
    final double left = random.nextDouble() * MediaQuery.of(context).size.width;
    final double size = random.nextDouble() * 30 + 20;
    final int duration = random.nextInt(3000) + 2000;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: -size, end: MediaQuery.of(context).size.height),
      duration: Duration(milliseconds: duration),
      builder: (context, bottomValue, child) {
        return Positioned(
          bottom: bottomValue,
          left: left,
          child: child!,
        );
      },
      child: Icon(
        Icons.favorite,
        color: Colors.pinkAccent.withOpacity(0.7),
        size: size,
      ),
      onEnd: () {
        setState(() {
          _hearts.removeAt(0);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _hearts);
  }
}
