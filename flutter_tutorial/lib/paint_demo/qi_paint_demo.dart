import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'flutter_tutorial.dart';
import 'qi_flutter_tutorial_paint.dart';

// 参考学习资料：https://book.flutterchina.club/chapter13/custom_paint.html

enum PaintType {
  // 绘制基本图形
  PaintBasicGraph,
  // 绘制渐变进度条
  PaintGradientProgress,
  // 绘制基本图案
  PaintBasicPattern,
  PaintSky,
  PaintAnimation,
}

class QiPaintful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QiPaintState();
  }
}

class QiPaintState extends State<QiPaintful> {
  PaintType _paintType = PaintType.PaintBasicGraph;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Text('Paint'),
        onPressed: () {},
      ),
      appBar: AppBar(
        title: Text('Paint'),
      ),
      body: ListView(
        children: <Widget>[
          _sectionTypeListTile('基本图形', paintType: PaintType.PaintBasicGraph),
          _sectionTypeListTile('渐变进度条',
              paintType: PaintType.PaintGradientProgress),
          _sectionTypeListTile('棋盘', paintType: PaintType.PaintBasicPattern),
          _sectionTypeListTile('天空', paintType: PaintType.PaintSky),
          _sectionTypeListTile('绘制更新动画', paintType: PaintType.PaintAnimation),
        ],
      ),
      // body: Center(
      //   child: buildCustomPaint(),
      // ),
    );
  }

  Widget _sectionTypeListTile(String title, {PaintType paintType}) {
    return ListTile(
      title: Text(
        '${paintType.index}. $title',
        style: TextStyle(
            backgroundColor: Colors.grey,
            fontStyle: FontStyle.italic,
            color: Colors.white,
            fontSize: 32.0),
      ),
      onTap: () {
        switch (paintType) {
          case PaintType.PaintBasicGraph:
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Skyful(0)));
            }
            break;
          case PaintType.PaintGradientProgress:
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      GradientCircularProgressRoute()));
            }
            break;
          case PaintType.PaintBasicPattern:
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => QiChessboardful()));
            }
            break;
          case PaintType.PaintSky:
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => Skyful(1)));
            }
            break;
          case PaintType.PaintAnimation:
            {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => FlutterMyPainter()));
            }
            break;
          default:
        }
      },
    );
  }

  CustomPaint buildCustomPaint() {
    switch (_paintType) {
      case PaintType.PaintBasicGraph:
        return CustomPaint(
          size: Size(300, 300),
          painter: QiChessboardPainter(),
        );
        break;
      case PaintType.PaintGradientProgress:
        return CustomPaint(
          size: Size(300, 300),
          painter: QiChessboardPainter(),
        );
        break;
      case PaintType.PaintBasicPattern:
        return CustomPaint(
          size: Size(300, 300),
          painter: QiChessboardPainter(),
        );
      default:
        return CustomPaint(
          size: Size(300, 300),
          painter: QiChessboardPainter(),
        );
    }
  }
}

class QiChessboardful extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return QiChessboardState();
  }
}

class QiChessboardState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('棋盘'),
      ),
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: QiChessboardPainter(),
        ),
      ),
    );
  }
}

// 参考学习资料：https://book.flutterchina.club/chapter13/custom_paint.html
// 绘制棋盘
class QiChessboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // 棋盘行数
    final int _chessboardRowLines = 15;
    // 棋盘列数
    final int _chessboardColumnLines = 15;
    // 棋盘每个小格的宽度
    double _chessboardWidth = size.width / _chessboardRowLines;
    // 棋盘每个小格子的高度
    double _chessboardHeight = size.height / _chessboardColumnLines;

    // 棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Color(0x77cdb175);
    canvas.drawRect(Offset.zero & size, paint);

    // 棋盘网格
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.black87
      ..strokeWidth = 1.0;

    // 绘制15条横线
    for (int i = 0; i <= _chessboardRowLines; ++i) {
      double dy = _chessboardHeight * i;
      canvas.drawLine(Offset(0, dy), Offset(size.width, dy), paint);
    }

    // 绘制15条竖线
    for (int i = 0; i <= _chessboardColumnLines; ++i) {
      double dx = _chessboardWidth * i;
      canvas.drawLine(Offset(dx, 0), Offset(dx, size.height), paint);
    }

    // (7,7)画一个黑子； 15/2 - 1/2 = 7行 15/2 - 1/2 = 7列
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    canvas.drawCircle(
        Offset(size.width / 2 - _chessboardWidth / 2,
            size.height * 0.5 - _chessboardHeight * 0.5),
        min(_chessboardWidth * 0.5, _chessboardHeight * 0.5),
        paint);

    // (8,8)画一个白子； 15/2 + 1/2 = 8 行 15/2 + 1/2 = 8列
    paint.color = Colors.white;
    canvas.drawCircle(
        Offset(size.width / 2 + _chessboardWidth * 0.5,
            size.height * 0.5 + _chessboardHeight * 0.5),
        min(_chessboardWidth * 0.5, _chessboardHeight * 0.5),
        paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class _PaintDemo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PaintDemoState();
  }
}

class _PaintDemoState extends State<_PaintDemo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('展示绘制Demo'),
      ),
      body: Center(
        child: Text('Demo'),
      ),
    );
  }
}
