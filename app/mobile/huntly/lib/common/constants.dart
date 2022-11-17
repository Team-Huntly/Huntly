import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:iconify_flutter/iconify_flutter.dart';

//Iconify
import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:colorful_iconify_flutter/icons/noto.dart';
import 'package:colorful_iconify_flutter/icons/logos.dart';
import 'package:colorful_iconify_flutter/icons/emojione_v1.dart';
import 'package:colorful_iconify_flutter/icons/icon_park.dart';
import 'package:iconify_flutter/icons/fa6_brands.dart';
import 'package:colorful_iconify_flutter/icons/fxemoji.dart';
import 'package:colorful_iconify_flutter/icons/noto_v1.dart';
import 'package:iconify_flutter/icons/bi.dart';
import 'package:colorful_iconify_flutter/icons/twemoji.dart';
import 'package:iconify_flutter/icons/fa6_solid.dart';
import 'package:iconify_flutter/icons/iconoir.dart';
import 'package:iconify_flutter/icons/mdi.dart';
import 'package:colorful_iconify_flutter/icons/vscode_icons.dart';
import 'package:colorful_iconify_flutter/icons/emojione.dart';

const String OAUTH_CLIENT_ID =
    '363088523272-orkcfiqub7hshaq29pisji796or7ohpq.apps.googleusercontent.com';

class Interests extends Equatable {
  final String category;
  final String interest;
  final String icon;

  Interests(
      {required this.category, required this.interest, required this.icon});

  @override
  List<Object> get props => [category, interest, icon];
}

const String category1 = 'Creativity';
const String category2 = 'Sports';
const String category3 = 'Pets';
const String category4 = 'Values & traits';
const String category5 = 'Food & Drink';
const String category6 = 'Music';
const String category7 = 'Films & TV';
const String category8 = 'Reading';
const String category9 = 'Staying in';
const String category10 = 'Outing';

Map<String, List<Interests>> creativity = {
  category1: [
    Interests(
        category: category1,
        interest: "Writing",
        icon: Twemoji.writing_hand_light_skin_tone),
    Interests(category: category1, interest: "Art", icon: Noto.paintbrush),
    Interests(category: category1, interest: "Crafts", icon: Logos.origami),
    Interests(
        category: category1,
        interest: "Dancing",
        icon: Noto.woman_dancing_medium_light_skin_tone),
    Interests(category: category1, interest: "Design", icon: IconPark.bydesign),
    Interests(category: category1, interest: "Make up", icon: Noto.lipstick),
    Interests(
        category: category1,
        interest: "Photography",
        icon: Noto.camera_with_flash),
    Interests(category: category1, interest: "Singing", icon: Noto.microphone),
  ]
};

Map<String, List<Interests>> sports = {
  category2: [
    Interests(
        category: category2,
        interest: "Swimming",
        icon: Twemoji.man_swimming_medium_light_skin_tone),
    Interests(
        category: category2,
        interest: "Athletics",
        icon: Twemoji.man_running_light_skin_tone),
    Interests(
        category: category2, interest: "Badminton", icon: Twemoji.badminton),
    Interests(
        category: category2, interest: "Soccer", icon: EmojioneV1.soccer_ball),
    Interests(category: category2, interest: "Tennis", icon: Noto.tennis),
    Interests(
        category: category2, interest: "Volleyball", icon: Twemoji.volleyball),
  ]
};

Map<String, List<Interests>> pets = {
  category3: [
    Interests(
        category: category3, interest: "Birds", icon: Fa6Brands.earlybirds),
    Interests(category: category3, interest: "Cats", icon: Fxemoji.catside),
    Interests(category: category3, interest: "Dogs", icon: Fxemoji.dogside),
    Interests(category: category3, interest: "Fish", icon: Noto.tropical_fish),
  ]
};

