# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /usr/share/android-sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the ProGuard
# include property in build.gradle.

# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Ensure the Android support libraries are retained
-keep class android.support.** { *; }
-keep interface android.support.** { *; }

# Retain the names of annotated methods and fields.
-keep @android.support.annotation.Keep class * { *; }

# Retain the names of annotated methods and fields.
-keep @com.google.android.gms.common.annotation.KeepName class * { *; }

# Kotlin specific rules - simplified
-dontwarn kotlin.**
-keep class kotlin.** { *; }
-keep class kotlin.Metadata { *; }
-keepclassmembers class **$WhenMappings {
    <fields>;
}
-keepclassmembers class kotlin.Metadata {
    public <methods>;
}

# Keep all Kotlin stdlib
-keep class kotlinx.** { *; }
-keep class kotlin.reflect.** { *; }

# Keep Kotlin coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}

# Keep Kotlin serialization
-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt

# Keep Kotlin reflection
-keep class kotlin.reflect.** { *; }

# Keep all Flutter classes
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Keep Google Play Core classes for Flutter deferred components
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-keep class com.google.android.play.core.splitinstall.** { *; }
-keep class com.google.android.play.core.tasks.** { *; }
-keep class com.google.android.play.core.appupdate.** { *; }
-keep class com.google.android.play.core.install.** { *; }
-keep class com.google.android.play.core.review.** { *; }
-keep class com.google.android.play.core.missingsplits.** { *; }
