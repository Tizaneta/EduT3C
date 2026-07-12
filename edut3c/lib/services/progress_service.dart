import 'package:shared_preferences/shared_preferences.dart';

// ════════════════════════════════════════════════════════════
//  ProgressService
//  Guarda el progreso de niveles de forma LOCAL (SharedPreferences,
//  persiste en el dispositivo aunque se cierre la app).
//
//  Por cada "componentKey" (la misma key que usás en
//  data/HardwareData.dart, ej: "cpu", "gpu", "storage") se guarda
//  el número de nivel más alto que el usuario completó.
//
//  NOTA: esto es progreso LOCAL, no viene del backend. El backend
//  ya tiene un endpoint para esto (POST /levels/<id>/complete) —
//  cuando ApiService.mockMode pase a false, este servicio se puede
//  reemplazar o sincronizar con esa llamada real. Por ahora, con
//  el backend desacoplado, esta es la única fuente de progreso.
// ════════════════════════════════════════════════════════════
class ProgressService {
  static const String _prefix = 'hw_progress_';

  /// Nivel más alto que el usuario completó para [componentKey].
  /// Devuelve 0 si todavía no completó ninguno.
  static Future<int> getMaxCompletedLevel(String componentKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('$_prefix$componentKey') ?? 0;
  }

  /// Marca [level] como completado para [componentKey].
  /// Solo actualiza si es mayor al progreso guardado (no retrocede
  /// el progreso si el usuario repite un nivel ya hecho).
  static Future<void> completeLevel(String componentKey, int level) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getInt('$_prefix$componentKey') ?? 0;
    if (level > current) {
      await prefs.setInt('$_prefix$componentKey', level);
    }
  }

  /// Un nivel está desbloqueado si es el nivel 1, o si el nivel
  /// inmediatamente anterior ya fue completado.
  static Future<bool> isLevelUnlocked(String componentKey, int level) async {
    if (level <= 1) return true;
    final maxCompleted = await getMaxCompletedLevel(componentKey);
    return level <= maxCompleted + 1;
  }

  /// Un componente está 100% completo si el nivel más alto
  /// completado alcanza el total de niveles que tiene.
  static Future<bool> isComponentCompleted(
    String componentKey,
    int totalLevels,
  ) async {
    final maxCompleted = await getMaxCompletedLevel(componentKey);
    return maxCompleted >= totalLevels;
  }

  /// Solo para desarrollo/testing: borra todo el progreso guardado
  /// de un componente. No se usa en el flujo normal de la app.
  static Future<void> resetComponent(String componentKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefix$componentKey');
  }
}
