import 'package:flutter/material.dart';

class Interests {
  final String category;
  final String interest;
  final Icon icon;

  Interests(
      {required this.category, required this.interest, required this.icon});
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
        category: category1, interest: "Writing", icon: Icon(Icons.create)),
    Interests(category: category1, interest: "Art", icon: Icon(Icons.create)),
    Interests(
        category: category1, interest: "Crafts", icon: Icon(Icons.create)),
    Interests(
        category: category1, interest: "Dancing", icon: Icon(Icons.create)),
    Interests(
        category: category1, interest: "Design", icon: Icon(Icons.create)),
    Interests(
        category: category1, interest: "Make up", icon: Icon(Icons.create)),
    Interests(
        category: category1, interest: "Photography", icon: Icon(Icons.create)),
    Interests(
        category: category1, interest: "Singing", icon: Icon(Icons.create)),
  ]
};

Map<String, List<Interests>> sports = {
  category2: [
    Interests(
        category: category2, interest: "Swimming", icon: Icon(Icons.pool)),
    Interests(
        category: category2,
        interest: "Athletics",
        icon: Icon(Icons.directions_run)),
    Interests(
        category: category2, interest: "Badminton", icon: Icon(Icons.pool)),
    Interests(
        category: category2,
        interest: "Soccer",
        icon: Icon(Icons.sports_soccer)),
    Interests(
        category: category2,
        interest: "Tennis",
        icon: Icon(Icons.sports_tennis)),
    Interests(
        category: category2,
        interest: "Volleyball",
        icon: Icon(Icons.sports_volleyball)),
  ]
};

Map<String, List<Interests>> pets = {
  category3: [
    Interests(category: category3, interest: "Birds", icon: Icon(Icons.pets)),
    Interests(category: category3, interest: "Cats", icon: Icon(Icons.pets)),
    Interests(category: category3, interest: "Dogs", icon: Icon(Icons.pets)),
    Interests(category: category3, interest: "Fish", icon: Icon(Icons.pets)),
  ]
};

Map<String, List<Interests>> values = {
  category4: [
    Interests(
        category: category4, interest: "Ambition", icon: Icon(Icons.star)),
    Interests(
        category: category4, interest: "Being Active", icon: Icon(Icons.star)),
    Interests(
        category: category4,
        interest: "Family Oriented",
        icon: Icon(Icons.star)),
    Interests(
        category: category4, interest: "Romantic", icon: Icon(Icons.star)),
    Interests(
        category: category4, interest: "Empathetic", icon: Icon(Icons.star)),
    Interests(
        category: category4, interest: "Travelling", icon: Icon(Icons.star)),
    Interests(category: category4, interest: "Beaches", icon: Icon(Icons.star)),
    Interests(category: category4, interest: "Camping", icon: Icon(Icons.star)),
    Interests(
        category: category4, interest: "Backpacking", icon: Icon(Icons.star)),
    Interests(
        category: category4, interest: "Road trips", icon: Icon(Icons.star)),
    Interests(
        category: category4, interest: "Trekking", icon: Icon(Icons.star)),
  ]
};

Map<String, List<Interests>> food = {
  category5: [
    Interests(
        category: category5, interest: "Beer", icon: Icon(Icons.local_drink)),
    Interests(
        category: category5,
        interest: "Biryani",
        icon: Icon(Icons.local_dining)),
    Interests(
        category: category5, interest: "Coffee", icon: Icon(Icons.local_cafe)),
    Interests(
        category: category5, interest: "Maggi", icon: Icon(Icons.local_dining)),
    Interests(
        category: category5, interest: "Pizza", icon: Icon(Icons.local_pizza)),
    Interests(
        category: category5, interest: "Wine", icon: Icon(Icons.local_drink)),
    Interests(
        category: category5,
        interest: "Foodie",
        icon: Icon(Icons.local_dining)),
  ]
};

Map<String, List<Interests>> music = {
  category6: [
    Interests(
        category: category6, interest: "Country", icon: Icon(Icons.music_note)),
    Interests(
        category: category6, interest: "EDM", icon: Icon(Icons.music_note)),
    Interests(
        category: category6,
        interest: "Electronic",
        icon: Icon(Icons.music_note)),
    Interests(
        category: category6, interest: "Classic", icon: Icon(Icons.music_note)),
    Interests(
        category: category6, interest: "Jazz", icon: Icon(Icons.music_note)),
    Interests(
        category: category6, interest: "Desi", icon: Icon(Icons.music_note)),
    Interests(
        category: category6, interest: "Textbox", icon: Icon(Icons.music_note)),
  ]
};

Map<String, List<Interests>> films = {
  category7: [
    Interests(
        category: category7,
        interest: "Thriller & Crime",
        icon: Icon(Icons.movie)),
    Interests(category: category7, interest: "Action", icon: Icon(Icons.movie)),
    Interests(
        category: category7, interest: "Animated", icon: Icon(Icons.movie)),
    Interests(category: category7, interest: "Comedy", icon: Icon(Icons.movie)),
    Interests(category: category7, interest: "Horror", icon: Icon(Icons.movie)),
    Interests(
        category: category7, interest: "Bollywood", icon: Icon(Icons.movie)),
  ]
};

Map<String, List<Interests>> reading = {
  category8: [
    Interests(
        category: category8, interest: "Biographies", icon: Icon(Icons.book)),
    Interests(
        category: category8, interest: "Business", icon: Icon(Icons.book)),
    Interests(
        category: category8, interest: "Cookbooks", icon: Icon(Icons.book)),
    Interests(category: category8, interest: "Fiction", icon: Icon(Icons.book)),
    Interests(category: category8, interest: "History", icon: Icon(Icons.book)),
    Interests(category: category8, interest: "Mystery", icon: Icon(Icons.book)),
    Interests(
        category: category8, interest: "Non-fiction", icon: Icon(Icons.book)),
    Interests(category: category8, interest: "Romance", icon: Icon(Icons.book)),
    Interests(
        category: category8, interest: "Self-help", icon: Icon(Icons.book)),
    Interests(
        category: category8, interest: "Textbooks", icon: Icon(Icons.book)),
  ]
};

Map<String, List<Interests>> travel = {
  category9: [
    Interests(
        category: category9,
        interest: "Backpacking",
        icon: Icon(Icons.airplanemode_active)),
    Interests(
        category: category9,
        interest: "Beaches",
        icon: Icon(Icons.airplanemode_active)),
    Interests(
        category: category9,
        interest: "Camping",
        icon: Icon(Icons.airplanemode_active)),
    Interests(
        category: category9,
        interest: "Road trips",
        icon: Icon(Icons.airplanemode_active)),
    Interests(
        category: category9,
        interest: "Trekking",
        icon: Icon(Icons.airplanemode_active)),
  ]
};

Map<String, List<Interests>> hobbies = {
  category10: [
    Interests(category: category10, interest: "Art", icon: Icon(Icons.brush)),
    Interests(
        category: category10,
        interest: "Cooking",
        icon: Icon(Icons.restaurant)),
    Interests(
        category: category10,
        interest: "Dancing",
        icon: Icon(Icons.directions_run)),
    Interests(
        category: category10,
        interest: "Gaming",
        icon: Icon(Icons.videogame_asset)),
    Interests(
        category: category10, interest: "Gardening", icon: Icon(Icons.grass)),
    Interests(
        category: category10,
        interest: "Photography",
        icon: Icon(Icons.photo_camera)),
    Interests(category: category10, interest: "Singing", icon: Icon(Icons.mic)),
    Interests(
        category: category10, interest: "Writing", icon: Icon(Icons.create)),
  ]
};

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
