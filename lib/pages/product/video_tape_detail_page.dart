import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:video_tape_store/utils/constants.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:video_tape_store/pages/cart/cart_page.dart';

class VideoTapeDetailPage extends StatefulWidget {
  final VideoTape tape;

  const VideoTapeDetailPage({
    super.key,
    required this.tape,
  });

  @override
  State<VideoTapeDetailPage> createState() => _VideoTapeDetailPageState();
}

class _VideoTapeDetailPageState extends State<VideoTapeDetailPage> {
  int _currentImageIndex = 0;
  bool _isAddingToCart = false;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 400,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  CarouselSlider(
                    carouselController: _carouselController,
                    options: CarouselOptions(
                      height: double.infinity,
                      viewportFraction: 1.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentImageIndex = index;
                        });
                      },
                    ),
                    items: widget.tape.imageUrls.map((url) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Image.network(
                            url,
                            fit: BoxFit.cover,
                          );
                        },
                      );
                    }).toList(),
                  ),
                  // Image carousel indicators
                  Positioned(
                    bottom: 16,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          widget.tape.imageUrls.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () =>
                              _carouselController.animateToPage(entry.key),
                          child: Container(
                            width: 8,
                            height: 8,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentImageIndex == entry.key
                                  ? AppColors.primaryColor
                                  : Colors.white.withOpacity(0.4),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(AppDimensions.paddingMedium),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(
                  widget.tape.title,
                  style: AppTextStyles.headingLarge,
                ),
                const SizedBox(height: AppDimensions.marginMedium),
                Text(
                  '\$${widget.tape.price.toStringAsFixed(2)}',
                  style: AppTextStyles.priceText,
                ),
                const SizedBox(height: AppDimensions.marginMedium),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingSmall,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusSmall,
                        ),
                      ),
                      child: Text(
                        widget.tape.genreName,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppDimensions.marginMedium),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.tape.rating.toStringAsFixed(1),
                          style: AppTextStyles.bodyMedium,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '(${widget.tape.totalReviews})',
                          style: AppTextStyles.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppDimensions.marginLarge),
                Text(
                  'Description',
                  style: AppTextStyles.headingSmall,
                ),
                const SizedBox(height: AppDimensions.marginSmall),
                Text(
                  widget.tape.description,
                  style: AppTextStyles.bodyMedium,
                ),
                const SizedBox(height: AppDimensions.marginLarge),
              ]),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
  padding: const EdgeInsets.all(AppDimensions.paddingMedium),
  decoration: BoxDecoration(
    color: AppColors.surfaceColor,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.1),
        blurRadius: 8,
        offset: const Offset(0, -4),
      ),
    ],
  ),
  child: SafeArea(
    child: ElevatedButton(
      onPressed: _isAddingToCart ? null : () {
        // TODO: Implement add to cart
        setState(() => _isAddingToCart = true);
        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) {
            setState(() => _isAddingToCart = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${widget.tape.title} added to cart'),
                action: SnackBarAction(
                  label: 'View Cart',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartPage(),
                      ),
                    );
                  },
                ),
              ),
            );
          }
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingMedium,
        ),
        minimumSize: const Size.fromHeight(48), // Tambahkan ini
      ),
      child: _isAddingToCart
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Text(
              'Add to Cart',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    ),
  ),
),
    );
  }
}
