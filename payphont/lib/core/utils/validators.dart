class Validators {
  static String? phone(String? v) {
    if (v == null || v.isEmpty) return 'وارد کردن شماره تلفن الزامی است';
    if (!RegExp(r'^(09|\+989)\d{9}$').hasMatch(v)) {
      return 'شماره تلفن معتبر وارد کنید';
    }
    return null;
  }

  static String? amount(String? v) {
    if (v == null || v.isEmpty) return 'مبلغ را وارد کنید';
    if (double.tryParse(v) == null || double.parse(v) <= 0) {
      return 'مبلغ باید عدد مثبت باشد';
    }
    return null;
  }
}