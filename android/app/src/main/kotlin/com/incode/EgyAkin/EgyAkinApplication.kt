package com.incode.EgyAkin

import android.app.Application
import android.app.UiModeManager
import android.content.Context
import android.os.Build
import androidx.appcompat.app.AppCompatDelegate

/**
 * Applies the saved Flutter theme before any Activity/splash is shown,
 * so the native splash uses dark/light correctly.
 */
class EgyAkinApplication : Application() {
    override fun onCreate() {
        applySavedNightMode()
        super.onCreate()
    }

    private fun applySavedNightMode() {
        val prefs = getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
        when (prefs.getString(THEME_KEY, "system")) {
            "dark" -> setNightMode(
                AppCompatDelegate.MODE_NIGHT_YES,
                UiModeManager.MODE_NIGHT_YES,
            )
            "light" -> setNightMode(
                AppCompatDelegate.MODE_NIGHT_NO,
                UiModeManager.MODE_NIGHT_NO,
            )
            else -> setNightMode(
                AppCompatDelegate.MODE_NIGHT_FOLLOW_SYSTEM,
                null,
            )
        }
    }

    private fun setNightMode(appCompatMode: Int, uiModeManagerMode: Int?) {
        AppCompatDelegate.setDefaultNightMode(appCompatMode)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S && uiModeManagerMode != null) {
            val uiModeManager =
                getSystemService(Context.UI_MODE_SERVICE) as UiModeManager
            uiModeManager.setApplicationNightMode(uiModeManagerMode)
        }
    }

    companion object {
        private const val PREFS_NAME = "FlutterSharedPreferences"
        private const val THEME_KEY = "flutter.theme_mode"
    }
}
