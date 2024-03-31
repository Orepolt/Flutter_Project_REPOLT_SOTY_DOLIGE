import 'package:flutter/material.dart';
import '../../../../models_api/movies_model.dart';
import '../../../../couleurs/couleurs.dart';

class InfosTab extends StatelessWidget {
  final Movie movie;

  const InfosTab({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
        color: AppColors.cardBackground, // Définit la couleur de fond pour le contenu du synopsis.
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25),),
      ),
      padding: EdgeInsets.all(15), // Ajoutez du padding autour de la table
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(),
          1: FlexColumnWidth(), 
        },
        children: [
          _buildTableRow('Classification', movie.rating),
          _buildTableRow('Réalisateur', 'Zack Snyder'),
          _buildTableRow('Scénaristes', _formatListToString(movie.screenplayAuthors)),
          _buildTableRow('Producteurs', _formatListToString(movie.productionCompanies)),
          _buildTableRow('Studios', _formatListToString(movie.filmStudios)),
          _buildTableRow('Budget', _formatCurrency(movie.productionBudget)),
          _buildTableRow('Recettes au box-office', _formatCurrency(movie.grossRevenue)),
          _buildTableRow('Recettes brutes totales', _formatCurrency(movie.netRevenue)),
        ],
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(label,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 15)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(value, style: TextStyle(color: Colors.white, fontSize: 15)),
        ),
      ],
    );
  }

  String _formatListToString(List<String> list) {
    return list.join('\n'); // Joint les éléments de la liste avec un retour à la ligne.
  }

 String _formatCurrency(String amount) {
  // Retire les séparateurs de milliers, si présent.
  String cleanedAmount = amount.replaceAll(',', '');
  
  // Enlève les six derniers chiffres pour obtenir les millions.
  if (cleanedAmount.length > 6) {
    String valueInMillions = cleanedAmount.substring(0, cleanedAmount.length - 6);
    return "$valueInMillions millions \$";
  } else {
    return "0 millions \$";
  }
}

}