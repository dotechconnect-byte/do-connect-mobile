package com.doconnect.mobile

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "whatsapp_launcher"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openWhatsApp") {
                val phone = call.argument<String>("phone")
                val message = call.argument<String>("message")

                if (phone != null && message != null) {
                    try {
                        val intent = Intent(Intent.ACTION_VIEW)
                        val url = "https://wa.me/$phone?text=${Uri.encode(message)}"
                        intent.data = Uri.parse(url)
                        startActivity(intent)
                        result.success(true)
                    } catch (e: Exception) {
                        result.error("UNAVAILABLE", "WhatsApp not installed", null)
                    }
                } else {
                    result.error("INVALID_ARGUMENTS", "Phone and message required", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
