import 'package:flutter/material.dart';

import '../Utilities/constants.dart';

class LinePainterCustom extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    const p1 = Offset(50, 5);
    const p2 = Offset(20, 30);

    const p3 = Offset(50, -10);
    const p4 = Offset(0, 30);

    const p5 = Offset(30, -10);
    const p6 = Offset(-20, 30);

    final paint = Paint()
      ..color = Constants.diagonalColorPainter
      ..strokeWidth = 5;
    canvas.drawLine(p1, p2, paint);
    canvas.drawLine(p3, p4, paint);
    canvas.drawLine(p5, p6, paint);
    canvas.clipRect(rect);
  }

  @override
  bool shouldRepaint(LinePainterCustom oldDelegate) => false;
}

class MyCustomClipper extends CustomClipper<Path> {
  final double extent;

  MyCustomClipper({required this.extent});

  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, extent);
    path.lineTo(extent, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class StripsWidget extends StatelessWidget {
  final Color color1;
  final Color color2;
  final double gap;
  final noOfStrips;

  const StripsWidget(
      {Key? key, required this.color1, required this.color2, required this.gap, this.noOfStrips})
      : super(key: key);

  List<Widget> getListOfStripes() {
    List<Widget> stripes = [];
    for (var i = 0; i < noOfStrips; i++) {
      stripes.add(
        ClipPath(
          clipper: MyCustomClipper(extent: i*gap),
          child: Container(color: (i%2==0)?color1:color2),
        ),
      );
    }
    return stripes;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: getListOfStripes());
  }
}
