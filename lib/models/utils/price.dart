class Price {
  const Price(this.amount);

  final double amount;

  Price operator +(Price other) => Price(amount + other.amount);

  Price operator *(num times) => Price(amount * times);

  @override
  String toString() => amount.toStringAsFixed(2);
}
