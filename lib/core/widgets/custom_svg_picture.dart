import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomSvgPicture extends StatelessWidget {
  const CustomSvgPicture({
    super.key,
    required this.path,
    this.height,
    this.width,
    this.withColorFilter = true,
  });

  const CustomSvgPicture.withoutColor({
    super.key,
    required this.path,
    this.height,
    this.width,
  }) : withColorFilter = false;

  final String path;
  final bool withColorFilter;
  final double? height;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      height: height ?? 24,
      width: width ?? 24,
      colorFilter: withColorFilter
          ? ColorFilter.mode(
              Theme.of(context).colorScheme.secondary,
              BlendMode.srcIn,
            )
          : null,
      // fit: BoxFit.scaleDown,
    );
  }
}
