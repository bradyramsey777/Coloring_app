import 'package:flutter/material.dart';
import 'art.dart';
import 'coloring_page.dart';

/// This widget represents the art library page.
class ArtLibraryPage extends StatefulWidget {
  const ArtLibraryPage({super.key});

  @override
  State<ArtLibraryPage> createState() => _ArtLibraryPageState();
}
/// The state for the ArtLibraryPage widget.
class _ArtLibraryPageState extends State<ArtLibraryPage> {
  /// A list of content packs available in the app.
  ///
  /// Each content pack contains a list of art pieces that can be colored.
  /// The content packs are pre-defined here and include details such as
  /// the pack's ID, name, description, price, image URL, and the arts within it.
  final List<ContentPack> contentPacks = [
    ContentPack(
      id: '1',
      name: 'Pack 1',
      description: 'Description 1',
      price: '0.99',
      imageUrl: 'assets/pack1.jpg',
      arts: [
        Art(id: '1', name: 'Art 1', imagePath: 'assets/art1.jpg', isLocked: false),
        Art(id: '2', name: 'Art 2', imagePath: 'assets/art2.jpg', isLocked: false)
      ],
    ),
    ContentPack(
      id: '2',
      name: 'Pack 2',
      description: 'Description 2',
      price: '1.99',
      imageUrl: 'assets/pack2.jpg',
      arts: [
        Art(id: '3', name: 'Art 3', imagePath: 'assets/art3.jpg', isLocked: true),
        Art(id: '4', name: 'Art 4', imagePath: 'assets/art4.jpg', isLocked: true)
      ],
    ),
  
  ];

  /// Builds the UI for the ArtLibraryPage.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Gallery'),
        // Adds a back button to the app bar.
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Adds padding around the grid.
        child: GridView.builder(
           gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
          itemCount: contentPacks.length,

          
           itemBuilder: (BuildContext context, int index) {
            // Access the current content pack.
            final contentPack = contentPacks[index];
            return GestureDetector(
              onTap: () {
                // Navigate to the ColoringPage with the first art's image path.
                if (contentPack.arts.isNotEmpty) {
                   Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>  
                      ColoringPage(linesImage: contentPack.arts.first.imagePath,),
                  )
                  );
                }
              },
              child: Card(
                child: Column(
                  
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      // Displays the content pack's image.
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(8),
                          topRight: Radius.circular(8),
                        ),
                        child: Image.asset(
                          contentPack.imageUrl,
                          
                          fit: BoxFit.cover,
                        
                        ),
                      ),
                    ),
                    Padding(padding: const EdgeInsets.all(8),
                    child: Text(contentPack.name),), // Displays the content pack's name.
                  ],
                ),
              ),
            );
          },
        ),
      ), // Adds the grid view of content packs to the body.
    );
  }
}