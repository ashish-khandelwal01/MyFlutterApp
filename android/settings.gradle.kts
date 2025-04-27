pluginManagement {
    val flutterSdkPath = run {
        val properties = java.util.Properties()
        file("local.properties").inputStream().use { properties.load(it) }
        val flutterSdkPath = properties.getProperty("flutter.sdk")
        require(flutterSdkPath != null) { "flutter.sdk not set in local.properties" }
        flutterSdkPath
    }

    includeBuild("$flutterSdkPath/packages/flutter_tools/gradle")

    repositories {
        google()  // Ensure Google's Maven repository is included
        mavenCentral()  // Ensure Maven Central is included
        gradlePluginPortal()  // Ensure Gradle Plugin Portal is included
        maven { url = uri("https://storage.googleapis.com/download.flutter.io") }  // Adding Flutter-specific Maven repository
    }
}

plugins {
    id("dev.flutter.flutter-plugin-loader") version "1.0.0" // Ensure correct version
    id("com.android.application") version "8.7.0" apply false
    id("org.jetbrains.kotlin.android") version "1.8.22" apply false
}

include(":app")
