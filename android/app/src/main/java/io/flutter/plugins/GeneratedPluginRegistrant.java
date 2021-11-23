package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import com.jrai.flutter_keyboard_visibility.FlutterKeyboardVisibilityPlugin;
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin;
import com.whelksoft.flutter_native_timezone.FlutterNativeTimezonePlugin;
import io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;
import com.tekartik.sqflite.SqflitePlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    FlutterKeyboardVisibilityPlugin.registerWith(registry.registrarFor("com.jrai.flutter_keyboard_visibility.FlutterKeyboardVisibilityPlugin"));
    FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
    FlutterNativeTimezonePlugin.registerWith(registry.registrarFor("com.whelksoft.flutter_native_timezone.FlutterNativeTimezonePlugin"));
    FlutterToastPlugin.registerWith(registry.registrarFor("io.github.ponnamkarthik.toast.fluttertoast.FlutterToastPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
    SqflitePlugin.registerWith(registry.registrarFor("com.tekartik.sqflite.SqflitePlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
