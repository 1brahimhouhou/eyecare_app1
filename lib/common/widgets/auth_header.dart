import 'package:flutter/material.dart';

class AppColors {
  static const primary   = Color(0xFF21C7C7); // أخضر-تركوازي للزر
  static const tint      = Color(0xFFE6FFFF); // سماوي فاتح للهيدر
  static const title     = Color(0xFF3C4461);
  static const muted     = Color(0xFF8A90A6);
  static const fieldFill = Color(0xFFEDEDED); // رمادي فاتح للفيلدات
}

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    const h = 260.0;
    return SizedBox(
      height: h,
      child: Stack(
        children: [
          // خلفية سماوية
          Container(color: AppColors.tint),

          // مثلّث أبيض نازل
          Align(
            alignment: Alignment.topCenter,
            child: ClipPath(
              clipper: _DownTriangleClipper(),
              child: Container(
                height: h,
                width: double.infinity,
                color: Colors.white,
              ),
            ),
          ),

          // عنوان الشاشة بظل
          Positioned(
            top: 24,
            left: 0,
            right: 0,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                    shadows: const [
                      Shadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 6),
                    ],
                  ),
            ),
          ),

          // لوجو + اسم البراند
          Align(
            alignment: const Alignment(0, 0.2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.remove_red_eye, size: 64, color: AppColors.primary),
                SizedBox(height: 8),
                Text('BabiVision', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: AppColors.title)),
                Text('Mobile',     style: TextStyle(fontSize: 16, color: AppColors.muted)),
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
    // مثلّث من أعلى يسار/يمين لنقطة بالمنتصف بالأسفل
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width / 2, size.height)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
