// ARCHIVO: lib/screens/StoreScreen.dart
//
// Pantalla principal de la tienda de EduT3C.
//
// Qué recibe:
//   user → objeto User completo (viene de home.dart igual que SocialProfileScreen)
//
// Cómo funciona la navegación a ProductDetailScreen:
//   Al tocar una card → Navigator.push a ProductDetailScreen
//   con el ShopProduct correspondiente (ya existe en tu proyecto).
//
// Cómo funciona el filtro por tabs:
//   _selectedType guarda el `type` del Item activo.
//   Los items se filtran localmente sobre la lista ya cargada.
//   Tocar una tab = setState → GridView se reconstruye con el subconjunto.
//
// Conexión con el backend:
//   _loadItems() llama a ApiService.getItems() → GET /items (o el endpoint
//   que uses para la tienda). Ajusta el método según tu api_service.dart.
//   Por ahora el método está marcado con TODO para que lo conectes vos.
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/shop_product.dart';
import '../services/api_service.dart';
import 'ProductDetailScreen.dart';
import 'home.dart';

// ── Paleta (solo constantes visuales) ───────────────────────
const _bgDark       = Color(0xFF050B18);
const _bgCard       = Color(0xFF091827);
const _bgCardBorder = Color(0xFF16445C);
const _accentBlue   = Color(0xFF087EA4);
const _accentCyan   = Color(0xFF00C7E8);
const _textPrimary  = Colors.white;
const _textMuted    = Color(0xFF9CB2C4);
const _textDim      = Color(0xFF5C7185);

// Tabs disponibles — el value coincide exactamente con item.type del backend.
// Si tu backend usa nombres distintos, cambialos acá.
const List<_TabDef> _tabs = [
  _TabDef(label: 'BOOSTERS',  value: 'boost',    icon: Icons.bolt_rounded),
  _TabDef(label: 'AVATARES',  value: 'avatar',   icon: Icons.person_outline_rounded),
  _TabDef(label: 'MARCOS',    value: 'frame',    icon: Icons.crop_square_rounded),
  _TabDef(label: 'TÍTULOS',   value: 'title',    icon: Icons.emoji_events_outlined),
];

class _TabDef {
  final String label;
  final String value;  // coincide con Item.type en el backend
  final IconData icon;
  const _TabDef({required this.label, required this.value, required this.icon});
}

// ════════════════════════════════════════════════════════════
class StoreScreen extends StatefulWidget {
  final User user;

  const StoreScreen({
  super.key, required this.user,
  this.onPurchaseCompleted,
  this.onBackToHome,         
  });
  final Future<void> Function()? onPurchaseCompleted;
  final VoidCallback? onBackToHome;
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  // Tab activa → filtra la lista por type
  String _selectedType = _tabs.first.value;

  // Estado de carga
  bool _loading = true;
  String? _error;

  // Lista completa de productos cargados del backend
  List<ShopProduct> _allProducts = [];

  // Subconjunto filtrado por la tab activa
  List<ShopProduct> get _filtered {
  return _allProducts.where((product) {
    return product.type?.trim().toLowerCase() ==
        _selectedType.trim().toLowerCase();
  }).toList();
}

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  

Future<void> _loadItems() async {
  setState(() {
    _loading = true;
    _error = null;
  });

  try {
    final items = await ApiService.getItems();
  
    final products = items.map((item) {
      debugPrint('Producto: ${item.name} | Icon: ${item.icon}');
      return ShopProduct.fromItem(item, imagePath: item.icon ?? 'assets/images/default_item.png',);
      }).toList();
    
    if (!mounted) return;

    setState(() {
      _allProducts = products;
      _loading = false;
    });
  } catch (e) {
    if (!mounted) return;

    setState(() {
      _error = e.toString().replaceFirst('Exception: ', '');
      _loading = false;
    });
  }
}

  // Se llama cuando ProductDetailScreen vuelve con `true` (compra exitosa).
  // Recarga los items por si el backend actualizó disponibilidad.
  void _onProductPurchased() => _loadItems();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgDark,
      body: Column(
        children: [
          // ── Banner superior ────────────────────────────────
          _StoreBanner(),

          // ── Tabs de categoría ──────────────────────────────
          _CategoryTabs(
            tabs: _tabs,
            selectedValue: _selectedType,
            onSelected: (v) => setState(() => _selectedType = v),
          ),

          // ── Grilla de productos ────────────────────────────
          Expanded(
            child: _loading
                ? const Center(
                    child: CircularProgressIndicator(color: _accentCyan))
                : _error != null
                    ? _ErrorState(message: _error!, onRetry: _loadItems)
                    : _filtered.isEmpty
                        ? _EmptyState(type: _selectedType)
                        : _ProductGrid(
                            products: _filtered,
                            onTap: (product) async {
                              final purchased = await Navigator.push<bool>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ProductDetailScreen(
                                    product: product,
                                    onPurchaseCompleted: widget.onPurchaseCompleted,
                                    onBackToHome: widget.onBackToHome,
                                  ),
                                ),
                              );
                              if (purchased == true) _onProductPurchased();
                            },
                          ),
          ),
        ],
      ),
    );
  }
}
 


