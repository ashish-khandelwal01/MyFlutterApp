import 'package:flutter/material.dart';

/// The main entry point of the Flutter application.
void main() {
  runApp(const MyApp());
}

/// The root widget of the application.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp] widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bug Bug', // The title of the application.
      theme: ThemeData(
        // Defines the theme of the application using Material 3.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bug Bug App'), // The home screen of the app.
    );
  }
}

/// The home page of the application.
class MyHomePage extends StatelessWidget {
  /// Creates a [MyHomePage] widget.
  ///
  /// [title] is the title displayed in the app bar.
  const MyHomePage({super.key, required this.title});

  /// The title of the home page.
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title), // Displays the title in the app bar.
      ),
      body: Container(
        // Adds a gradient background to the body.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          // Centers the row of buttons.
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Button for navigating to the "Bugudi" gallery screen.
              _buildSquareButton(
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
              const SizedBox(width: 20), // Adds spacing between buttons.
              // Button for navigating to the "Bubu" gallery screen.
              _buildSquareButton(
                context,
                'Bubu',
                const ImageGalleryScreen(
                  images: [
                    'assets/image4.jpg',
                    'assets/image5.jpg',
                    'assets/image6.jpg',
                  ],
                  captions: ['Yours', 'Only Yours', 'I love you'],
                  description: 'Bubu',
                ),
              ),
              const SizedBox(width: 20), // Adds spacing between buttons.
              // Button for navigating to the "Us" gallery screen.
              _buildSquareButton(
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
        ),
      ),
    );
  }

  /// Builds a square-shaped button with a custom style.
  ///
  /// [context] is the build context.
  /// [text] is the label displayed on the button.
  /// [screen] is the screen to navigate to when the button is pressed.
  Widget _buildSquareButton(BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 100), // Sets the button size.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // Adds rounded corners.
        ),
        backgroundColor: Colors.white.withOpacity(0.8), // Button background color.
        foregroundColor: Colors.deepPurple, // Button text color.
        elevation: 10, // Adds shadow to the button.
        shadowColor: Colors.deepPurpleAccent, // Shadow color.
      ),
      onPressed: () {
        // Navigates to the specified screen with a slide transition.
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => screen,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Slide in from the right.
              const end = Offset.zero;
              const curve = Curves.easeInOut;

              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);

              return SlideTransition(position: offsetAnimation, child: child);
            },
          ),
        );
      },
      child: Text(
        text, // Button label.
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

/// A screen that displays an image gallery with captions.
class ImageGalleryScreen extends StatelessWidget {
  /// Creates an [ImageGalleryScreen] widget.
  ///
  /// [images] is the list of image asset paths.
  /// [description] is the title of the screen.
  /// [captions] is the list of captions for each image.
  const ImageGalleryScreen({
    super.key,
    required this.images,
    required this.description,
    required this.captions,
  });

  /// The list of image asset paths.
  final List<String> images;

  /// The title of the screen.
  final String description;

  /// The list of captions for each image.
  final List<String> captions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(description), // Displays the screen title in the app bar.
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        // Adds a gradient background to the gallery screen.
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
        child: PageView.builder(
          itemCount: images.length, // Number of images in the gallery.
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // Displays the image.
                  child: Image.asset(
                    images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 20), // Adds spacing below the image.
                Text(
                  captions[index], // Displays the caption for the image.
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white,
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