import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'dart:math' as math;
// 参考学习网址：https://api.flutter.dev/flutter/rendering/CustomPainter-class.html
// https://api.flutter.dev/flutter/painting/RadialGradient-class.html
// https://github.com/sbis04/custom_painter/blob/master/visualizer/lib/main.dart

class Skyful extends StatefulWidget {
  Skyful(this.paintType);
  final paintType;
  @override
  State<StatefulWidget> createState() {
    return SkyState(paintType);
  }
}

class SkyState extends State<Skyful> {
  Center buildSky() {
    return Center(
      child: CustomPaint(
        size: Size(MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height),
        painter: Sky(),
      ),
    );
  }

  SkyState(this.paintType);
  final paintType;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: (paintType == 1)
            ? buildSky()
            : ListView(
                children: <Widget>[
                  CustomPaint(
                    size: Size(MediaQuery.of(context).size.width,
                        MediaQuery.of(context).size.height),
                    painter: BasicGraphPainter(),
                    // painter: Sky(),
                    // child: Center(
                    //   child: Text('Sky Sun'),
                    // ),
                  ),
                ],
              ),
      ),
    );
  }
}

class BasicGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final double sizeHeight = size.height;
    final double sizeWidth = size.width;

    // 绘制多个点
    final pointH = sizeHeight * 0.1;
    Offset point1 = Offset(sizeWidth * 0.2, pointH);
    Offset point11 = Offset(sizeWidth * 0.3, pointH);
    Offset point2 = Offset(sizeWidth * 0.4, pointH);
    Offset point3 = Offset(sizeWidth * 0.5, pointH);
    Offset point4 = Offset(sizeWidth * 0.6, pointH);
    Offset point44 = Offset(sizeWidth * 0.7, pointH);
    Offset point5 = Offset(sizeWidth * 0.8, pointH);

    final pointH2 = sizeHeight * 0.125;
    Offset point20 = Offset(sizeWidth * 0.15, pointH2);
    Offset point21 = Offset(sizeWidth * 0.25, pointH2);
    Offset point211 = Offset(sizeWidth * 0.35, pointH2);
    Offset point22 = Offset(sizeWidth * 0.45, pointH2);
    Offset point23 = Offset(sizeWidth * 0.55, pointH2);
    Offset point24 = Offset(sizeWidth * 0.65, pointH2);
    Offset point244 = Offset(sizeWidth * 0.75, pointH2);
    Offset point25 = Offset(sizeWidth * 0.85, pointH2);
    final List<Offset> pointsArr = [
      point1,
      point11,
      point2,
      point3,
      point3,
      point4,
      point44,
      point5,
      point20,
      point21,
      point211,
      point22,
      point23,
      point24,
      point244,
      point25,
    ];
    canvas.drawPoints(PointMode.points, pointsArr, paint);

    // 绘制线段
    Offset startPoint = Offset(0, sizeHeight * 0.15);
    Offset endPoint = Offset(sizeWidth, sizeHeight * 0.15);
    canvas.drawLine(startPoint, endPoint, paint);

    // 绘制三角形
    var path = Path();
    path.moveTo(sizeWidth * 0.25, sizeHeight * 0.2);
    path.lineTo(sizeWidth * 0.75, sizeHeight * 0.2);
    path.lineTo(sizeWidth * 0.5, size.height * 0.3);
    canvas.drawPath(path, paint);

    // 绘制椭圆
    paint
      ..color = Colors.brown
      ..style = PaintingStyle.fill;

    var ovalPath = Path();
    ovalPath.addOval(Rect.fromLTWH(
        sizeWidth * 0.1, sizeHeight * 0.3, sizeWidth * 0.6, sizeHeight * 0.2));

    canvas.drawPath(ovalPath, paint);

    // 绘制圆形
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.yellow;
    Offset circleCenter = Offset(sizeWidth * 0.5, sizeHeight * 0.4);
    canvas.drawCircle(circleCenter, sizeWidth * 0.1, paint);

    // 绘制多边形
    paint
      // ..style = PaintingStyle.stroke
      ..color = Colors.purple;
    var sides = 4;
    var polygonPath = Path();
    var angle = math.pi * 2 / sides;
    double radius = 50.0;

    Offset center = Offset(sizeWidth * 0.5, sizeHeight * 0.6);
    // center = Offset(200.0, 300.0);
    // startPoint1 => (100.0, 0.0);
    Offset startPoint1 = Offset(radius * math.cos(0.0), radius * math.sin(0.0));
    double moveToX = startPoint1.dx + center.dx;
    double moveToY = startPoint1.dy + center.dy;
    polygonPath.moveTo(moveToX, moveToY);
    print('$moveToX  $moveToY');

    // 当前情况 i 从1 开头也可
    for (var i = 0; i < sides; i++) {
      double x = radius * math.cos(angle * i) + center.dx;
      double y = radius * math.sin(angle * i) + center.dy;
      print('i:$i x:$x  y:$y');
      polygonPath.lineTo(x, y);
    }
    polygonPath.close();
    canvas.drawPath(polygonPath, paint);

    // 绘制五边形
    polygonPath = Path();
    paint
      // ..style = PaintingStyle.stroke
      ..color = Colors.pink[100];
    sides = 6;
    angle = math.pi * 2 / sides;
    radius = 80.0;

    center = Offset(sizeWidth * 0.5, sizeHeight * 0.6);
    // startPoint1 => (100.0, 0.0);
    startPoint1 = Offset(radius * math.cos(0.0), radius * math.sin(0.0));
    polygonPath.moveTo(startPoint1.dx + center.dx, startPoint1.dy + center.dy);

    for (var i = 0; i < sides; i++) {
      double x = radius * math.cos(angle * i) + center.dx;
      double y = radius * math.sin(angle * i) + center.dy;
      polygonPath.lineTo(x, y);
    }
    polygonPath.close();
    canvas.drawPath(polygonPath, paint);

    // 绘制文字
    final textSpan = TextSpan(
      text: "绘制文字",
      style: TextStyle(color: Colors.purple, fontSize: 16),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 100,
    );

    textPainter.paint(canvas, Offset(sizeWidth * 0.1, sizeHeight * 0.7));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// 参考学习网址：https://api.flutter.dev/flutter/rendering/CustomPainter-class.html
