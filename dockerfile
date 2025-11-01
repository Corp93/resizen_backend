# Étape 1 : image Dart officielle
FROM dart:stable AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendances
COPY pubspec.* ./

# Récupérer les packages
RUN flutter pub get

# Copier tout le code
COPY . .

# Compiler le serveur Dart en exécutable
RUN dart compile exe bin/server.dart -o bin/server

# Étape 2 : image plus légère pour exécuter
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/server
COPY --from=build /app/bin /app/bin

# Définir le port (Render utilisera $PORT)
ENV PORT=8080

# Exposer le port
EXPOSE 8080

# Lancer le serveur
CMD ["/app/bin/server"]
