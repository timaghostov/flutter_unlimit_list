



import 'package:unlimit_list/model/event/event.dart';

class HItemBuilder extends AppEvent {
    int _index;

    HItemBuilder( int index ): super(EventType.horizontalItemBuild) {
        this._index = index;
    }

    int get index => this._index;
}