class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset.zero & size;
    var gradient = RadialGradient(
      center: const Alignment(0.7, -0.6),
      radius: 0.2,
      colors: [const Color(0xFFFFFF00), const Color(0xFF0099FF)],
      stops: [0.4, 1.0],
    );
    canvas.drawRect(
      rect,
      Paint()..shader = gradient.createShader(rect),
    );
  }

  @override
  SemanticsBuilderCallback get semanticsBuilder {
    return (Size size) {
      // Annotate a rectangle containing the picture of the sun
      // with the label "Sun". When text to speech feature is enabled on the
      // device, a user will be able to locate the sun on this picture by
      // touch.
      var rect = Offset.zero & size;
      var width = size.shortestSide * 0.4;
      rect = const Alignment(0.8, -0.9).inscribe(Size(width, width), rect);
      return [
        CustomPainterSemantics(
          rect: rect,
          properties: SemanticsProperties(
            label: 'Sun',
            textDirection: TextDirection.ltr,
          ),
        ),
      ];
    };
  }

  // Since this Sky painter has no fields, it always paints
  // the same thing and semantics information is the same.
  // Therefore we return false here. If we had fields (set
  // from the constructor) then we would return true if any
  // of them differed from the same fields on the oldDelegate.
  @override
  bool shouldRepaint(Sky oldDelegate) => false;
  @override
  bool shouldRebuildSemantics(Sky oldDelegate) => false;
}

// 如下代码复制自：https://github.com/sbis04/custom_painter/blob/master/visualizer/lib/main.dart
// FIXME: 如下代码运行过程中会输出异常信息 待查看问题并解决
class FlutterMyPainter extends StatefulWidget {
  @override
  _MyPainterState createState() => _MyPainterState();
}

class _MyPainterState extends State<FlutterMyPainter>
    with SingleTickerProviderStateMixin {
  var _radius = 100.0;
  // var _radians = 0.0;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 8),
    );

    Tween<double> _rotationTween = Tween(begin: -math.pi, end: math.pi);

    animation = _rotationTween.animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.repeat();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('绘制更新动画'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: CustomPaint(
                //
                foregroundPainter: PointPainter(_radius, animation.value),
                // 紫色的背景圆
                painter: _CirclePainter(_radius),
                child: Container(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text('Size'),
            ),
            Slider(
              value: _radius,
              min: 10.0,
              max: MediaQuery.of(context).size.width / 2,
              onChanged: (value) {
                setState(() {
                  _radius = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

// FOR PAINTING THE CIRCLE
class _CirclePainter extends CustomPainter {
  final double radius;
  _CirclePainter(this.radius);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    ));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

// FOR PAINTING THE TRACKING POINT
class PointPainter extends CustomPainter {
  final double radius;
  final double radians;
  PointPainter(this.radius, this.radians);

  @override
  void paint(Canvas canvas, Size size) {
    // 蓝绿色三角形
    var paint = Paint()
      ..color = Colors.teal
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 圆上的移动的黑点
    var pointPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    // 内部圆
    var innerCirclePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    // 圆周围移动的文字
    final textSpan = TextSpan(
      text:
          "(${(radius * math.cos(radians)).round()}, ${(radius * math.sin(radians)).round()})",
      style: TextStyle(color: Colors.black, fontSize: 16),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(
      minWidth: 0,
      maxWidth: 100,
    );

    var path = Path();

    Offset center = Offset(size.width / 2, size.height / 2);

    path.moveTo(center.dx, center.dy);

    Offset pointOnCircle = Offset(
      radius * math.cos(radians) + center.dx,
      radius * math.sin(radians) + center.dy,
    );

    // For showing the point moving on the circle
    canvas.drawCircle(pointOnCircle, 10, pointPaint);

    // For drawing the inner circle 绘制内部圆
    if (math.cos(radians) < 0.0) {
      canvas.drawCircle(center, -radius * math.cos(radians), innerCirclePaint);
      textPainter.paint(
        canvas,
        pointOnCircle + Offset(-radius * 0.7, 10),
      );
    } else {
      canvas.drawCircle(center, radius * math.cos(radians), innerCirclePaint);
      textPainter.paint(
        canvas,
        pointOnCircle + Offset(10, 10),
      );
    }

    path.lineTo(pointOnCircle.dx, pointOnCircle.dy);
    path.lineTo(pointOnCircle.dx, center.dy);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
