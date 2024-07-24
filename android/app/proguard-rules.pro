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
