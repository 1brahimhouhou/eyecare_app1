class Validators {
  static String? required(String? v, {String field = 'This field'}) =>
      (v == null || v.trim().isEmpty) ? '$field is required' : null;

  static String? email(String? v) {
    if (v == null || v.isEmpty) return 'Email is required';
    final ok = RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(v);
    return ok ? null : 'Enter a valid email';
  }

  static String? minLen(String? v, int n, {String field = 'Password'}) =>
      (v == null || v.length < n) ? '$field must be at least $n chars' : null;
}
