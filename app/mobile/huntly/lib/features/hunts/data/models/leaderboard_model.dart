class LeaderboardRowModel {
  final String name;
  final int cluesSolved;
  final DateTime lastSolved;

  LeaderboardRowModel(
      {required this.cluesSolved,
      required this.lastSolved,
      required this.name});

  factory LeaderboardRowModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardRowModel(
        cluesSolved: json['no_of_clues'],
        name: json['name'],
        lastSolved: DateTime.parse(json['last_solved_at']));
  }

  Map<String, dynamic> toJson() {
    return {
      'cluesSolved': cluesSolved,
      'name': name,
    };
  }
}

class LeaderboardModel {
  final int huntId;
  List<LeaderboardRowModel> leaders;

  LeaderboardModel({
    required this.huntId,
    required this.leaders,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      huntId: json['hunt_id'],
      leaders: json['teams']
          .map<LeaderboardRowModel>(
              (team) => LeaderboardRowModel.fromJson(team))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'huntId': huntId,
      'leaders': leaders,
    };
  }
}
