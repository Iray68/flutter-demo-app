String capitalize(String string) {
  return string.runes.fold('', (String value, int rune) {
    final String char = String.fromCharCode(rune);

    if (value.isEmpty) {
      return char.toUpperCase();
    }

    return value + char;
  });
}