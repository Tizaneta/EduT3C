import 'package:flutter/material.dart';
import '../models/shop_product.dart';
import '../services/api_service.dart';
import '../models/user.dart';
import '../data/session.dart';

class ProductDetailScreen extends StatefulWidget {
  final ShopProduct product;
  final Future<void> Function()? onPurchaseCompleted;
  final VoidCallback? onBackToHome;
  const ProductDetailScreen({
    super.key,
    required this.product,
    this.onPurchaseCompleted,
    this.onBackToHome,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B18),
      appBar: AppBar(
        backgroundColor: const Color(0xFF071A30),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'TIENDA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Color(0xFF00C7E8),
          ),
          onPressed: () {
          widget.onBackToHome?.call();
          Navigator.pop(context);
        },
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 48,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ProductImage(
                      imagePath: widget.product.imagePath,
                    ),

                    const SizedBox(height: 20),

                    _ProductInfo(
                      product: widget.product,
                    ),

                    const SizedBox(height: 18),
                    _PriceCard(
                      price: widget.product.price,
                    ),
                    const SizedBox(height: 20),
                    _BuyButton(
            onPressed: () async {
            final currentUser = Session.currentUser;
            if (currentUser == null) {
              ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
              content: Text(
              'No hay un usuario seleccionado para realizar la compra.',
              ),
            ),
          );
          return;
          }

    try {
      await ApiService.buyItem(
        currentUser.id,
        widget.product.id,
      );

    if (widget.onPurchaseCompleted != null) {
      await widget.onPurchaseCompleted!();
    }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '¡Compra realizada correctamente!',
          ),
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            e.toString().replaceFirst('Exception: ', ''),
          ),
        ),
      );
    }
  },
),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  final String imagePath;

  const _ProductImage({
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      decoration: BoxDecoration(
        color: const Color(0xFF081525),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF087EA4),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00C7E8).withValues(alpha: 0.12),
            blurRadius: 22,
            spreadRadius: 1,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

class _ProductInfo extends StatelessWidget {
  final ShopProduct product;

  const _ProductInfo({
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return _CyberCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
          ),

          if (product.type != null) ...[
            const SizedBox(height: 6),

            Text(
              product.type!.toUpperCase(),
              style: const TextStyle(
                color: Color(0xFF00C7E8),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],

          const SizedBox(height: 14),

          Text(
            product.description,
            style: const TextStyle(
              color: Color(0xFF9CB2C4),
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}


class _PriceCard extends StatelessWidget {
  final int price;

  const _PriceCard({
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return _CyberCard(
      child: Row(
        children: [
          Image.asset(
            'assets/images/bits.png',
            width: 42,
            height: 42,
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Text(
              'PRECIO',
              style: TextStyle(
                color: Color(0xFF7891A3),
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),
          ),

          Text(
            '$price',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.w800,
            ),
          ),

          const SizedBox(width: 6),

          const Text(
            'BITS',
            style: TextStyle(
              color: Color(0xFF00C7E8),
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuyButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BuyButton({
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 58,
      child: ElevatedButton(
      onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF087EA4),
          foregroundColor: Colors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(
              color: Color(0xFF00C7E8),
              width: 1,
            ),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 21,
            ),
            SizedBox(width: 10),
            Text(
              'COMPRAR',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CyberCard extends StatelessWidget {
  final Widget child;

  const _CyberCard({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: const Color(0xFF091827),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: const Color(0xFF16445C),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}

