class CounterListMode {
  int count;
  String name;

  CounterListMode({
    required this.count,
    required this.name,
  });

  factory CounterListMode.fromJson(Map json) => CounterListMode(
        count: json['count'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'count': count,
        'name': name,
      };
}
