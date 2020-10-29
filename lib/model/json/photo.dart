



class Photo {
    String large;
    String medium;
    String thumbnail;

    Photo({this.large, this.medium, this.thumbnail});

    factory Photo.fromJson(Map<String, dynamic> json) {
        return Photo (
            large: json['large'] as String,
            medium: json['medium'] as String,
            thumbnail: json['thumbnail'] as String,
        );
    }

    @override
    String toString() {
        return "Photo { large :: ${this.large}; medium :: ${this.medium}; thumbnail :: ${this.thumbnail} }";
    }
}