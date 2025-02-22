import 'package:d_reader_flutter/ui/shared/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonCard extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsets? margin;
  const SkeletonCard({
    Key? key,
    this.height = 255,
    this.width = 180,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      shimmerDuration: 1000,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        decoration: BoxDecoration(
          color: ColorPalette.dReaderGrey,
          borderRadius: BorderRadius.circular(
            16,
          ),
        ),
        foregroundDecoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              ColorPalette.boxBackground200,
              Colors.transparent,
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: [0, 0.8],
          ),
        ),
      ),
    );
  }
}
