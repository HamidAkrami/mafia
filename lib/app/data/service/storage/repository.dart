import 'package:mafia/app/data/models/mafia_player_model.dart';
import 'package:mafia/app/data/provider/provider.dart';

class MafiaRepository {
  MafiaProvider? mafiaProvider;
  MafiaRepository({required this.mafiaProvider});
  List<MafiaPlayers> readPlayers() => mafiaProvider!.readPlayers();
  void writePlayers(List<MafiaPlayers> players) =>
      mafiaProvider!.writePlayers(players);
}
