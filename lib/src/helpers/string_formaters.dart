String valueWithCurrency(double value, String symbol, bool onLeft) {
  String sign = value < 0 ? "-" : "";
  String prefix = onLeft ? symbol : "";
  String stringValue = value.abs().toStringAsFixed(2);
  String suffix = onLeft ? "" : " ${symbol}";
  return sign + prefix + stringValue + suffix;
}
