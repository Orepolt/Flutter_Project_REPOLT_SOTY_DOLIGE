import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import '../../models_api/series_model.dart';
import '../../models_api/episode_model.dart';
import '../../couleurs/couleurs.dart';
import '../../blocs/episodes_bloc.dart';

class SeriesDetailsScreen extends StatefulWidget {
  final Series series;

  const SeriesDetailsScreen({Key? key, required this.series}) : super(key: key);

  @override
  State<SeriesDetailsScreen> createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  Widget _buildSeriesImage() {
    return Row(
      children: [
        Image.network(
          widget.series.coverImageUrl,
          width: 100,
          fit: BoxFit.cover,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Row(
                      children: [
                       SizedBox(width: 10), 
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
                   SizedBox(height: 10), // Espace entre les lignes


                    Row(
                      children: [
                      SizedBox(width: 10), 

                        SvgPicture.asset(
                          'assets/SVG/ic_tv_bicolor.svg',
                          color: Colors.grey[400],
                          height: 14, 
                        ),
                        SizedBox(width: 4), // Espace entre l'icône et le texte.
                        Text(
                          '${widget.series.episodeCount} épisodes',
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ],
                    ),
                    SizedBox(height: 10), // Espace entre les lignes


                    Row(
                      children: [
                        SizedBox(width: 10), 
                        SvgPicture.asset(
                          'assets/SVG/ic_calendar_bicolor.svg',
                          color: Colors.grey[400],
                          height: 14, 
                        ),
                        SizedBox(width: 4), // Espace entre l'icône et le texte.
                        Text(
                          widget.series.debutYear,
                          style: TextStyle(color: Colors.grey[400], fontSize: 14),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.network(
            widget.series.coverImageUrl, // Image de couverture du film en arrière-plan.
            fit: BoxFit.cover, // S'assure que l'image couvre toute la zone disponible.
            height: double.infinity, // Étend l'image en hauteur autant que possible.
            width: double.infinity, // Étend l'image en largeur autant que possible.
            alignment: Alignment.center, // Centre l'image.
          ),
          Container(
            color: Colors.black.withOpacity(0.75), // Ajoute un filtre sombre sur l'image avec une opacité de 50%.
            height: double.infinity,
            width: double.infinity,
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AppBar(
              title: Text(widget.series.name,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight + MediaQuery.of(context).padding.top,
            left: 0,
            right: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _buildSeriesImage(),
                  ),
                  _buildTabBar(),
                  Container(
                    height: MediaQuery.of(context).size.height -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        HistoryTab(series: widget.series),
                        CharactersTab(series: widget.series),
                        EpisodesTab(series: widget.series),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TabBar _buildTabBar() {
    return TabBar(
      controller: _tabController,
      indicatorColor: AppColors.orange,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white60,
      tabs: [
        Tab(text: 'Histoire'),
        Tab(text: 'Personnages'),
        Tab(text: 'Épisodes'),
      ],
    );
  }
}

class HistoryTab extends StatelessWidget {
  final Series series;

  const HistoryTab({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
     decoration: BoxDecoration(
        color: AppColors.cardBackground, // Définit la couleur de fond pour le contenu du synopsis.
        borderRadius: BorderRadius.only(topLeft: Radius.circular(25), topRight: Radius.circular(25),),
      ),
      
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: HtmlWidget(
          series.description,
          textStyle: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class CharactersTab extends StatelessWidget {
  final Series series;

  const CharactersTab({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.seeMoreBackground, // Set the background color to black
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
      ),
    );
  }
}

class EpisodesTab extends StatelessWidget {
  final Series series;

  const EpisodesTab({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Demander à EpisodeBloc de charger les épisodes pour la série actuelle
    context.read<EpisodeBloc>().add(FetchEpisodesEvent(series.id));

    return Container(
      color: AppColors
          .cardBackground, // Utiliser la couleur de fond définie dans votre thème
      child: BlocBuilder<EpisodeBloc, EpisodeState>(
        builder: (context, state) {
          if (state is EpisodeLoadingState) {
            return const CircularProgressIndicator();
          } else if (state is EpisodeLoadedState) {
            // Construction de la liste des épisodes
            return ListView.builder(
              itemCount: state.episodes.length,
              itemBuilder: (context, index) {
                return _buildEpisodeCard(state.episodes[index], index);
              },
            );
          } /*else if (state is EpisodeErrorState) {
            return Center(child: Text(state.error));
          }*/
          return const SizedBox(); // Pour EpisodeInitialState ou un état inattendu
        },
      ),
    );
  }

  Widget _buildEpisodeCard(Episode episode, int index) {
    // Convertir l'index en un numéro d'épisode séquentiel (en commençant par 01, 02, etc.)
    String episodeNumber = (index + 1).toString().padLeft(2, '0');

    return Card(
      color: AppColors.elementBackground,
      child: ListTile(
        leading:
            Image.network(episode.thumbnailUrl, fit: BoxFit.cover, width: 50),
        title: Text('Episode #$episodeNumber ', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text('${episode.title} \n${episode.broadcastDate}',
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

Widget _buildCardItem({
  required String imageUrl,
  required String title,
  String? subtitle,
  required BuildContext context,
}) {
  return Card(
    color: AppColors.cardBackground,
    child: ListTile(
      leading: Image.network(imageUrl, fit: BoxFit.cover),
      title: Text(title, style: TextStyle(color: Colors.white)),
      subtitle: subtitle != null
          ? Text(subtitle, style: TextStyle(color: Colors.white70))
          : null,
    ),
  );
}