// lib/common/validators.dart
class Validators {
  static String? notEmpty(String? v) {
    if (v == null || v.trim().isEmpty) return 'Required';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final r = RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');
    if (!r.hasMatch(v.trim())) return 'Invalid email';
    return null;
  }

  static String? Function(String?) minLen(int n) {
    return (String? v) {
      if (v == null || v.length < n) return 'Min $n characters';
      return null;
    };
  }
}
