
/// Represents a single piece of artwork that can be colored.
class Art {
  /// Unique identifier for the artwork.
  final String id;
  /// Name of the artwork.
  final String name;
  /// Path to the image file representing the artwork's lines.
  final String imagePath;
  /// Indicates whether the artwork is locked (requires purchase) or not.
  final bool isLocked;

  /// Creates an instance of [Art].
  Art({
    required this.id,
    required this.name,
    required this.imagePath,
    this.isLocked = false,
  });

}


/// Represents a pack of artwork that can be purchased.
class ContentPack {
  /// Unique identifier for the content pack.
  final String id;
  /// Name of the content pack.
  final String name;
  final String description;
  final String price;
  final String imageUrl;
  final List<Art> arts;
  ContentPack({required this.id, required this.name, required this.description, required this.price, required this.arts, required this.imageUrl});
  }

final List<ContentPack> contentPacks = [
  ContentPack(id: "1", name: "Pack 1", description: "Pack 1 description", price: "0.99", arts: [Art(id: "1", name: "Art 1", imagePath: "assets/art1.jpg"), Art(id: "2", name: "Art 2", imagePath: "assets/art2.jpg")], imageUrl: "assets/pack1.jpg"),  
  ContentPack(id: "2", name: "Pack 2", description: "Pack 2 description", price: "1.99", arts: [Art(id: "3", name: "Art 3", imagePath: "assets/art3.jpg"), Art(id: "4", name: "Art 4", imagePath: "assets/art4.jpg")], imageUrl: "assets/pack2.jpg"),  
];

