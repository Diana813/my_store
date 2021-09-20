import 'description_sections.dart';

class Description {
  List<Section> sections = [];

  Description({
    this.sections,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      var sectionObject = json['sections'] as List;
      List<Section> _sections =
          sectionObject.map((items) => Section.fromJson(items)).toList();
      return Description(
        sections: _sections,
      );
    }
    return null;
  }

  Map<String, dynamic> toJson() {
    return {'sections': sections};
  }
}
