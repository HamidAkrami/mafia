import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mafia/app/core/value/colors.dart';
import 'package:mafia/app/data/models/character_model.dart';
import 'package:mafia/app/data/models/game_model.dart';
import 'package:mafia/app/data/models/mafia_player_model.dart';
import 'package:mafia/app/data/service/storage/repository.dart';

class HomeController extends GetxController {
  TextEditingController? playerNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  MafiaRepository? mafiaRepository;
  HomeController({required this.mafiaRepository});
  RxInt shahrvandIndex = 0.obs;
  RxInt mafiaIndex = 0.obs;
  RxInt allShahrIndex = 0.obs;
  RxInt allMafiaIndex = 0.obs;
  RxDouble mafiaNum = 0.0.obs;
  RxDouble shahrNum = 0.0.obs;
  RxBool isMute = false.obs;
  RxBool selectedAll = false.obs;
  RxBool unSelectedAllRole = false.obs;
  RxBool showRole = false.obs;

  RxInt manual = 0.obs;
  RxInt playerLength = 0.obs;
  RxInt characterLength = 0.obs;
  int? selectedIndex;
  int roleDistribution = (1),
      neutralGroup = (1),
      musicAtNight = (1),
      roleInNight = (1);

  final playerList = <MafiaPlayers>[].obs;
  final playingList = <MafiaPlayers>[].obs;
  final mafiaTeam1 = <CharacterModel>[].obs;
  final mafiaTeam2 = <CharacterModel>[].obs;
  final cityTeam1 = <CharacterModel>[].obs;
  final cityTeam2 = <CharacterModel>[].obs;
  final chosenCharacters = <CharacterModel>[].obs;
  final finalPlayerList = <MafiaPlayers>[].obs;
  final finalCharactersList = <CharacterModel>[].obs;
  final gamePlayerList = <GameModel>[].obs;
  @override
  void onInit() {
    super.onInit();

    playerList.assignAll(mafiaRepository!.readPlayers());
    ever(playerList, (_) => mafiaRepository!.writePlayers(playerList));
    // playerList.clear();

    showRole.value = false;

    addToPlayingList();
    checkChosenCharacter() {}
    mafiaTeam();
    cityTeam();

    shahrNum.value = playingList.length * 0.66;
    mafiaNum.value = shahrNum / 2;
  }

  addToPlayingList() {
    playingList.clear();
    for (var i = 0; i < playerList.length; i++) {
      if (playerList[i].isPlay!) {
        playingList.add(playerList[i]);
      }
    }
    update();
    playingList.refresh();
  }

  addTofinalList() {
    gamePlayerList.clear();
    finalCharactersList.clear();
    finalPlayerList.clear();
    playerList.shuffle();
    finalPlayerList.addAll(playerList);
    finalCharactersList.addAll(chosenCharacters);
    update();
  }

  divisionOfRole(
    MafiaPlayers player,
  ) {
    final random = Random();
    var role = finalCharactersList[random.nextInt(finalCharactersList.length)];

    gamePlayerList.add(GameModel(player.name, role.name, role.isMafia, false,
        role.heal, role.description, role.image, role.ability, false));

    finalPlayerList.remove(player);

    finalPlayerList.refresh();
    finalCharactersList.remove(role);
    finalCharactersList.refresh();

    // print("${gamePlayerList[0].name} : ${gamePlayerList[0].role}");
    update();
  }

  List<CharacterModel> getRole(int role) {
    return characterList.where((p0) => p0.isMafia == role).toList();
  }

  mafiaTeam() {
    for (var i = 0; i < characterList.length; i++) {
      if (characterList[i].isMafia == 1) {
        int index = i + 1;
        if (index % 2 == 0) {
          mafiaTeam1.add(characterList[i]);
        } else {
          mafiaTeam2.add(characterList[i]);
        }
      }
    }
    update();
  }

  cityTeam() {
    for (var i = 0; i < characterList.length; i++) {
      if (characterList[i].isMafia == 0) {
        int index = i + 1;
        if (index % 2 == 0) {
          cityTeam1.add(characterList[i]);
        } else {
          cityTeam2.add(characterList[i]);
        }
      }
    }
    update();
  }

  addNewPlayer(String name, bool isPlay) {
    final newPlayer = MafiaPlayers(name: name, isPlay: isPlay);
    if (name.isEmpty) {
      return;
    }
    playerList.add(newPlayer);
    playingList.add(newPlayer);
    playerNameController!.clear();

    update();
  }

