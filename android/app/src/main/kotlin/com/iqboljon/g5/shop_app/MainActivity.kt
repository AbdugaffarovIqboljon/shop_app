package com.iqboljon.g5.shop_app


import androidx.annotation.NonNull
import com.yandex.mapkit.MapKitFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setApiKey("6d3d3d5e-5b2e-423e-8820-027e22daa40b")
        super.configureFlutterEngine(flutterEngine)
    }
}