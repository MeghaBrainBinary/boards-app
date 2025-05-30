package com.filuet

import android.content.Intent
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "native_service"
    private var fcmToken: String? = null
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "startService") {
                val intent = Intent(this, MyService::class.java)
                startService(intent)
                fcmToken = call.argument("token")

                val prefs = getSharedPreferences("MyAppPrefs", MODE_PRIVATE)
                prefs.edit().putString("fcm_token", fcmToken).apply()
                result.success(null)
            }
        }
    }
}