Map<String, List<Interests>> values = {
  category4: [
    Interests(
        category: category4, interest: "Ambition", icon: Noto.thought_balloon),
    Interests(
        category: category4,
        interest: "Being Active",
        icon: Twemoji.person_running_medium_skin_tone),
    Interests(
        category: category4,
        interest: "Family Oriented",
        icon: Twemoji.family_man_man_girl_girl),
    Interests(category: category4, interest: "Romantic", icon: Noto.heart_suit),
    Interests(
        category: category4,
        interest: "Empathetic",
        icon: Noto.heart_hands_medium_light_skin_tone),
    Interests(
        category: category4,
        interest: "Travelling",
        icon: Twemoji.baggage_claim),
    Interests(
        category: category4,
        interest: "Beaches",
        icon: Twemoji.beach_with_umbrella),
    Interests(category: category4, interest: "Camping", icon: Twemoji.camping),
    Interests(
        category: category4,
        interest: "Backpacking",
        icon: Emojione.shopping_bags),
    Interests(
        category: category4, interest: "Road trips", icon: Noto.pickup_truck),
    Interests(
        category: category4, interest: "Trekking", icon: Twemoji.baggage_claim),
  ]
};

Map<String, List<Interests>> food = {
  category5: [
    Interests(category: category5, interest: "Beer", icon: NotoV1.beer_mug),
    Interests(
        category: category5, interest: "Biryani", icon: Fxemoji.cookedrice),
    Interests(
        category: category5,
        interest: "Coffee",
        icon: VscodeIcons.file_type_coffeelint),
    Interests(category: category5, interest: "Maggi", icon: Mdi.noodles),
    Interests(category: category5, interest: "Pizza", icon: EmojioneV1.pizza),
    Interests(category: category5, interest: "Wine", icon: Twemoji.wine_glass),
    Interests(category: category5, interest: "Foodie", icon: Noto.pot_of_food),
  ]
};

Map<String, List<Interests>> music = {
  category6: [
    Interests(
        category: category6, interest: "Country", icon: Emojione.world_map),
    Interests(
        category: category6, interest: "EDM", icon: Noto.musical_keyboard),
    Interests(
        category: category6,
        interest: "Electronic",
        icon: NotoV1.musical_score),
    Interests(
        category: category6, interest: "Classic", icon: Noto.musical_keyboard),
    Interests(category: category6, interest: "Jazz", icon: Twemoji.saxophone),
    Interests(
        category: category6, interest: "Desi", icon: NotoV1.musical_score),
    Interests(
        category: category6, interest: "Textbox", icon: Noto.musical_keyboard),
  ]
};

Map<String, List<Interests>> films = {
  category7: [
    Interests(
        category: category7,
        interest: "Thriller & Crime",
        icon: Fxemoji.daggerknife),
    Interests(category: category7, interest: "Action", icon: Fa6Solid.gun),
    Interests(
        category: category7, interest: "Animated", icon: Twemoji.teddy_bear),
    Interests(
        category: category7,
        interest: "Comedy",
        icon: Twemoji.rolling_on_the_floor_laughing),
    Interests(category: category7, interest: "Horror", icon: Noto.ghost),
    Interests(
        category: category7, interest: "Bollywood", icon: Twemoji.movie_camera),
  ]
};

Map<String, List<Interests>> reading = {
  category8: [
    Interests(
        category: category8, interest: "Biographies", icon: Noto.blue_book),
    Interests(
        category: category8, interest: "Business", icon: Twemoji.orange_book),
    Interests(
        category: category8, interest: "Cookbooks", icon: Fxemoji.closedbook),
    Interests(category: category8, interest: "Fiction", icon: Noto.blue_book),
    Interests(category: category8, interest: "History", icon: Fxemoji.openbook),
    Interests(category: category8, interest: "Mystery", icon: Noto.notebook),
    Interests(
        category: category8, interest: "Non-fiction", icon: Noto.blue_book),
    Interests(category: category8, interest: "Romance", icon: Noto.heart_suit),
    Interests(category: category8, interest: "Self-help", icon: Noto.notebook),
    Interests(category: category8, interest: "Textbooks", icon: Fxemoji.books),
  ]
};

Map<String, List<Interests>> travel = {
  category9: [
    Interests(
        category: category9, interest: "Backpacking", icon: Noto.backpack),
    Interests(
        category: category9,
        interest: "Beaches",
        icon: EmojioneV1.beach_with_umbrella),
    Interests(category: category9, interest: "Camping", icon: Noto.camping),
    Interests(
        category: category9, interest: "Road trips", icon: Mdi.car_sports),
    Interests(
        category: category9, interest: "Trekking", icon: Iconoir.trekking),
  ]
};

