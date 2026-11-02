// ARCHIVO ÚNICO: lib/screens/InventoryScreen.dart
//
// Inventario del jugador. Todo vive en este archivo:
//   - paleta (mismos valores que StoreScreen y home.dart)
//   - modelo _InventoryItem
//   - llamadas HTTP (usan ApiService.baseUrl, no hace falta tocar ApiService)
//
// Endpoints (users.py):
//   GET  /users/<id>/items     → lista con quantity
//   POST /users/<id>/use-item  → solo type "boost"
//   POST /users/<id>/equip     → type "frame", "avatar" o "title"
//
// Compra → inventario: el backend ya guarda el objeto al comprar. Esta pantalla
// solo vuelve a pedir la lista: al construirse (el PageView descarta las
// páginas que salen de pantalla, así que al volver se ejecuta initState),
// con pull-to-refresh, y después de usar/equipar.

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../services/api_service.dart';

// ── Paleta (igual que StoreScreen) ──────────────────────────
const _bgDark     = Color(0xFF050B18);
const _bgPanel    = Color(0xFF06111F);
const _bgCard     = Color(0xFF091827);
const _bgChip     = Color(0xFF0B1C2E);
const _border     = Color(0xFF16445C);
const _accentBlue = Color(0xFF087EA4);
const _accentCyan = Color(0xFF00C7E8);
const _textMuted  = Color(0xFF9CB2C4);
const _textDim    = Color(0xFF5C7185);

// Mascota de la esquina: PNG/WebP con fondo transparente, declarado en pubspec.
const _mascotAsset = 'assets/images/mascot_reading.png';

// ── Constantes de diseño ────────────────────────────────────
const int _columns = 3;        // slots por fila
const int _minSlots = 6;       // mínimo de slots visibles (los vacíos son decorativos)
const double _slotRadius = 22; // corte de las esquinas

// ── Tabs: `type` coincide con Item.type del backend ─────────
class _InvTab {
  final String label;
  final String type;
  final IconData icon;
  const _InvTab({required this.label, required this.type, required this.icon});
}

const List<_InvTab> _tabs = [
  _InvTab(label: 'Monstec',         type: 'boost',  icon: Icons.bolt_rounded),
  _InvTab(label: 'Marcos',          type: 'frame',  icon: Icons.crop_square_rounded),
  _InvTab(label: 'Fotos de perfil', type: 'avatar', icon: Icons.account_circle_outlined),
  _InvTab(label: 'Títulos',         type: 'title',  icon: Icons.workspace_premium_outlined),
];

// ── Modelo: una fila de GET /users/<id>/items ───────────────
// `type` e `icon` son nullable porque hoy Item.to_dict() no los devuelve.
class _InventoryItem {
  final int id;
  final String name;
  final String description;
  final int quantity;
  final String? type;
  final String? icon;

  const _InventoryItem({
    required this.id,
    required this.name,
    required this.description,
    required this.quantity,
    this.type,
    this.icon,
  });

  factory _InventoryItem.fromJson(Map<String, dynamic> json) {
    return _InventoryItem(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      quantity: json['quantity'] as int,
      type: json['type'] as String?,
      icon: json['icon'] as String?,
    );
  }
}

// ════════════════════════════════════════════════════════════
class InventoryScreen extends StatefulWidget {
  final User user;

  const InventoryScreen({super.key, required this.user});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  String _selectedType = _tabs.first.type;
  bool _loading = true;
  String? _error;
  List<_InventoryItem> _items = [];

  // Un objeto sin `type` no aparece en ninguna tab.
  List<_InventoryItem> get _filtered =>
      _items.where((i) => i.type == _selectedType).toList();

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  // ── HTTP ────────────────────────────────────────────────

