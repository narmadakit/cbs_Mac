class KeyValueModel {
  final String id;
  final String name;

  KeyValueModel({required this.id, required this.name});

  @override
  String toString() {
    return name; // Use this property to display in the dropdown
  }
}