Map<String, List<Interests>> hobbies = {
  category10: [
    Interests(
        category: category10,
        interest: "Art",
        icon: Fxemoji.lowerleftpaintbrush),
    Interests(category: category10, interest: "Cooking", icon: Noto.cooking),
    Interests(
        category: category10,
        interest: "Dancing",
        icon: NotoV1.woman_dancing_medium_light_skin_tone),
    Interests(category: category10, interest: "Gaming", icon: Twemoji.laptop),
    Interests(
        category: category10,
        interest: "Gardening",
        icon: Twemoji.house_with_garden),
    Interests(
        category: category10, interest: "Photography", icon: Bi.camera_fill),
    Interests(
        category: category10, interest: "Singing", icon: NotoV1.microphone),
    Interests(category: category10, interest: "Writing", icon: Noto.pencil),
  ]
};
List<Interests> allInterests = [
  Interests(
      category: category1,
      interest: "Writing",
      icon: Twemoji.writing_hand_light_skin_tone),
  Interests(category: category1, interest: "Art", icon: Noto.paintbrush),
  Interests(category: category1, interest: "Crafts", icon: Logos.origami),
  Interests(
      category: category1,
      interest: "Dancing",
      icon: Noto.woman_dancing_medium_light_skin_tone),
  Interests(category: category1, interest: "Design", icon: IconPark.bydesign),
  Interests(category: category1, interest: "Make up", icon: Noto.lipstick),
  Interests(
      category: category1,
      interest: "Photography",
      icon: Noto.camera_with_flash),
  Interests(category: category1, interest: "Singing", icon: Noto.microphone),
  Interests(
      category: category2,
      interest: "Swimming",
      icon: Twemoji.man_swimming_medium_light_skin_tone),
  Interests(
      category: category2,
      interest: "Athletics",
      icon: Twemoji.man_running_light_skin_tone),
  Interests(
      category: category2, interest: "Badminton", icon: Twemoji.badminton),
  Interests(
      category: category2, interest: "Soccer", icon: EmojioneV1.soccer_ball),
  Interests(category: category2, interest: "Tennis", icon: Noto.tennis),
  Interests(
      category: category2, interest: "Volleyball", icon: Twemoji.volleyball),
  Interests(category: category3, interest: "Birds", icon: Fa6Brands.earlybirds),
  Interests(category: category3, interest: "Cats", icon: Fxemoji.catside),
  Interests(category: category3, interest: "Dogs", icon: Fxemoji.dogside),
  Interests(category: category3, interest: "Fish", icon: Noto.tropical_fish),
  Interests(
      category: category4, interest: "Ambition", icon: Noto.thought_balloon),
  Interests(
      category: category4,
      interest: "Being Active",
      icon: Twemoji.person_running_medium_skin_tone),
  Interests(
      category: category4,
      interest: "Family Oriented",
      icon: Twemoji.family_man_man_girl_girl),
  Interests(category: category4, interest: "Romantic", icon: Noto.heart_suit),
  Interests(
      category: category4,
      interest: "Empathetic",
      icon: Noto.heart_hands_medium_light_skin_tone),
  Interests(
      category: category4, interest: "Travelling", icon: Twemoji.baggage_claim),
  Interests(
      category: category4,
      interest: "Beaches",
      icon: Twemoji.beach_with_umbrella),
  Interests(category: category4, interest: "Camping", icon: Twemoji.camping),
  Interests(
      category: category4,
      interest: "Backpacking",
      icon: Emojione.shopping_bags),
  Interests(
      category: category4, interest: "Road trips", icon: Noto.pickup_truck),
  Interests(
      category: category4, interest: "Trekking", icon: Twemoji.baggage_claim),
  Interests(category: category5, interest: "Beer", icon: NotoV1.beer_mug),
  Interests(category: category5, interest: "Biryani", icon: Fxemoji.cookedrice),
  Interests(
      category: category5,
      interest: "Coffee",
      icon: VscodeIcons.file_type_coffeelint),
  Interests(category: category5, interest: "Maggi", icon: Mdi.noodles),
  Interests(category: category5, interest: "Pizza", icon: EmojioneV1.pizza),
  Interests(category: category5, interest: "Wine", icon: Twemoji.wine_glass),
  Interests(category: category5, interest: "Foodie", icon: Noto.pot_of_food),
  Interests(category: category6, interest: "Country", icon: Emojione.world_map),
  Interests(category: category6, interest: "EDM", icon: Noto.musical_keyboard),
  Interests(
      category: category6, interest: "Electronic", icon: NotoV1.musical_score),
  Interests(
      category: category6, interest: "Classic", icon: Noto.musical_keyboard),
  Interests(category: category6, interest: "Jazz", icon: Twemoji.saxophone),
  Interests(category: category6, interest: "Desi", icon: NotoV1.musical_score),
  Interests(
      category: category6, interest: "Textbox", icon: Noto.musical_keyboard),
  Interests(
      category: category7,
      interest: "Thriller & Crime",
      icon: Fxemoji.daggerknife),
  Interests(category: category7, interest: "Action", icon: Fa6Solid.gun),
  Interests(
      category: category7, interest: "Animated", icon: Twemoji.teddy_bear),
  Interests(
      category: category7,
      interest: "Comedy",
      icon: Twemoji.rolling_on_the_floor_laughing),
  Interests(category: category7, interest: "Horror", icon: Noto.ghost),
  Interests(
      category: category7, interest: "Bollywood", icon: Twemoji.movie_camera),
  Interests(category: category8, interest: "Biographies", icon: Noto.blue_book),
  Interests(
      category: category8, interest: "Business", icon: Twemoji.orange_book),
  Interests(
      category: category8, interest: "Cookbooks", icon: Fxemoji.closedbook),
  Interests(category: category8, interest: "Fiction", icon: Noto.blue_book),
  Interests(category: category8, interest: "History", icon: Fxemoji.openbook),
  Interests(category: category8, interest: "Mystery", icon: Noto.notebook),
  Interests(category: category8, interest: "Non-fiction", icon: Noto.blue_book),
  Interests(category: category8, interest: "Romance", icon: Noto.heart_suit),
  Interests(category: category8, interest: "Self-help", icon: Noto.notebook),
  Interests(category: category8, interest: "Textbooks", icon: Fxemoji.books),
  Interests(category: category9, interest: "Backpacking", icon: Noto.backpack),
  Interests(
      category: category9,
      interest: "Beaches",
      icon: EmojioneV1.beach_with_umbrella),
  Interests(category: category9, interest: "Camping", icon: Noto.camping),
  Interests(category: category9, interest: "Road trips", icon: Mdi.car_sports),
  Interests(category: category9, interest: "Trekking", icon: Iconoir.trekking),
  Interests(
      category: category10, interest: "Art", icon: Fxemoji.lowerleftpaintbrush),
  Interests(category: category10, interest: "Cooking", icon: Noto.cooking),
  Interests(
      category: category10,
      interest: "Dancing",
      icon: NotoV1.woman_dancing_medium_light_skin_tone),
  Interests(category: category10, interest: "Gaming", icon: Twemoji.laptop),
  Interests(
      category: category10,
      interest: "Gardening",
      icon: Twemoji.house_with_garden),
  Interests(
      category: category10, interest: "Photography", icon: Bi.camera_fill),
  Interests(category: category10, interest: "Singing", icon: NotoV1.microphone),
  Interests(category: category10, interest: "Writing", icon: Noto.pencil),
];
List<Map<String, List<Interests>>> interests = [
  creativity,
  sports,
  pets,
  values,
  food,
  music,
  films,
  reading,
  travel,
  hobbies
];
Interests? getInterest(String s) {
  for (Interests interest in allInterests) {
    if (interest.interest == s) {
      return interest;
    }
  }
  return null;
}

String url = "https://huntly-backend.mixedbag.repl.co/";

Interests? sendInterest(String s) {
  for (Interests interest in allInterests) {
    if (interest.interest == s) {
      return interest;
    }
  }
  return null;
}
