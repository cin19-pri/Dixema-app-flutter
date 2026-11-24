class ProductRepository {
  // Lista compartida entre Gestión y Dashboard
  static final products = [
    {
      'name': 'Laptop HP',
      'price': '\$20,000 MXN / 3 unidades',
      'available': false,
      'image': 'assets/images/hp.jpg',
      'sold': '12',
    },
    {
      'name': 'Audífonos',
      'price': '\$900 MXN / 2 unidades',
      'available': true,
      'image': 'assets/images/audifonos.jpg',
      'sold': '35',
    },
    {
      'name': 'Pulsera Pandora',
      'price': '\$500 MXN / 9 unidades',
      'available': false,
      'image': 'assets/images/pandora.jpg',
      'sold': '28',
    },
    {
      'name': 'Sandwichera',
      'price': '\$39,900 MXN / 4 unidades',
      'available': false,
      'image': 'assets/images/sandwichera.jpg',
      'sold': '15',
    },
  ];

  static void addProduct(Map product) {
    products.insert(0, {
      'name': product['name'] ?? '',
      'price': product['price'] ?? '',
      'available': product['available'] ?? true,
      'image': product['image'] ?? 'assets/images/hp.jpg',
      'sold': '0',
      if (product['imageBytes'] != null) 'imageBytes': product['imageBytes'],
    });
  }

  static void removeProductAt(int index) {
    products.removeAt(index);
  }

  // Contadores dinámicos sincronizados con Gestión
  static int get availableCount =>
      products.where((p) => p['available'] == true).length;

  static int get totalProductsCount => products.length;

  static int get soldOutCount =>
      products.where((p) => p['available'] == false).length;
}