class Store{
  final int? id;
  final String? name;
  final String? key;
  final String? uri;
  final int? active;

  Store({
    this.id,
    this.name,
    this.key,
    this.uri,
    this.active
  });

  Store.fromMap(Map<String, dynamic> res)
      : id = res["id"],
        name = res["name"],
        key = res["key"],
        uri = res["uri"],
        active = res["active"];

  Map<String, Object?> toMap() {
    return {'id':id, 'name': name, 'key': key, 'uri': uri, 'active': active};
  }

  @override
  String toString() {
    return 'Store{id: $id, name: $name, key: $key, uri: $uri, active: $active}';
  }
}