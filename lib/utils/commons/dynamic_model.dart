class DynamicModel {
  final Map<String, dynamic> properties;

  DynamicModel(this.properties);

  factory DynamicModel.fromJson(Map<String, dynamic> json) {
    return DynamicModel(json);
  }

  T? getProperty<T>(String key) {
    return properties[key] as T?;
  }

  Map<String, dynamic> toJson() {
    return properties;
  }
}