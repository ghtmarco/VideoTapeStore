import 'package:flutter/material.dart';
import 'package:video_tape_store/utils/constants.dart';
import 'package:video_tape_store/models/video_tape.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isLoading = false;

  // TODO: Replace with actual cart data
  final List<CartItem> _cartItems = [];

  double get _totalPrice => _cartItems.fold(
    0,
    (sum, item) => sum + (item.tape.price * item.quantity),
  );

  void _updateQuantity(int index, int newQuantity) {
    setState(() {
      if (newQuantity > 0) {
        _cartItems[index].quantity = newQuantity;
      } else {
        _cartItems.removeAt(index);
      }
    });
  }

  Future<void> _checkout() async {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Your cart is empty'),
          backgroundColor: AppColors.errorColor,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // TODO: Implement actual checkout logic
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.surfaceColor,
            title: const Text('Thank You!'),
            content: const Text('Your order has been placed successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Return to previous page
                },
                child: const Text('Continue Shopping'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to place order. Please try again.'),
            backgroundColor: AppColors.errorColor,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Shopping Cart',
          style: AppTextStyles.headingMedium,
        ),
      ),
      body: _cartItems.isEmpty
          ? _buildEmptyCart()
          : _buildCartContent(),
      bottomNavigationBar: _cartItems.isEmpty
          ? null
          : _buildCheckoutBar(),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: AppDimensions.iconSizeLarge * 2,
            color: AppColors.primaryColor,
          ),
          const SizedBox(height: AppDimensions.marginLarge),
          Text(
            'Your cart is empty',
            style: AppTextStyles.headingSmall,
          ),
          const SizedBox(height: AppDimensions.marginMedium),
          Text(
            'Add some video tapes to get started!',
            style: AppTextStyles.bodyMedium,
          ),
          const SizedBox(height: AppDimensions.marginLarge),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingLarge,
                vertical: AppDimensions.paddingMedium,
              ),
            ),
            child: const Text('Browse Video Tapes'),
          ),
        ],
      ),
    );
  }

  Widget _buildCartContent() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      itemCount: _cartItems.length,
      itemBuilder: (context, index) {
        final item = _cartItems[index];
        return _buildCartItem(item, index);
      },
    );
  }

  Widget _buildCartItem(CartItem item, int index) {
    return Dismissible(
      key: Key(item.tape.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppDimensions.paddingMedium),
        color: AppColors.errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      onDismissed: (direction) {
        setState(() => _cartItems.removeAt(index));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${item.tape.title} removed from cart'),
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() => _cartItems.insert(index, item));
              },
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: AppDimensions.marginMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingMedium),
          child: Row(
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.borderRadiusSmall),
                child: Image.network(
                  item.tape.imageUrls.first,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: AppDimensions.marginMedium),

              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.tape.title,
                      style: AppTextStyles.bodyMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppDimensions.marginSmall),
                    Text(
                      '\$${item.tape.price.toStringAsFixed(2)}',
                      style: AppTextStyles.priceText,
                    ),
                  ],
                ),
              ),

              // Quantity controls
              Column(
                children: [
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _updateQuantity(index, item.quantity + 1),
                  ),
                  Text(
                    '${item.quantity}',
                    style: AppTextStyles.bodyMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => _updateQuantity(index, item.quantity - 1),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCheckoutBar() {
    return Container(
      padding: const EdgeInsets.all(AppDimensions.paddingMedium),
      decoration: BoxDecoration(
        color: AppColors.surfaceColor,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.borderRadiusMedium),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total:',
                style: AppTextStyles.bodySmall,
              ),
              Text(
                '\$${_totalPrice.toStringAsFixed(2)}',
                style: AppTextStyles.headingMedium,
              ),
            ],
          ),
          const SizedBox(width: AppDimensions.marginMedium),
          Expanded(
            child: ElevatedButton(
              onPressed: _isLoading ? null : _checkout,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.successColor,
                padding: const EdgeInsets.symmetric(
                  vertical: AppDimensions.paddingMedium,
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}

class CartItem {
  final VideoTape tape;
  int quantity;

  CartItem({
    required this.tape,
    this.quantity = 1,
  });
}