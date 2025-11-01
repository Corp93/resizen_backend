import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

Router propertyRoutes() {
  final router = Router();

  router.get('/', (Request request) {
    final properties = [
      {'id': 1, 'name': 'Résidence Belle Vue', 'ville': 'Abidjan'},
      {'id': 2, 'name': 'Hôtel du Lac', 'ville': 'Yamoussoukro'},
    ];
    return Response.ok(properties.toString());
  });

  return router;
}