// ════════════════════════════════════════════════════════════
// Banner superior: "TIENDA" + subtítulo + imagen mascota
// La imagen del mascota es un asset — ajusta la ruta si cambia.
// ════════════════════════════════════════════════════════════
class _StoreBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // Altura relativa para adaptarse a diferentes pantallas
      constraints: const BoxConstraints(maxHeight: 160),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF071A30), Color(0xFF06111F)],
        ),
        border: Border(
          bottom: BorderSide(color: _bgCardBorder),
        ),
      ),
      child: Stack(
        children: [
          // Texto izquierdo
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 160, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    const Icon(Icons.shopping_cart_outlined,
                        color: _accentCyan, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      'KIOS-T3C',
                      style: TextStyle(
                        color: _textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 2,
                        shadows: [
                          Shadow(
                              color: _accentCyan.withValues(alpha: 0.4),
                              blurRadius: 12),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Compra boosters, ítems y más para\npotenciar tu aprendizaje.',
                  style: TextStyle(
                    color: _textMuted,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Mascota — asset de la carpeta del proyecto
          // TODO: confirmar ruta real del asset del robot
          Positioned(
            right: 0,
            bottom: 0,
            top: 0,
            child: Image.asset(
              'assets/images/mascot.png',  // ← ajusta si el nombre es diferente
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => const SizedBox(width: 120),
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Tabs de categoría con scroll horizontal
// ════════════════════════════════════════════════════════════
class _CategoryTabs extends StatelessWidget {
  final List<_TabDef> tabs;
  final String selectedValue;
  final void Function(String) onSelected;

  const _CategoryTabs({
    required this.tabs,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF06111F),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: tabs.map((tab) {
            final selected = tab.value == selectedValue;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: _TabChip(
                tab: tab,
                selected: selected,
                onTap: () => onSelected(tab.value),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final _TabDef tab;
  final bool selected;
  final VoidCallback onTap;

  const _TabChip({
    required this.tab,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: selected ? _accentBlue.withValues(alpha: 0.25) : const Color(0xFF0B1C2E),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: selected ? _accentCyan : _bgCardBorder,
            width: selected ? 1.5 : 1,
          ),
          boxShadow: selected
              ? [BoxShadow(
                  color: _accentCyan.withValues(alpha: 0.18),
                  blurRadius: 10)]
              : null,
        ),
        child: Row(
          children: [
            Icon(tab.icon,
                color: selected ? _accentCyan : _textDim, size: 15),
            const SizedBox(width: 6),
            Text(
              tab.label,
              style: TextStyle(
                color: selected ? _textPrimary : _textDim,
                fontSize: 12,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Grilla 2 columnas de productos
// ════════════════════════════════════════════════════════════
class _ProductGrid extends StatelessWidget {
  final List<ShopProduct> products;
  final void Function(ShopProduct) onTap;

  const _ProductGrid({required this.products, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(14, 14, 14, 24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        // Relación alto/ancho de cada card.
        // Ajusta si el contenido se corta o sobra espacio.
        childAspectRatio: 0.72,
      ),
      itemCount: products.length,
      itemBuilder: (_, i) => _ProductCard(
        product: products[i],
        onTap: () => onTap(products[i]),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Card individual de producto
//
// Muestra:
//   - Imagen del item (product.imagePath → Image.asset)
//   - Nombre
//   - Descripción (2 líneas máx para no desbordar)
//   - Precio con assets/images/bits.png
//
// NO muestra duración ni bonificación (no existen en el modelo).
// ════════════════════════════════════════════════════════════
class _ProductCard extends StatelessWidget {
  final ShopProduct product;
  final VoidCallback onTap;

  const _ProductCard({required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: _bgCard,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _bgCardBorder),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen del producto
            Expanded(
              flex: 5,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF081525),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: _bgCardBorder,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Image.asset(
                      product.imagePath,
                      fit: BoxFit.contain,
                      // Placeholder si el asset no existe aún
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.image_outlined,
                        color: _bgCardBorder,
                        size: 36,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Info inferior
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nombre
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                    ),

                    const SizedBox(height: 3),

                    // Descripción — máx 2 líneas
                    Expanded(
                      child: Text(
                        product.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _textMuted,
                          fontSize: 10,
                          height: 1.3,
                        ),
                      ),
                    ),

                    const SizedBox(height: 6),

                    // Precio con ícono de Bits real
                    _PriceRow(price: product.price),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Fila de precio: [bits.png] [número] BITS
// Usa assets/images/bits.png — igual que home.dart y ProductDetailScreen
// ════════════════════════════════════════════════════════════
class _PriceRow extends StatelessWidget {
  final int price;
  const _PriceRow({required this.price});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: _accentBlue.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: _accentBlue.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/bits.png',
            width: 16,
            height: 16,
            // Fallback si el asset no carga
            errorBuilder: (_, __, ___) => const Icon(
              Icons.circle,
              color: _accentCyan,
              size: 14,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            '$price',
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 3),
          const Text(
            'BITS',
            style: TextStyle(
              color: _accentCyan,
              fontSize: 8,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Estados vacío y error
// ════════════════════════════════════════════════════════════
class _EmptyState extends StatelessWidget {
  final String type;
  const _EmptyState({required this.type});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.storefront_outlined, color: _bgCardBorder, size: 52),
          const SizedBox(height: 12),
          Text(
            'No hay productos en esta categoría.',
            style: const TextStyle(color: _textMuted, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off_rounded, color: _bgCardBorder, size: 48),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _textMuted, fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onRetry,
              child: const Text('Reintentar',
                  style: TextStyle(color: _accentCyan)),
            ),
          ],
        ),
      ),
    );
  }
}


