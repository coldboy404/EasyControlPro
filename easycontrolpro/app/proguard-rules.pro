# Add project specific ProGuard rules here.
# You can control the set of applied configuration files using the
# proguardFiles setting in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

# Uncomment this to preserve the line number information for
# debugging stack traces.
#-keepattributes SourceFile,LineNumberTable

# If you keep the line number information, uncomment this to
# hide the original source file name.
#-renamesourcefileattribute SourceFile
# Keep app classes and members to preserve behavior with reflection/IPC.
-keep class com.shiyunjin.easycontrolpro.** { *; }

# Keep SPAKE2/crypto classes used during pairing and key exchange.
-keep public class io.github.muntashirakon.crypto.spake2.** { *; }
-keep class org.bouncycastle.** { *; }
-dontwarn org.bouncycastle.**

# Keep conscrypt internals that may be loaded reflectively.
-keep class org.conscrypt.** { *; }
-dontwarn org.conscrypt.**