  addToGame() {
    playingList.clear();
    playingList.addAll(playerList.where((p0) => p0.isPlay == true).toList());
  }

  addPlayer(MafiaPlayers player) {
    if (player.isPlay!) {
      playingList.add(player);
    } else {
      playingList.remove(player);
    }

    update();
    playerList.refresh();
  }

  addCharacter(CharacterModel character) {
    if (character.isPicked!) {
      chosenCharacters.add(character);
      characterLength.value = chosenCharacters.length;
      if (character.isMafia == 0) {
        allShahrIndex.value++;
      } else if (character.isMafia == 1) {
        allMafiaIndex.value++;
      }
    } else {
      chosenCharacters.remove(character);
      characterLength.value = chosenCharacters.length;
      if (character.isMafia == 0) {
        allShahrIndex.value--;
      } else if (character.isMafia == 1) {
        allMafiaIndex.value--;
      }
    }

    update();
  }

  setShahrvand(CharacterModel mafia) {
    if (mafia.name == "شهروند") {
      addShahrvand(mafia);
      shahrvandIndex.value++;
    } else if (mafia.name == "مافیا") {
      addmafia(mafia);
      mafiaIndex.value++;
    }
    chosenCharacters.refresh();
    update();
  }

  addShahrvand(CharacterModel character) {
    chosenCharacters.add(character);
    if (character.isMafia == 0) {
      allShahrIndex.value++;
    }

    update();
  }

  addmafia(CharacterModel character) {
    chosenCharacters.add(character);
    if (character.isMafia == 1) {
      allMafiaIndex.value++;
    }
    update();
  }

  bool checkMafiaIndex() {
    int myMafia = 0;
    int myshahr = 0;
    for (var i = 0; i < chosenCharacters.length; i++) {
      if (chosenCharacters[i].isMafia == 1) {
        myMafia++;
      } else if (chosenCharacters[i].isMafia == 0) {
        myshahr++;
      }
    }
    if (chosenCharacters.length == playingList.length) {
      if (myMafia >= myshahr) {
        return false;
      } else if (myMafia < myshahr) {
        return true;
      }
    } else {
      return false;
    }

    return checkMafiaIndex();
  }

  addChosenCharacterToGame() {
    chosenCharacters.clear();
    chosenCharacters
        .addAll(characterList.where((p0) => p0.isPicked == true).toList());
  }

  removeCharacter(CharacterModel mafia) {
    chosenCharacters.remove(mafia);
    chosenCharacters.refresh();
    update();
  }

  onListItemTap(index) {
    playerList[index].isPlay = !playerList[index].isPlay!;

    update();
    playerList.refresh();
  }

  onSelectCharacter(CharacterModel characterModel) {
    characterModel.isPicked = !characterModel.isPicked!;

    update();
  }

  selectAllPlayer() {
    selectedAll.value = !selectedAll.value;
    playingList.clear();
    for (var i = 0; i < playerList.length; i++) {
      playerList[i].isPlay = selectedAll.value;
      if (selectedAll.value) {
        playingList.add(playerList[i]);
      } else {
        playingList.remove(playerList[i]);
      }
      // if (playerList[i].isPlay!) {
      //   playingList.add(playerList[i]);
      // }
    }

    playerList.refresh();
    update();
  }

  unSelectAllPlayer() {
    for (var i = 0; i < characterList.length; i++) {
      characterList[i].isPicked = false;
    }
    update();
    playerList.refresh();
    playingList.refresh();
  }

  getSelectedPlayerLength() {
    playerLength.value = playingList.length;
    update();
  }

  getSelectedCharacterrLength() {
    characterLength.value = 0;
    for (var i = 0; i < chosenCharacters.length; i++) {
      if (chosenCharacters[i].isPicked == true) {}
    }
    update();
  }

  removePlayerList() {
    playerList.clear();
    playingList.clear();
    selectedAll.value = false;

    update();
  }

  removePlayer(MafiaPlayers player) {
    playerList.remove(player);
    playingList.remove(player);
    update();
  }

  muteMusic() {
    isMute.value = !isMute.value;
  }

  changeManual(int index) {
    manual.value = index;
  }

  selectDistributionOfRole(int value) {
    roleDistribution = value;
  }

  selectNeutralGroup(int value) {
    neutralGroup = value;
  }

