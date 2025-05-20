plugins {
    id("com.android.application")
    id("com.google.gms.google-services")   // <-- Google Services plugin here
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.isl_kids_app"
    compileSdk = 35  // or flutter.compileSdkVersion if you use it

    ndkVersion = "29.0.13113456"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.isl_kids_app"
        minSdk = 21    // or flutter.minSdkVersion
        targetSdk = 35 // or flutter.targetSdkVersion
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}
