import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Router authRoutes() {
  final router = Router();

  router.post('/login', (Request request) async {
    final body = await request.readAsString();
    // Ici tu pourras traiter le JSON plus tard
    return Response.ok('Login réussi (simulation)');
  });

  return router;
}