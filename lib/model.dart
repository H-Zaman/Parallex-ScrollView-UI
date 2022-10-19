class ParallaxItemModel{
  final String asset;
  double topDelta;
  double deltaFactor;

  ParallaxItemModel({
    required this.asset,
    required this.deltaFactor,
    this.topDelta = 0
  });
}