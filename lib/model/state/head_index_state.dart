

import 'package:unlimit_list/model/state/current_index.dart';


class HeadIndexState {
    CurrentIndex _index;

    void setCurrentIndex(CurrentIndex index) {
        this._index = index;
    }

    CurrentIndex get currentIndex => this._index;
}