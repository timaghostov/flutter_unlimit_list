



import 'package:unlimit_list/model/event/event.dart';

class VItemBuilder extends AppEvent {
    int _index;

    VItemBuilder( int index ): super(EventType.verticalItemBuild) {
        this._index = index;
    }

    int get index => this._index;
}