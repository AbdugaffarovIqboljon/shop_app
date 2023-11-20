class Category {
  const Category(this.icon, this.title, this.id);

  final String icon;
  final String title;
  final String id;
}

final homeCategories = <Category>[
  const Category('assets/icons/categories/shirt.png', "Clothing", "men's clothing"),
  const Category('assets/icons/categories/jewelry.png', "Jewelery", "jewelery"),
  const Category('assets/icons/categories/gadgets.png', "Electronics", "electronics"),
  const Category('assets/icons/categories/woman-clothes.png', "Clothing", "women's clothing"),
  const Category('assets/icons/categories/sand-clock.png', 'Others', 'sofa'),
];
