class APODNasaModel {
  APODNasaModel({
    required this.date,
    required this.explanation,
    required this.hdurl,
    required this.mediaType,
    required this.serviceVersion,
    required this.title,
    required this.url,
  });
  late final DateTime date;
  late final String explanation;
  late final String? hdurl;
  late final String mediaType;
  late final String serviceVersion;
  late final String title;
  late final String? url;

  APODNasaModel.fromJson(Map<String, dynamic> json) {
    date = DateTime.parse(json['date']);
    explanation = json['explanation'];
    hdurl = json['hdurl'];
    mediaType = json['media_type'];
    serviceVersion = json['service_version'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['date'] = date.toIso8601String();
    data['explanation'] = explanation;
    data['hdurl'] = hdurl;
    data['media_type'] = mediaType;
    data['service_version'] = serviceVersion;
    data['title'] = title;
    data['url'] = url;
    return data;
  }
}
