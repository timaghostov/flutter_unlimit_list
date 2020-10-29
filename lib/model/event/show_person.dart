



import 'package:unlimit_list/model/event/event.dart';

class ShowPerson extends AppEvent {
    int _index;

    ShowPerson( int index ): super(EventType.showPerson) {
        this._index = index;
    }

    int get index => this._index;
}