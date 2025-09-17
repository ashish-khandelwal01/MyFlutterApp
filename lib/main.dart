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
        fontFamily: 'DancingScript',
      ),
      home: const MyHomePage(title: 'Bug Bug App'),
      debugShowCheckedModeBanner: false, // Remove debug banner
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
  bool _isPlaying = false; // Track music playing state

  /// Initializes state, sets up the audio player, and auto-starts music on non-web platforms.
  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();

    // Listen to player state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      setState(() {
        _isPlaying = state == PlayerState.playing;
      });
    });

    if (!kIsWeb) {
      _playBackgroundMusic(); // Autoplay on non-web platforms
      _musicStarted = true;
    }
  }

  /// Asynchronously configures and starts playing the background music.
  Future<void> _playBackgroundMusic() async {
    try {
      await _audioPlayer.setSource(AssetSource('music/audio.mp3')); // Make sure to add your music in the assets
      await _audioPlayer.setVolume(0.5); // Set volume
      await _audioPlayer.setReleaseMode(ReleaseMode.loop); // Set to loop
      await _audioPlayer.resume(); // Start playing
      setState(() {
        _musicStarted = true;
      });
    } catch (e) {
      debugPrint('Error playing background music: $e');
    }
  }

  /// Toggle music playback
  Future<void> _toggleMusic() async {
    try {
      if (_isPlaying) {
        await _audioPlayer.pause();
      } else {
        if (!_musicStarted) {
          await _playBackgroundMusic();
        } else {
          await _audioPlayer.resume();
        }
      }
    } catch (e) {
      debugPrint('Error toggling music: $e');
    }
  }

  /// Disposes of resources by stopping the audio player.
  @override
  void dispose() {
    _audioPlayer.dispose(); // Dispose instead of just stop
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
        elevation: 4,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFDE2E4),
              Color(0xFFFCE4EC),
              Color(0xFFF3E5F5),
            ],
          ),
        ),
        child: Stack(
          children: [
            const Positioned.fill(child: FloatingHearts()), // 🎈 Floating hearts
            Center(
              child: SingleChildScrollView( // Make scrollable for smaller screens
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "I Love You Forever ❤️",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                        fontFamily: 'DancingScript',
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4,
                            color: Colors.black26,
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: [
                        _buildCuteButton(
                          context,
                          'Bugudi 😘😘',
                          const ImageGalleryScreen(
                            images: [
                              'assets/Anu/image1.png',
                              'assets/Anu/image2.jpg',
                              'assets/Anu/image3.jpg',
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
                              'assets/Ashish/image4.jpg',
                              'assets/Ashish/image5.jpg',
                              'assets/Ashish/image6.jpg',
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
                              'assets/Us/image7.png',
                              'assets/Us/image8.jpg',
                              'assets/Us/image9.png',
                              'assets/Us/image10.png',
                              'assets/Us/image11.png',
                              'assets/Us/image12.png',
                              'assets/Us/image13.png',
                              'assets/Us/image14.png',
                              'assets/Us/image15.png',
                            ],
                            captions: [
                              'Mine Forever',
                              'and ever',
                              'Together always',
                              'My heart',
                              'My soul',
                              'My everything',
                              'Forever us',
                              'Always us',
                              'Never ending love'
                            ],
                            description: 'Us ❤️',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      // Enhanced floating action button with music controls
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleMusic,
        backgroundColor: Colors.pinkAccent,
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.white,
        ),
        tooltip: _isPlaying ? 'Pause Music' : 'Play Music',
      ),
    );
  }

  /// Creates a styled button that navigates to the provided screen with a slide transition.
  static Widget _buildCuteButton(BuildContext context, String text, Widget screen) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(110, 110),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: Colors.white.withOpacity(0.95),
          foregroundColor: Colors.pinkAccent,
          elevation: 10,
          shadowColor: Colors.pinkAccent.withOpacity(0.6),
        ),
        onPressed: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => screen,
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0); // Slide up
                const end = Offset.zero;
                const curve = Curves.easeInOutCubic;
                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                final offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              },
              transitionDuration: const Duration(milliseconds: 600),
            ),
          );
        },
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// A screen that displays an image gallery with captions.
/// Uses a PageView to allow users to swipe through images.
class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({
    super.key,
    required this.images,
    required this.description,
    required this.captions,
  });

  final List<String> images;
  final String description;
  final List<String> captions;

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  /// Builds a scaffold containing an AppBar and a swipable gallery of images and captions.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.description,
          style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.pinkAccent.shade100,
        iconTheme: const IconThemeData(color: Colors.deepPurple),
        elevation: 4,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                '${_currentIndex + 1} / ${widget.images.length}',
                style: const TextStyle(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFDE2E4),
              Color(0xFFFCE4EC),
            ],
          ),
        ),
        child: PageView.builder(
          controller: _pageController,
          itemCount: widget.images.length,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: Hero(
                      tag: 'image_$index',
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            widget.images[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade300,
                                child: const Center(
                                  child: Icon(
                                    Icons.image_not_supported,
                                    size: 64,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Text(
                          index < widget.captions.length
                              ? widget.captions[index]
                              : 'Beautiful moment ❤️',
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: Colors.deepPurple,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'DancingScript',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        color: Colors.pinkAccent.shade100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: _currentIndex > 0
                  ? () => _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              )
                  : null,
              icon: const Icon(Icons.arrow_back),
              label: const Text('Previous'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
              ),
            ),
            ElevatedButton.icon(
              onPressed: _currentIndex < widget.images.length - 1
                  ? () => _pageController.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              )
                  : null,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Next'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.deepPurple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that displays animated floating hearts across the screen.
class FloatingHearts extends StatefulWidget {
  const FloatingHearts({super.key});

  @override
  State<FloatingHearts> createState() => _FloatingHeartsState();
}

class _FloatingHeartsState extends State<FloatingHearts>
    with TickerProviderStateMixin {
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startAddingHearts();
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _startAddingHearts() {
    _timer = Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      if (mounted) {
        _addHeart();
      }
    });
  }

  void _addHeart() {
    final controller = AnimationController(
      duration: Duration(milliseconds: 3000 + Random().nextInt(2000)),
      vsync: this,
    );

    final animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));

    _controllers.add(controller);
    _animations.add(animation);

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
        _controllers.remove(controller);
        _animations.remove(animation);
      }
    });

    controller.forward();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: _animations.map((animation) => _buildHeart(animation)).toList(),
    );
  }

  Widget _buildHeart(Animation<double> animation) {
    final random = Random();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final left = random.nextDouble() * (screenWidth - 50);
    final size = random.nextDouble() * 20 + 25;
    final opacity = random.nextDouble() * 0.5 + 0.3;

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final progress = animation.value;
        final yPosition = screenHeight - (progress * (screenHeight + 100));
        final xOffset = sin(progress * 4 * pi) * 30;
        final rotation = progress * 2 * pi;
        final heartOpacity = opacity * (1 - progress);

        return Positioned(
          left: left + xOffset,
          top: yPosition,
          child: Transform.rotate(
            angle: rotation,
            child: Icon(
              Icons.favorite,
              color: Colors.pinkAccent.withOpacity(heartOpacity),
              size: size,
            ),
          ),
        );
      },
    );
  }
}