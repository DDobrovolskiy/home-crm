import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/support/components/callback/types/DoubleCallback.dart';
import 'package:home_crm_front/domain/support/components/callback/types/SingleCallback.dart';

class SheetElementAddCallback
    extends DoubleCallback<String, Widget Function()> {}

class SheetElementSelectCallback extends SingleCallback<String> {}

class SheetElementDeleteCallback extends SingleCallback<String> {}

typedef WidgetSupplier<W extends Widget> = W Function();