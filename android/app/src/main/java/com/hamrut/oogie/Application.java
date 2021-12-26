//import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;
//
//public class Application extends FlutterApplication implements PluginRegistrantCallback {
//    // ...
//    @Override
//    public void onCreate() {
//        super.onCreate();
//        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
//    }
//
//    @Override
//    public void registerWith(PluginRegistry registry) {
//        GeneratedPluginRegistrant.registerWith(registry);
//    }
//    // ...
//}
//
//
//// ...
////package com.hamrut.ev_charge;
////
////import io.flutter.app.FlutterApplication;
////import io.flutter.plugin.common.PluginRegistry;
////import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
////import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
////
////
////public class MyApplication extends FlutterApplication implements
////        PluginRegistrantCallback {
////    @Override
////    public void onCreate() {
////        super.onCreate();
////        FlutterFirebaseMessagingService.setPluginRegistrant(this);
////    }
////
////    @Override
////    public void registerWith(PluginRegistry registry) {
////        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
////    }
////}
//
//
//
//
//
//////3 firebse doc
////import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;
////
////public class MyApplication extends FlutterApplication implements PluginRegistrantCallback {
////    // ...
////    @Override
////    public void onCreate() {
////        super.onCreate();
////        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
////    }
////
////    @Override
////    public void registerWith(PluginRegistry registry) {
////        GeneratedPluginRegistrant.registerWith(registry);
////    }
////    // ...
////}
////
//
//
//
//
//
//
////1 2
////import io.flutter.app.FlutterApplication;
////import io.flutter.plugin.common.PluginRegistry;
////import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
////import io.flutter.view.FlutterMain;
////import io.flutter.plugins.firebase.messaging.FlutterFirebaseMessagingBackgroundService;
////
////public class MyApplication  extends FlutterApplication implements  PluginRegistrantCallback {
////    @Override
////    public void onCreate() {
////        super.onCreate();
////        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
////        FlutterMain.startInitialization(this);
////    }
////
////    @Override
////    public void registerWith(PluginRegistry registry) {
////
////    }
////}
//////
//////import io.flutter.app.FlutterApplication;
//////        import io.flutter.plugin.common.PluginRegistry;
//////        import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback;
//////        import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService;
//////
//////
//////public class Application extends FlutterApplication implements
//////        PluginRegistrantCallback {
//////    @Override
//////    public void onCreate() {
//////        super.onCreate();
//////        FlutterFirebaseMessagingService.setPluginRegistrant(this);
//////    }
//////
//////    @Override
//////    public void registerWith(PluginRegistry registry) {
//////        FirebaseCloudMessagingPluginRegistrant.registerWith(registry);
//////    }
//////}