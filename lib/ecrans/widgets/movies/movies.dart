import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models_api/movies_model.dart';
import '../../movies/movies_ecran_details.dart';
import '../../../couleurs/couleurs.dart';

// Ce widget affiche les détails d'un film dans une interface utilisateur stylisée.
class MoviesWidget extends StatelessWidget {
  final Movie movie; // Référence au modèle de données du film
  final int
      rankMovie; // Position du film dans une liste, par exemple, un classement

  // Constructeur du widget avec des paramètres requis pour le film et son classement.
  const MoviesWidget({
    super.key,
    required this.movie,
    required this.rankMovie,
  });

  @override
  Widget build(BuildContext context) {
    // Calcule la largeur de l'écran pour adapter la taille des éléments UI.
    final screenWidth = MediaQuery.of(context).size.width;
    // Définit la largeur de l'image en fonction de 25% de la largeur de l'écran.
    final imageWidth = screenWidth * 0.35;
    // Calcule la hauteur de l'image pour maintenir un rapport d'aspect.
    final imageHeight = screenWidth * 0.32;
    // Hauteur de la carte ajustée pour afficher 4 éléments en utilisant la largeur de l'écran.
    final cardHeight = screenWidth * 0.38;

    // Année de sortie par défaut, affichée si aucune date n'est disponible.
    String yearOfRelease = 'Année non disponible';
    if (movie.releaseDate != 'Unknown') {
      try {
        // Essaie de parser la date de sortie pour obtenir l'année.
        DateTime releaseDate = DateTime.parse(movie.releaseDate);
        yearOfRelease = releaseDate.year.toString();
      } catch (e) {
        // Capture et imprime les erreurs de parsing de la date de sortie.
        debugPrint('Erreur lors de l\'analyse de la date de sortie: $e');
      }
    }

    return GestureDetector(
      onTap: () {
        // Navigue vers l'écran de détails du film lorsque l'utilisateur tape sur la carte.
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MoviesDetailsScreen(movies: movie),
          ),
        );
      },
      child: Container(
        height: cardHeight,
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.cardBackground, // Couleur de fond de la carte.
          borderRadius:
              BorderRadius.circular(20), // Arrondit les coins de la carte.
          boxShadow: [
            // Ajoute une ombre pour un effet 3D.
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            // Affiche le rang du film à gauche de la carte.
            Container(
              margin: EdgeInsets.only(top: 0),
              width: screenWidth * 0.12,
              height: screenWidth*0.15,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.orange, // Couleur d'arrière-plan du rang.
                
              ),
              child: Text(
                '#$rankMovie',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            // Affiche l'image de couverture du film.
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                movie.coverImageUrl,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            // Conteneur pour le titre et les détails supplémentaires du film.
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Affiche le titre du film.
                    Text(
                      movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 40), 


                   // Row pour la durée du film en minutes avec icône SVG.
                     Row(
                      children: [
                        SvgPicture.asset(
                          'assets/SVG/ic_movie_bicolor.svg',
                          color: Colors.grey[400],
                          height: 14, 
                        ),
                        SizedBox(width: 4), // Espace entre l'icône et le texte.
                        Text(
                          '${movie.runningTime} minutes',
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ],
                    ),

                    // Row pour l'année de sortie du film avec icône SVG.
                     Row(
                      children: [
                        SvgPicture.asset(
                          'assets/SVG/ic_calendar_bicolor.svg', 
                          color: Colors.grey[400],
                          height: 14, 
                        ),
                        SizedBox(width: 4), // Espace entre l'icône et le texte.
                        Text(
                          yearOfRelease,
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ],
                    ),




                   
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