import 'package:flutter/material.dart';
import 'package:video_tape_store/pages/product/video_tape_detail_page.dart';
import 'package:video_tape_store/utils/constants.dart';
import 'package:video_tape_store/models/video_tape.dart';
import 'package:video_tape_store/pages/cart/cart_page.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedGenreIndex = 0;
  int _carouselIndex = 0;
  final _searchController = TextEditingController();
  bool _isLoading = true;

  // Sample data - akan diganti dengan data dari API
  final List<VideoTape> _featuredTapes = [
    VideoTape(
      id: '1',
      title: 'Jurassic Park',
      price: 29.99,
      description:
          'Experience the thrill of dinosaurs in this classic masterpiece.',
      genreId: '1',
      genreName: 'Sci-Fi',
      level: 1,
      imageUrls: [
        'https://picsum.photos/400/300?random=1',
        'https://picsum.photos/400/300?random=2',
        'https://picsum.photos/400/300?random=3',
      ],
      releasedDate: DateTime(1993),
      stockQuantity: 5,
      rating: 4.8,
      totalReviews: 2453,
    ),
    // Tambahkan sample data lainnya
  ];

  List<VideoTape> get _filteredTapes {
    final query = _searchController.text.toLowerCase();
    if (query.isEmpty) return _featuredTapes;

    return _featuredTapes.where((tape) {
      return tape.title.toLowerCase().contains(query) ||
          tape.description.toLowerCase().contains(query) ||
          tape.genreName.toLowerCase().contains(query);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    try {
      // TODO: Fetch data from API
      await Future.delayed(const Duration(seconds: 2)); // Simulate loading
    } catch (e) {
      _showErrorSnackBar('Failed to load data. Please try again.');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: _buildAppBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: CustomScrollView(
                slivers: [
                  // Search Bar
                  _buildSearchBar(),

                  // Genre Filter
                  _buildGenreFilter(),

                  // Featured Carousel
                  SliverToBoxAdapter(
                    child: _buildFeaturedCarousel(),
                  ),

                  // Popular Section
                  _buildSectionHeader('Popular Video Tapes'),

                  // Grid View of Video Tapes
                  _buildVideoTapeGrid(),
                ],
              ),
            ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        AppStrings.appName,
        style: AppTextStyles.headingMedium,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartPage()),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {
            // TODO: Navigate to profile page
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return SliverPadding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      sliver: SliverToBoxAdapter(
        child: TextField(
          controller: _searchController,
          onChanged: (value) => setState(() {}),
          decoration: InputDecoration(
            hintText: 'Search video tapes...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: AppColors.surfaceColor,
            border: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(AppDimensions.borderRadiusSmall),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenreFilter() {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 50,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMedium),
          itemCount: VideoGenre.values.length,
          itemBuilder: (context, index) {
            final genre = VideoGenre.values[index];
            final isSelected = index == _selectedGenreIndex;

            return Padding(
              padding: const EdgeInsets.only(right: AppDimensions.paddingSmall),
              child: FilterChip(
                label: Text(genre.displayName),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() => _selectedGenreIndex = index);
                },
                backgroundColor: AppColors.surfaceColor,
                selectedColor: AppColors.primaryColor,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFeaturedCarousel() {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 200,
            viewportFraction: 0.8,
            enlargeCenterPage: true,
            autoPlay: true,
            onPageChanged: (index, reason) {
              setState(() => _carouselIndex = index);
            },
          ),
          items: _featuredTapes.map((tape) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(AppDimensions.borderRadiusMedium),
                    image: DecorationImage(
                      image: NetworkImage(tape.imageUrls.first),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          AppDimensions.borderRadiusMedium),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                    padding: const EdgeInsets.all(AppDimensions.paddingMedium),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tape.title,
                          style: AppTextStyles.headingSmall,
                        ),
                        const SizedBox(height: AppDimensions.marginSmall),
                        Row(
                          children: [
                            Text(
                              '\$${tape.price.toStringAsFixed(2)}',
                              style: AppTextStyles.priceText,
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  tape.rating.toStringAsFixed(1),
                                  style: AppTextStyles.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        const SizedBox(height: AppDimensions.marginSmall),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _featuredTapes.asMap().entries.map((entry) {
            return Container(
              width: 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _carouselIndex == entry.key
                    ? AppColors.primaryColor
                    : AppColors.surfaceColor,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      sliver: SliverToBoxAdapter(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: AppTextStyles.headingSmall),
            TextButton(
              onPressed: () {
                // TODO: Navigate to see all
              },
              child: const Text('See All'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoTapeGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: AppDimensions.marginMedium,
          mainAxisSpacing: AppDimensions.marginMedium,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final tape = _filteredTapes[index];
            return _buildVideoTapeCard(tape);
          },
          childCount: _filteredTapes.length,
        ),
      ),
    );
  }

  Widget _buildVideoTapeCard(VideoTape tape) {
    return GestureDetector(
      onTap: () => _navigateToDetail(tape),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(AppDimensions.borderRadiusSmall),
              ),
              child: AspectRatio(
                aspectRatio: 3 / 4,
                child: Stack(
                  children: [
                    Image.network(
                      tape.imageUrls.first,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    if (tape.stockQuantity < 5)
                      Positioned(
                        top: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppDimensions.paddingSmall,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.borderRadiusSmall,
                            ),
                          ),
                          child: Text(
                            'Low Stock',
                            style: AppTextStyles.bodySmall.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tape.genreName,
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.secondaryColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              tape.title,
                              style: AppTextStyles.bodyMedium,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Details
            Padding(
              padding: const EdgeInsets.all(AppDimensions.paddingSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Price and Rating
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${tape.price.toStringAsFixed(2)}',
                        style: AppTextStyles.priceText,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 16,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            tape.rating.toStringAsFixed(1),
                            style: AppTextStyles.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.marginSmall),

                  // Add to Cart Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _addToCart(tape),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.successColor,
                        padding: const EdgeInsets.symmetric(
                          vertical: AppDimensions.paddingSmall,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppDimensions.borderRadiusSmall,
                          ),
                        ),
                      ),
                      child: Text(
                        AppStrings.addToCart,
                        style: AppTextStyles.buttonText.copyWith(fontSize: 12),
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

  void _navigateToDetail(VideoTape tape) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoTapeDetailPage(tape: tape),
      ),
    );
  }

  void _addToCart(VideoTape tape) {
    // TODO: Implement actual cart functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${tape.title} added to cart'),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
