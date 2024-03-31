import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../models_api/series_model.dart';
import '../../series/series_ecran_details.dart';
import '../../../couleurs/couleurs.dart';

class SeriesWidget extends StatelessWidget {
  final Series series;
  final int rank; // Ajout pour gérer le rang de la série

  const SeriesWidget({
    super.key,
    required this.series,
    required this.rank,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final paddingSize = screenWidth * 0.02;
     final imageWidth = screenWidth * 0.35;
    // Calcule la hauteur de l'image pour maintenir un rapport d'aspect.
    final imageHeight = screenWidth * 0.32;
    // Hauteur de la carte ajustée pour afficher 4 éléments en utilisant la largeur de l'écran.
    final cardHeight = screenWidth * 0.38;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeriesDetailsScreen(series: series),
          ),
        );
      },
      child: Container(
        height: cardHeight,
         margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Numéro de rang
            Container(
              margin: EdgeInsets.only(top: 0),
              width: screenWidth * 0.12,
              height: screenWidth*0.15,
              alignment: Alignment.center,
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.orange, // Couleur d'arrière-plan du rang.
                
              ),
              child: Center(
                child: Text(
                  '#$rank',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            // Image de la série
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                series.coverImageUrl,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      series.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),

                    SizedBox(height: 20), 

                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/SVG/ic_publisher_bicolor.svg',
                          color: Colors.grey[400],
                          height: 14, 
                        ),
                        SizedBox(width: 4), // Espace entre l'icône et le texte.
                        Text(
                          '----',
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/SVG/ic_tv_bicolor.svg',
                          color: Colors.grey[400],
                          height: 14, 
                        ),
                        SizedBox(width: 4), // Espace entre l'icône et le texte.
                        Text(
                          '${series.episodeCount} épisodes',
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/SVG/ic_calendar_bicolor.svg',
                          color: Colors.grey[400],
                          height: 14, 
                        ),
                        SizedBox(width: 4), // Espace entre l'icône et le texte.
                        Text(
                          series.debutYear,
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