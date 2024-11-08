import 'movie_item.dart';

class CartItem {
  final MovieItem movie;
  int quantity;

  CartItem({
    required this.movie,
    this.quantity = 1,
  });
}
