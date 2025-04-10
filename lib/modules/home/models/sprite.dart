import 'package:pokemon_app/core/models/main.dart';

class Sprites implements ModelInterface {
  final String? _frontDefault;
  final String? _officialArtwork;

  Sprites({String? frontDefault, String? officialArtwork})
      : _frontDefault = frontDefault,
        _officialArtwork = officialArtwork;

  String? get frontDefault => _frontDefault;
  String? get officialArtwork => _officialArtwork;

  @override
  Sprites.fromJson(Map<String, dynamic> json)
      : _frontDefault = json['front_default'],
        _officialArtwork = json['other']['official-artwork']['front_default'];

  @override
  Map<String, dynamic> toJson() {
    return {
      'front_default': _frontDefault,
      'official_artwork': _officialArtwork,
    };
  }
}
