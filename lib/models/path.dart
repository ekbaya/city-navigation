import 'dart:convert';

Path pathFromJson(String str) => Path.fromJson(json.decode(str));

String pathToJson(Path data) => json.encode(data.toJson());

class Path {
  Path({
    required this.path,
  });

  List<List<double>> path;

  factory Path.fromJson(Map<String, dynamic> json) => Path(
        path: List<List<double>>.from(
          json["path"].map(
            (x) => List<double>.from(
              x.map((x) => x.toDouble()),
            ),
          ),
        ),
      );

  Map<String, dynamic> toJson() => {
        "path": List<dynamic>.from(
          path.map(
            (x) => List<dynamic>.from(
              x.map((x) => x),
            ),
          ),
        ),
      };
}
