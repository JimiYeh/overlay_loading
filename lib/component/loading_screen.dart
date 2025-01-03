import 'dart:async';

import 'package:flutter/material.dart';

typedef CloseLoadingScreen = bool Function();
typedef UpdateLoadingScreen = bool Function(String text);

class LoadingScreenController {
  LoadingScreenController({required this.closeLoadingScreen, required this.updateLoadingScreen});
  final CloseLoadingScreen closeLoadingScreen;
  final UpdateLoadingScreen updateLoadingScreen;
}

class LoadingScreen {
  factory LoadingScreen() => _instance;
  static final LoadingScreen _instance = LoadingScreen._();
  LoadingScreen._();

  LoadingScreenController? controller;

  void show({required BuildContext context, required String text}) {
    if (controller == null) {
      controller = showOverlay(context: context, text: text);
    } else {
      controller?.updateLoadingScreen(text);
    }
  }

  void hide() {
    controller?.closeLoadingScreen();
    controller = null;
  }

  LoadingScreenController? showOverlay({required BuildContext context, required String text}) {
    final textStream = StreamController<String>();
    textStream.add(text);
    final state = Overlay.of(context, rootOverlay: true);

    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;

    ModalRoute.of(context)?.addScopedWillPopCallback(() async => false);

    final overlay = OverlayEntry(
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Container(
          width: size.width,
          height: size.height,
          color: Colors.black.withOpacity(0.3),
          child: PopScope(
            canPop: false,
            child: Center(
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: size.width * 0.8,
                  maxHeight: size.height * 0.8,
                  minWidth: size.width * 0.5,
                ),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.all(16),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(),
                      const SizedBox(height: 8),
                      StreamBuilder(
                          stream: textStream.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Text(snapshot.data!);
                            } else {
                              return const SizedBox.shrink();
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    final controller = LoadingScreenController(
      closeLoadingScreen: () {
        textStream.close();
        overlay.remove();
        ModalRoute.of(context)?.removeScopedWillPopCallback(() async => false);
        return true;
      },
      updateLoadingScreen: (text) {
        textStream.add(text);
        return true;
      },
    );

    state.insert(overlay);
    return controller;
  }
}
