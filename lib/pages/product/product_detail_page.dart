import 'package:flutter/material.dart';
import 'package:video_tape_store/utils/constants.dart';
import 'package:video_tape_store/models/movie_item.dart';
import 'package:video_tape_store/models/cart_item.dart';

class ProductDetailPage extends StatelessWidget {
  final MovieItem movie;
  final List<CartItem> cartItems;

  const ProductDetailPage({
    super.key,
    required this.movie,
    required this.cartItems,
  });

  @override
  Widget build(BuildContext context) {
    // Tentukan warna tombol berdasarkan harga
    Color buttonColor;
    if (movie.price > 25) {
      buttonColor = Colors.red;
    } else if (movie.price > 20) {
      buttonColor = Colors.orange;
    } else {
      buttonColor = Colors.green;
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Detail Produk', style: AppStyles.kTitleTextStyle),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(movie.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(movie.name, style: AppStyles.kTitleTextStyle),
                  const SizedBox(height: 8),
                  Text(
                    '\$${movie.price.toStringAsFixed(2)}',
                    style: AppStyles.kSubtitleTextStyle,
                  ),
                  const SizedBox(height: 16),
                  const Text('Description',
                      style: AppStyles.kDescriptionTitleTextStyle),
                  const SizedBox(height: 8),
                  Text(movie.description),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        cartItems.add(CartItem(movie: movie));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('${movie.name} ditambahkan ke keranjang'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: buttonColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
