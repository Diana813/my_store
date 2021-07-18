import 'description_sections.dart';

class Description {
  List<Sections> sections;

  Description({
    this.sections,
  });

  factory Description.fromJson(Map<String, dynamic> json) {
    if (json['sections'] != null) {
      var sectionObject = json['sections'] as List;
      List<Sections> _sections =
          sectionObject.map((items) => Sections.fromJson(items)).toList();
      return Description(
        sections: _sections,
      );
    }
    return null;
  }
}
