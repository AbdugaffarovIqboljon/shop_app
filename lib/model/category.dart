class Category {
  const Category(this.icon, this.title, this.id);

  final String icon;
  final String title;
  final String id;
}

final homeCategories = <Category>[
  const Category(
    'assets/icons/categories/ic_all.png',
    'All',
    'all',
  ),
  const Category(
    'assets/icons/categories/ic_shirt.png',
    "Clothing",
    "men's clothing",
  ),
  const Category(
    'assets/icons/categories/ic_jewelry.png',
    "Jewelery",
    "jewelery",
  ),
  const Category(
    'assets/icons/categories/ic_gadgets.png',
    "Electronics",
    "electronics",
  ),
  const Category(
    'assets/icons/categories/ic_woman_clothes.png',
    "Clothing",
    "women's clothing",
  ),
];
