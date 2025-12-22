import 'package:flutter/material.dart';
import 'package:eyecare_app/theme/colors.dart';


class AuthHeader extends StatelessWidget {
  const AuthHeader({
    super.key,
    required this.title,
    this.logoAsset = 'assets/images/babe.png',
    this.brandTitle = 'BabiVision',
    this.brandSubtitle = 'Mobile',
    this.height = 280,
  });

  final String title;
  final String logoAsset;
  final String brandTitle;
  final String brandSubtitle;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        children: [
          // Background tint
          Container(color: AppColors.tint),

          // Big white triangle in the middle (like your first screenshot)
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: _DownTriangleClipper(),
              child: Container(
                height: height,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ),

          // Title at top
          Positioned(
            top: 22,
            left: 0,
            right: 0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w700,
                    shadows: const [
                      Shadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 6),
                    ],
                  ),
            ),
          ),

          // Logo + text in center
          Align(
            alignment: const Alignment(0, 0.10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  logoAsset,
                  height: 70,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stack) {
                    return const Text(
                      'Logo not found (check pubspec.yaml + path)',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
                const SizedBox(height: 10),
                Text(
                  brandTitle,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: AppColors.title,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  brandSubtitle,
                  style: const TextStyle(
                    fontSize: 18,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DownTriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // Top-left -> Top-right -> Bottom-center -> close
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
