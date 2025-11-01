import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_cors_headers/shelf_cors_headers.dart';

// Import de tes routes personnalisées
import '../lib/routes/auth_routes.dart';
import '../lib/routes/property_routes.dart';

void main(List<String> args) async {
  // Crée un router principal
  final router = Router();

  // Route de base
  router.get('/', (Request request) {
  return Response.ok(
    '🚀 API Hôtel & Résidence opérationnelle !',
    headers: {'Content-Type': 'text/plain; charset=utf-8'},
  );
});
  // Ajoute les routes de modules
  router.mount('/auth/', authRoutes());
  router.mount('/properties/', propertyRoutes());

  // Active les en-têtes CORS
  final handler = Pipeline()
      .addMiddleware(logRequests())
      .addMiddleware(corsHeaders())
      .addHandler(router);

  // Port (Render ou local)
  final port = int.parse(Platform.environment['PORT'] ?? '8080');

  final server = await io.serve(handler, InternetAddress.anyIPv4, port);
  print('✅ Serveur en ligne sur le port ${server.port}');
}