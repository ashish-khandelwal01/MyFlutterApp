# Bug Bug App

## Overview
Bug Bug is a Flutter application that features:
- **Animated Floating Hearts**: Enjoy a continuous heart animation across the screen.
- **Image Galleries**: Navigate through curated image galleries with captions.
- **Background Music**: The app plays background music.  
  **Note for Web Users:** Audio autoplay is blocked by most browsers. Tap the floating play button to start background music.

## Setup
- Ensure that the music file is located at `assets/music/audio.mp3`.  
- Update your `pubspec.yaml` assets configuration accordingly.
- For web deployments, interact with the play button to begin audio playback.

## Running the App
- From the project root, run `flutter run` to start the application.
- If testing on the web, the floating action button will appear until the background music is manually started.

## Additional Information
- The heart animation uses `TweenAnimationBuilder` to smoothly animate the icons.
- Image galleries are implemented via `PageView.builder` for a seamless swipe experience.
