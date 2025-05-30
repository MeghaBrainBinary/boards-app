package com.filuet

import android.app.AlarmManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.os.IBinder
import android.content.BroadcastReceiver
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import java.io.OutputStreamWriter
import java.net.HttpURLConnection
import java.net.URL

class MyService : Service() {
    override fun onTaskRemoved(rootIntent: Intent?) {
        super.onTaskRemoved(rootIntent)

        val intent = Intent(this, LogoutReceiver::class.java)
        val pendingIntent = PendingIntent.getBroadcast(
            this,
            0,
            intent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )

        val alarmManager = getSystemService(Context.ALARM_SERVICE) as AlarmManager
        alarmManager.setExact(
            AlarmManager.RTC_WAKEUP,
            System.currentTimeMillis() + 2000, // 2 seconds delay
            pendingIntent
        )
    }

    override fun onBind(intent: Intent?): IBinder? = null
}



class LogoutReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        CoroutineScope(Dispatchers.IO).launch {
            val prefs = context.getSharedPreferences("MyAppPrefs", Context.MODE_PRIVATE)
            val fcmToken = prefs.getString("fcm_token", null)

            try {
                if (fcmToken != null) {
                    val url = URL("http://board.mvp.design-wisdom.com/api/app-logout")
                    val conn = url.openConnection() as HttpURLConnection
                    conn.requestMethod = "POST"
                    conn.setRequestProperty("Content-Type", "application/json")
                    conn.doOutput = true

                    val body = """{"device_token": "$fcmToken"}"""
                    val writer = OutputStreamWriter(conn.outputStream)
                    writer.write(body)
                    writer.flush()
                    writer.close()

                    val responseCode = conn.responseCode
                    val inputStream = if (responseCode in 200..299) conn.inputStream else conn.errorStream
                    val responseBody = inputStream.bufferedReader().use { it.readText() }

                    println("Logout API response code: $body")
                    println("Logout API response code: $responseCode")
                    println("Logout API response body: $responseBody")
                }

                prefs.edit().clear().apply()
                context.getSharedPreferences("FlutterSharedPreferences", Context.MODE_PRIVATE)
                    .edit().clear().apply()

            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
    }
}
