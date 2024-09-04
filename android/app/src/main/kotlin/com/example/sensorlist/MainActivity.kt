package com.example.sensorlist

import android.hardware.Sensor
import android.hardware.SensorManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import sun.management.Sensor

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.sensorlist"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getSensorList") {
                val sensorManager = getSystemService(SENSOR_SERVICE) as SensorManager
                val deviceSensors: List<Sensor> = sensorManager.getSensorList(Sensor.TYPE_ALL)
                val sensorNames = deviceSensors.map { it.name }
                result.success(sensorNames)
            } else {
                result.notImplemented()
            }
        }
    }
}
