class KeyValueModel {
  final String id;
  final String name;

  KeyValueModel({required this.id, required this.name});

  @override
  String toString() {
    return name; // Use this property to display in the dropdown
  }

  List<String> toList() {
    return [name, id];  // Return a list of strings
  }
}