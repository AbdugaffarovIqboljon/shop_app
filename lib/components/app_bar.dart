import 'package:shop_app/library.dart';

abstract class BasicAppBar {
  static PreferredSizeWidget defaultAppBar(
    BuildContext context, {
    String title = '',
    List<Widget>? actions,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: (() => Navigator.pop(context)),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 24,
          color: Color(0xFF212121),
        ),
      ),
      centerTitle: true,
      actions: actions,
    );
  }
}
