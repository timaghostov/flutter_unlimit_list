



class Street {
    int number;
	String name;

    Street({this.number, this.name});

    factory Street.fromJson(Map<String, dynamic> json) {
        return Street (
            number: json['number'] as int,
            name: json['name'] as String,
        );
    }

    @override
    String toString() {
        return "${this.number} ${this.name}";
    }
}