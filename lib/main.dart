import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bug Bug',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Bug Bug App'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepOrange, Colors.redAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
              const SizedBox(width: 20),
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
              const SizedBox(width: 20),
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

  Widget _buildSquareButton(BuildContext context, String text, Widget screen) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(100, 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: Colors.white.withOpacity(0.8),
        foregroundColor: Colors.deepPurple,
        elevation: 10,
        shadowColor: Colors.deepPurpleAccent,
      ),
      onPressed: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => screen,
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
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
        text,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(description),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purpleAccent, Colors.deepPurple],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
        ),
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

