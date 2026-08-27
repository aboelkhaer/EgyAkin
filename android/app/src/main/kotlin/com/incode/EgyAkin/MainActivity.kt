package com.incode.EgyAkin

import android.app.UiModeManager
import android.content.Context
import android.os.Build
import androidx.appcompat.app.AppCompatDelegate
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val themeChannel = "com.incode.EgyAkin/theme"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, themeChannel)
            .setMethodCallHandler { call, result ->
                if (call.method == "setBrightness") {
                    when (call.arguments as? String) {
                        "dark" -> applyNightMode(
                            AppCompatDelegate.MODE_NIGHT_YES,
                            UiModeManager.MODE_NIGHT_YES,
                        )
                        "light" -> applyNightMode(
                            AppCompatDelegate.MODE_NIGHT_NO,
                            UiModeManager.MODE_NIGHT_NO,
                        )
                        else -> applyNightMode(
                            AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM,
                            null,
                        )
                    }
                    result.success(null)
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun applyNightMode(appCompatMode: Int, uiModeManagerMode: Int?) {
        AppCompatDelegate.setDefaultNightMode(appCompatMode)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && uiModeManagerMode != null) {
            val uiModeManager =
                getSystemService(Context.UI_MODE_SERVICE) as UiModeManager
            uiModeManager.setApplicationNightMode(uiModeManagerMode)
        }
    }
}
