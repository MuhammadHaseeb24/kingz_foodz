class Formatters {
  static String rupees(num value) {
    final s = value.round().toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      final posFromEnd = s.length - i;
      buffer.write(s[i]);
      if (posFromEnd > 1 && posFromEnd % 3 == 1) buffer.write(',');
    }
    return 'Rs. $buffer';
  }
}
