import 'package:flashcard_pet/src/app_bootstrap.dart';
import 'package:flashcard_pet/src/app_bootstrap_fakes.dart';
import 'package:flashcard_pet/src/exceptions/error_logger.dart';
import 'package:flashcard_pet/src/localization/string_hardcoded.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // turn off the # in the URLs on the web
  usePathUrlStrategy();

  final container = await createFakesProviderContainer();

  final appBootstrap = AppBootstrap();

  final root = appBootstrap.createRootWidget(container: container);

  runApp(root);
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}
