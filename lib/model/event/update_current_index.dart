



import 'package:unlimit_list/model/event/event.dart';

class UpdateCurrentIndex extends AppEvent {
    int _index;

    UpdateCurrentIndex( int index ): super(EventType.updateCurrentIndex) {
        this._index = index;
    }

    int get index => this._index;
}