  selectMusicAtNight(int value) {
    musicAtNight = value;
  }

  selectRoleInNight(int value) {
    roleInNight = value;
  }

  final characterList = <CharacterModel>[
    CharacterModel(
        name: "شهروند",
        isMafia: 0,
        isPicked: false,
        ability: false,
        heal: 1,
        description:
            "شهروند ساده یا همان شهروند وظیفه خاصی ندارد. صبح‌ها می‌تواند در تصمیم‌گیری‌ها شرکت کند صحبت کند و رای بدهد",
        image: "assets/avatar/citizen.png"),
    CharacterModel(
        name: "روئین تن",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 2,
        image: "assets/avatar/roeintan.png",
        description:
            "قابلیت استعلام نقش بازیکنان کشته شده را دارد و همچنین شهروند زره پوشیست که با تیر مافیا در شب یا رای در روز زره خود را از دست داده و به شهروند ساده تبدیل میشود"),
    CharacterModel(
        name: "کاراگاه",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/karagah.png",
        description:
            "توانایی استعلام مافیا به غیر از پدر خوانده را از طریق گرداننده بازی دارد "),
    CharacterModel(
        name: "اسنایپر",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/sniper.png",
        description:
            " شهروندیست که می تواند در صورت شناسایی مافیا شب به او شلیک کند. در صورت شلیک اشتباه به شهروند خودکشی میکند و از بازی حذف میشود"),
    CharacterModel(
        name: "دکتر",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/doctor.png",
        description:
            "در صورتی که شهروند تیر خورده توسط مافیا را شناسایی کند میتواند او را نجات دهد. از این قابلیت فقط یکبار میتواند برای نجات خود استفاده کند"),
    CharacterModel(
        name: "قاضی",
        isMafia: 0,
        isPicked: false,
        ability: false,
        heal: 1,
        image: "assets/avatar/ghazi.png",
        description:
            "در صورتی که رای گیری نهایی برای بیش از یک نفر در خواب انجام شود قاضی فقط برای یک بار در طول بازی میتواند رای گیری را ملغی کند و یا به یک نفر رای مستقیم خروج دهد"),
    CharacterModel(
        name: "فدایی",
        isMafia: 0,
        isPicked: false,
        ability: false,
        heal: 1,
        image: "assets/avatar/fadaei.png",
        description:
            "شهروندیست که اگر در پایان روز رای به اعدام بگیرد هنگام اعدام میتواند یک نفر را با خود از بازی خارج کند"),
    CharacterModel(
        name: "خوابگرد",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/shahrside.png",
        description:
            "اگر از قدرت خود استفاده کند آن شب مافیا جرات حمله به شهر را ندارد.و فقط شهروندان از قدرت خود می توانند استفاده کنند خوابگرد در صورت استفاده از قابلیت خود در طول شب کشته میشود و روز بعد از بازی خارج میشود"),
    CharacterModel(
        name: "خبرنگار",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/shahrside.png",
        description:
            "پس از انجام مذاکره توسط مذاکره کننده می تواند استعلام فردی که با او مذاکره شده را از گرداننده بگیرد؛ درصورتی که مذاکره انجام نشده باشد، خبرنگار قدرت این را دارد که بفهمد هرشخص در شب چه کاری انجام داده"),
    CharacterModel(
        name: "تفنگ دار",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/tofangdar.png",
        description:
            " دو اسلحه و یک گلوله دارد؛ می تواند هر شب به دو نفر اسلحه بدهد؛ در روز بعد تا قبل از رای گیری افرادی که اسلحه تحویل گرفته اند فرصت دارند تا از اسلحه استفاده کنند، اگر گلوله دراسلحه باشد کسی که هدف قراره گرفته با افشای گروه توسط گرداننده از بازی خارج میشود"),
    CharacterModel(
        name: "فروشنده",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/foroshandeh.png",
        description:
            "یک بار در طول کل بازی می تواند قدرت یکی از بازیکنان را بفروشد و او را تبدیل به شهروند یا مافیای ساده کند"),
    CharacterModel(
        name: "روان پزشک",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/shahrside.png",
        description:
            "اگر حس کند یکی از بازیکنان در حال آسیب زدن به روند شهر است میتواند او را در طول روز ساکت کند؛ اگر شخص انتخاب شده به دفاعیه برود نمیتواند از خود دفاع کند و دوبار در طول بازی میتواند از قدرت خود استفاده کند"),
    CharacterModel(
        name: "فرشته نجات",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/shahrside.png",
        description:
            "اگر در طول روز بازیکنی با رای گیری اعدام شود در شب با بقیه بازیکنان به خواب میرود؛ در صورتی که فرشته تشخیص دهد که این بازیکن جز تیم شهر بوده میتواند او را به بازی برگرداند و فقط یکبار در طول بازی می تواند از قدرت خود استفاده کند"),
    CharacterModel(
        name: "پلیس",
        isMafia: 0,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/police.png",
        description:
            "در طول بازی دو بار میتواند در شب هوشیاری خود را فعال کند در صورتی که مافیا او را در هنگام هوشیاری هدف قرار دهد دستگیر و اعدام میشود "),
    CharacterModel(
        name: "زامبی",
        isMafia: 0,
        isPicked: false,
        ability: false,
        heal: 1,
        image: "assets/avatar/shahrside.png",
        description:
            "شهروند بیمارست که دکتر سه شب فرصت دارد او را نجات دهد در غیر اینصورت فردای شب سوم میمیرد"),
    CharacterModel(
        name: "مافیا",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/mafiaSade.png",
        description:
            "مافیا ساده است و به همراه گروه مافیا در شب بیدار میشود و قدرتی ندارد  در طول روز برای گمراه کردن شهر فعالیت میکند"),
    CharacterModel(
        name: "پدر خوانده",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/godfather.png",
        description:
            "رئیس گروه مافیاست و او تصمیم نهایی برای کشتن در شب را به گرداننده اعلام می کند؛ همچنین استعلام او توسط کاراگاه انجام نمیشود"),
    CharacterModel(
        name: "دکتر لکتر",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/doctorlecter.png",
        description:
            "دکتر گروه مافیاست و میتواند هم تیمی های خود را از شلیک اسنایپر محافظت کند؛ فقط یکبار میتواند خود را نجات دهد"),
    CharacterModel(
        name: "سایلنسر",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/silencer.png",
        description:
            "برای گمراه کردن شهر میتواند یکی از بازیکنان از جمله هم تیمی های خود را در طول روز ساکت کند؛ فرد سایلنس شده در دفاعیه نیز نمیتواند از خود دفاع کند"),
    CharacterModel(
        name: "مذاکره کننده",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/mozakere.png",
        description:
            "اگر مافیا یکی از هم تیمی های خود را از دست بدهد مذاکره کننده در صورت شناسایی میتواند با شهروند ساده یا کاراگاه یا هر نقش تعیین شده توسط گرداننده وارد مذاکره شود و او را عضو تیم مافیا کند؛در شبی که مذاکره انجام می شود تیم مافیا به شهروندان شلیک نمی کنند"),
    CharacterModel(
        name: "دزد",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/dozd.png",
        description:
            " در طول شب دو نفر را انتخاب میکند و قدرت نفر اولی که انتخاب کرده بر نفر دوم اعمال میشود؛مثلا اگر نفر اول اسنایپر باشد نفر دوم کشته میشود؛ از این قابلیت دو بار در طول بازی میتواند استفاده کند"),
    CharacterModel(
        name: "جوکر",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/joker.png",
        description:
            "کاراگاه را گمراه میکند ؛ در طول شب هرکسی را انتخاب کند،استعلام فرد انتخاب شده توسط کاراگاه برعکس نشان داده می شود"),
    CharacterModel(
        name: "معشوقه",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/mafiaside.png",
        description:
            "سوگولی پدرخوانده اگر در طول روز با رای گیری اعدام شود پدرخوانده از شدت عصبانیت در شب 2 بار شلیک می کند"),
    CharacterModel(
        name: "دلقک",
        isMafia: 1,
        isPicked: false,
        ability: true,
        heal: 1,
        image: "assets/avatar/mafiaside.png",
        description:
            "در طول بازی یکبار در شب از قدرت خود استفاده میکند و در آن شب شهروندان نمیتوانند فعالیتی کنند"),
    CharacterModel(name: "قاتل", isMafia: 2, isPicked: false, ability: true),
    CharacterModel(name: "قاتل", isMafia: 2, isPicked: false, ability: true),
    CharacterModel(name: "قاتل", isMafia: 2, isPicked: false, ability: true),
    CharacterModel(name: "قاتل", isMafia: 2, isPicked: false, ability: true),
  ].obs;
}
