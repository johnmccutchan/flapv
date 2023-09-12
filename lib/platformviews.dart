import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PlatformViewType {
  kBasic,
  kInput,
  kMap,
}

String _platformViewTypeAsString(PlatformViewType viewType) {
  switch (viewType) {
    case PlatformViewType.kBasic:
      return 'static-text-view';
    case PlatformViewType.kInput:
      return 'input-grid-view';
    case PlatformViewType.kMap:
      return 'google-map-view';
  }
}

class PlatformView extends StatelessWidget {
  const PlatformView({Key? key, required this.viewType}) : super(key: key);
  final PlatformViewType viewType;

  @override
  Widget build(BuildContext context) {
    // Pass parameters to the platform side.
    final Map<String, dynamic> creationParams = <String, dynamic>{};

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        // Texture Layer Hybrid composition
        return Container(
            decoration: BoxDecoration(border: Border.all(width: 1)),
            child: AndroidView(
              viewType: _platformViewTypeAsString(viewType),
              layoutDirection: TextDirection.ltr,
              creationParams: creationParams,
              creationParamsCodec: const StandardMessageCodec(),
            ));
      default:
        throw UnsupportedError(
            'Unsupported TargetPlatform: $defaultTargetPlatform');
    }
  }
}
