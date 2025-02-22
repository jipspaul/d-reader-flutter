class CollectionStatsModel {
  final int floorPrice, itemsListed, totalVolume;

  CollectionStatsModel({
    required this.totalVolume,
    required this.itemsListed,
    required this.floorPrice,
  });

  factory CollectionStatsModel.fromJson(Map<String, dynamic> json) {
    return CollectionStatsModel(
      totalVolume: json['totalVolume'],
      itemsListed: json['itemsListed'],
      floorPrice: json['floorPrice'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalVolume'] = totalVolume;
    data['itemsListed'] = itemsListed;
    data['floorPrice'] = floorPrice;
    return data;
  }
}
