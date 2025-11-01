# Étape 1 : image Dart officielle
FROM dart:stable AS build

# Définir le répertoire de travail
WORKDIR /app

# 1. Copier TOUT le nécessaire pour la résolution des dépendances,
# y compris les fichiers source qui peuvent être dans 'bin/' ou 'lib/'
# (dart pub get a besoin de tout pour valider l'environnement)
COPY . .

# 2. Récupérer les packages
# dart pub get DOIT être exécuté APRÈS la copie de tout le code pour 
# s'assurer que les chemins locaux (si vous en avez) sont valides.
RUN dart pub get

# Compiler le serveur Dart en exécutable
RUN dart compile exe bin/server.dart -o bin/server

# Étape 2 : image plus légère pour exécuter
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/server
# Correction : Copier uniquement l'exécutable, pas le dossier bin entier (si bin/server est le seul fichier)
# COPY --from=build /app/bin /app/bin 
# L'exécutable est déjà copié, cette ligne est redondante ou potentiellement dangereuse
# (L'instruction précédente est meilleure pour un binaire unique)

# Définir le port (Render utilisera $PORT)
ENV PORT=8080

# Exposer le port
EXPOSE 8080

# Lancer le serveur
CMD ["/app/bin/server"]