  Future<List<_InventoryItem>> _fetchInventory() async {
    final response = await http.get(
      Uri.parse('${ApiService.baseUrl}/users/${widget.user.id}/items'),
    );

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map((e) => _InventoryItem.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    throw Exception('No se pudo cargar el inventario.');
  }

  // endpoint: 'use-item' o 'equip'. Ambos reciben {"item_id": n}.
  Future<Map<String, dynamic>> _post(String endpoint, int itemId) async {
    final response = await http.post(
      Uri.parse('${ApiService.baseUrl}/users/${widget.user.id}/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'item_id': itemId}),
    );

    final data = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) return data;

    throw Exception(data['message']);
  }

  // ── Lógica ──────────────────────────────────────────────

  // silent = true: recarga sin spinner (pull-to-refresh y post-acción).
  Future<void> _loadItems({bool silent = false}) async {
    if (!silent) {
      setState(() {
        _loading = true;
        _error = null;
      });
    }

    try {
      final items = await _fetchInventory();
      if (!mounted) return;
      setState(() {
        _items = items;
        _loading = false;
        _error = null;
      });
    } catch (e) {
      if (!mounted) return;
      if (silent) {
        _snack(_errorText(e));
      } else {
        setState(() {
          _error = _errorText(e);
          _loading = false;
        });
      }
    }
  }

  // Errores del backend llegan como Exception("mensaje") → se muestra el
  // mensaje. Cualquier otro error (sin conexión, timeout) → texto genérico.
  String _errorText(Object e) {
    final text = e.toString();
    const prefix = 'Exception: ';
    return text.startsWith(prefix)
        ? text.substring(prefix.length)
        : 'No se pudo conectar con el servidor.';
  }

  void _snack(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // 2.0 → "2", 1.5 → "1.5"
  String _fmt(num n) =>
      n == n.roundToDouble() ? n.toInt().toString() : n.toString();

  // Botón de acción según el tipo (refleja use_item / equip_item del backend).
  String? _actionLabelFor(String? type) {
    switch (type) {
      case 'boost':
        return 'USAR';
      case 'frame':
      case 'avatar':
      case 'title':
        return 'EQUIPAR';
      default:
        return null; // tipo desconocido → solo "Cerrar"
    }
  }

  Future<void> _runAction(_InventoryItem item) async {
    try {
      final String message;

      if (item.type == 'boost') {
        final data = await _post('use-item', item.id);
        message = '${data['message']} x${_fmt(data['multiplier'] as num)}';
      } else {
        final data = await _post('equip', item.id);
        message = data['message'] as String;
      }

      if (!mounted) return;
      _snack(message);
      await _loadItems(silent: true); // usar consume 1 unidad
    } catch (e) {
      if (!mounted) return;
      _snack(_errorText(e));
    }
  }

  void _openItem(_InventoryItem item) {
    showModalBottomSheet(
      context: context,
      backgroundColor: _bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => _ItemSheet(
        item: item,
        actionLabel: _actionLabelFor(item.type),
        onAction: () {
          Navigator.pop(sheetContext); // cierro el sheet y después llamo al backend
          _runAction(item);
        },
        onClose: () => Navigator.pop(sheetContext),
      ),
    );
  }

  // ── UI ──────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    // La mascota ocupa el 34% del ancho: se adapta a cualquier pantalla.
    final mascotSize = MediaQuery.of(context).size.width * 0.34;

    return Scaffold(
      backgroundColor: _bgDark,
      body: Column(
        children: [
          const _TitleBanner(),
          _TabsRow(
            selectedType: _selectedType,
            onSelected: (t) => setState(() => _selectedType = t),
          ),
          Expanded(
            // Stack pinta en orden: primero la grilla, después la mascota encima.
            child: Stack(
              children: [
                Positioned.fill(child: _buildBody(mascotSize)),

                // Positioned ancla la mascota a la esquina inferior derecha.
                // IgnorePointer deja pasar los toques a los slots de abajo.
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: IgnorePointer(
                    child: Image.asset(
                      _mascotAsset,
                      width: mascotSize,
                      fit: BoxFit.contain,
                      // Si el asset no existe todavía, no rompe nada.
                      errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(double mascotSize) {
    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(color: _accentCyan),
      );
    }

    if (_error != null) {
      return _ErrorState(message: _error!, onRetry: () => _loadItems());
    }

    final items = _filtered;

    // Filas completas y al menos _minSlots.
    final fullRows = (items.length / _columns).ceil() * _columns;
    final slotCount = fullRows < _minSlots ? _minSlots : fullRows;

    return RefreshIndicator(
      color: _accentCyan,
      backgroundColor: _bgChip,
      onRefresh: () => _loadItems(silent: true),
      child: GridView.builder(
        // Permite pull-to-refresh aunque haya pocos slots.
        physics: const AlwaysScrollableScrollPhysics(),
        // Padding inferior = alto de la mascota, para scrollear por encima.
        padding: EdgeInsets.fromLTRB(14, 14, 14, mascotSize),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _columns,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.82, // si el contenido se corta, bajá este valor
        ),
        itemCount: slotCount,
        itemBuilder: (_, i) => i < items.length
            ? _ItemSlot(item: items[i], onTap: () => _openItem(items[i]))
            : const _EmptySlot(),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Título con marco de esquinas cortadas.
// BeveledRectangleBorder es nativo de Flutter (sin paquetes).
// ════════════════════════════════════════════════════════════
class _TitleBanner extends StatelessWidget {
  const _TitleBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: ShapeDecoration(
        color: _bgPanel,
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(26),
          side: const BorderSide(color: _accentCyan, width: 1.5),
        ),
        shadows: [
          BoxShadow(
            color: _accentCyan.withValues(alpha: 0.25),
            blurRadius: 16,
          ),
        ],
      ),
      // FittedBox achica el texto en pantallas angostas (evita overflow).
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          'INVENTARIO',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w900,
            letterSpacing: 3,
            shadows: [
              Shadow(
                color: _accentCyan.withValues(alpha: 0.5),
                blurRadius: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Tabs con scroll horizontal
// ════════════════════════════════════════════════════════════
class _TabsRow extends StatelessWidget {
  final String selectedType;
  final void Function(String) onSelected;

  const _TabsRow({required this.selectedType, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            for (final tab in _tabs)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _TabChip(
                  tab: tab,
                  selected: tab.type == selectedType,
                  onTap: () => onSelected(tab.type),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  final _InvTab tab;
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
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: ShapeDecoration(
          color: selected ? _accentBlue.withValues(alpha: 0.25) : _bgChip,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: selected ? _accentCyan : _border,
              width: selected ? 1.5 : 1,
            ),
          ),
          shadows: selected
              ? [
                  BoxShadow(
                    color: _accentCyan.withValues(alpha: 0.2),
                    blurRadius: 10,
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Icon(tab.icon, size: 16, color: selected ? _accentCyan : _textDim),
            const SizedBox(width: 6),
            Text(
              tab.label,
              style: TextStyle(
                color: selected ? Colors.white : _textDim,
                fontSize: 13,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ════════════════════════════════════════════════════════════
// Slot con objeto: imagen + nombre + cantidad (si es mayor a 1)
// ════════════════════════════════════════════════════════════
class _ItemSlot extends StatelessWidget {
  final _InventoryItem item;
  final VoidCallback onTap;

  const _ItemSlot({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // antiAlias recorta el contenido siguiendo las esquinas cortadas.
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: _bgCard,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(_slotRadius),
            side: const BorderSide(color: _accentBlue, width: 1.5),
          ),
          shadows: [
            BoxShadow(
              color: _accentCyan.withValues(alpha: 0.18),
              blurRadius: 12,
            ),
          ],
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 28),
              child: Center(child: _ItemImage(icon: item.icon)),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: 8,
              child: Text(
                item.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _textMuted,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (item.quantity > 1)
              Positioned(
                top: 14,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _bgDark.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _accentCyan),
                  ),
                  child: Text(
                    'x${item.quantity}',
                    style: const TextStyle(
                      color: _accentCyan,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Usa item.icon (columna Item.icon) como ruta de asset. Si tenés un helper
// (utils/item_image.dart) que convierte el icon en ruta, cambiá solo el
// Image.asset de acá.
class _ItemImage extends StatelessWidget {
  final String? icon;
  const _ItemImage({required this.icon});

  @override
  Widget build(BuildContext context) {
    const fallback = Icon(Icons.inventory_2_outlined, color: _border, size: 36);

    if (icon == null || icon!.isEmpty) return fallback;

    return Image.asset(
      icon!,
      fit: BoxFit.contain,
      errorBuilder: (_, __, ___) => fallback,
    );
  }
}

// ════════════════════════════════════════════════════════════
// Slot vacío con borde punteado. Flutter no trae borde punteado nativo:
// el CustomPainter toma el contorno de la forma y lo recorre a tramos.
// ════════════════════════════════════════════════════════════
class _EmptySlot extends StatelessWidget {
  const _EmptySlot();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedShapePainter(
        shape: BeveledRectangleBorder(
          borderRadius: BorderRadius.circular(_slotRadius),
        ),
        color: _border,
      ),
      child: const SizedBox.expand(),
    );
  }
}

class _DashedShapePainter extends CustomPainter {
  final ShapeBorder shape;
  final Color color;

  const _DashedShapePainter({required this.shape, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = shape.getOuterPath(Offset.zero & size);
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;

    const dash = 7.0;
    const gap = 5.0;

    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end =
            distance + dash < metric.length ? distance + dash : metric.length;
        canvas.drawPath(metric.extractPath(distance, end), paint);
        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedShapePainter old) =>
      old.shape != shape || old.color != color;
}

// ════════════════════════════════════════════════════════════
// Detalle del objeto. "USAR"/"EQUIPAR" llaman al backend;
// "Cerrar" hace Navigator.pop.
// ════════════════════════════════════════════════════════════
class _ItemSheet extends StatelessWidget {
  final _InventoryItem item;
  final String? actionLabel; // null → no hay acción para este tipo
  final VoidCallback onAction;
  final VoidCallback onClose;

  const _ItemSheet({
    required this.item,
    required this.actionLabel,
    required this.onAction,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(height: 90, child: _ItemImage(icon: item.icon)),
          const SizedBox(height: 12),
          Text(
            item.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: _textMuted,
              fontSize: 13,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Cantidad: x${item.quantity}',
            style: const TextStyle(
              color: _accentCyan,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 18),
          if (actionLabel != null) ...[
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: _accentCyan),
                  ),
                ),
                child: Text(
                  actionLabel!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 6),
          ],
          TextButton(
            onPressed: onClose,
            child: const Text('Cerrar', style: TextStyle(color: _textMuted)),
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
            const Icon(Icons.wifi_off_rounded, color: _border, size: 48),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: _textMuted, fontSize: 13),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: onRetry,
              child: const Text(
                'Reintentar',
                style: TextStyle(color: _accentCyan),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
