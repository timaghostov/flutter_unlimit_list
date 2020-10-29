



class FullName {
    String title;
    String first;
    String last;

    FullName({this.title, this.first, this.last});

    factory FullName.fromJson(Map<String, dynamic> json) {
        return FullName (
            title: json['title'] as String,
            first: json['first'] as String,
            last: json['last'] as String,
        );
    }

    @override
    String toString() {
        // return "${this.title} ${this.first} ${this.last}";
        return "${this.first} ${this.last}";
    }
}