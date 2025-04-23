plugins {
    id("com.android.application")
    id("com.google.gms.google-services") // Firebase services plugin
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.callme"
    compileSdk = 35//flutter.compileSdkVersion
    ndkVersion = "27.0.12077973" // You can also use flutter.ndkVersion if needed

    // Enable Java 8 desugaring for lambda support and method references
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_1_8
        targetCompatibility = JavaVersion.VERSION_1_8
        isCoreLibraryDesugaringEnabled = true
    }

    // Add dexOptions for increased heap size when enabling desugaring
    dexOptions {
        javaMaxHeapSize = "4g" // Optional, but it might help with larger apps
    }

    // Enable Multidex if needed (for large apps with many dependencies)
    defaultConfig {
        applicationId = "com.example.callme"
        minSdk = 23//flutter.minSdkVersion
        targetSdk = 35//flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // Enable multidex for large apps
        multiDexEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_1_8.toString() // Use Java 8 features in Kotlin
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("debug") // Optional: If you have debug keystore
        }
    }
}

dependencies {
    implementation("com.google.firebase:firebase-messaging:23.1.1") // Firebase messaging
    implementation(platform("com.google.firebase:firebase-bom:31.1.1")) // Firebase BOM to manage dependencies
    implementation("androidx.core:core-ktx:1.6.0") // Android core extensions
    implementation("androidx.appcompat:appcompat:1.3.0") // AppCompat for backward compatibility
    implementation("androidx.constraintlayout:constraintlayout:2.0.4") // Layout support
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

}

apply(plugin = "com.google.gms.google-services") // Apply the Google services plugin at the end
