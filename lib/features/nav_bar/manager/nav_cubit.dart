import 'package:bloc/bloc.dart';
import 'package:flower_shop/features/nav_bar/manager/nav_state.dart';


class NavCubit extends Cubit<NavState> {
  NavCubit() : super(const NavInitial(selectedIndex: 0));

  void updateIndex(int index) {
    emit(NavState(selectedIndex: index));
  }
}
