import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'platformviews.dart';

class TransformWidget extends StatefulWidget {
  const TransformWidget({Key? key, required this.title, required this.viewType})
      : super(key: key);

  final String title;
  final PlatformViewType viewType;

  @override
  State<StatefulWidget> createState() => _TransformWidgetState();
}

class _TransformWidgetState extends State<TransformWidget> {
  double opacity = 1.0;
  double radius = 0;
  double scale = 1.0;
  double angle = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                MutatorNativeView(
                  angle: -math.pi / 180 * angle,
                  opacity: opacity,
                  radius: radius,
                  scale: scale,
                  viewType: widget.viewType,
                ),
                Opacity(
                  opacity: 0.5,
                  child: Container(
                    constraints: BoxConstraints.expand(
                      height: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .fontSize! *
                              1.1 +
                          50.0,
                    ),
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.blue[600],
                    alignment: Alignment.center,
                    transform: Matrix4.rotationZ(0.2),
                    child: Text('Flutter UI',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(color: Colors.white)),
                  ),
                ),
              ],
            ),
            // SizedBox(height: 256),
            Row(
              children: [
                const Text('Opacity'),
                Slider(
                  value: opacity,
                  min: 0.0,
                  max: 1.0,
                  divisions: 20,
                  activeColor: Colors.greenAccent,
                  label: opacity.toString(),
                  onChanged: (double value) {
                    setState(() {
                      opacity = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Rotate'),
                Slider(
                  value: angle,
                  min: 0.0,
                  max: 360.0,
                  divisions: 72,
                  activeColor: Colors.greenAccent,
                  label: angle.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      angle = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Radius'),
                Slider(
                  value: radius,
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  activeColor: Colors.greenAccent,
                  label: radius.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      radius = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                const Text('Scale'),
                Slider(
                  value: scale,
                  min: 0.0,
                  max: 1.0,
                  divisions: 10,
                  activeColor: Colors.greenAccent,
                  label: scale.toString(),
                  onChanged: (double value) {
                    setState(() {
                      scale = value;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MutatorNativeView extends StatelessWidget {
  const MutatorNativeView(
      {required this.angle,
      required this.opacity,
      required this.radius,
      required this.scale,
      required this.viewType,
      Key? key})
      : super(key: key);
  final double opacity;
  final double radius;
  final double angle;
  final double scale;
  final PlatformViewType viewType;

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: angle,
      child: Transform.scale(
        scale: scale,
        child: Opacity(
          opacity: opacity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: SizedBox(
                height: 300,
                width: 300,
                child: PlatformView(viewType: viewType)),
          ),
        ),
      ),
    );
  }
}
