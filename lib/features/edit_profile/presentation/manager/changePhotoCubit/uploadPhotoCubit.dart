import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flower_shop/app/config/base_state/base_state.dart';
import 'package:flower_shop/app/core/network/api_result.dart';
import 'package:flower_shop/features/edit_profile/domain/usecases/upload_photo_usecase.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoIntent.dart';
import 'package:flower_shop/features/edit_profile/presentation/manager/changePhotoCubit/uploadPhotoState.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoCubit extends Cubit<UploadPhotoState> {
  final UploadPhotoUseCase _uploadPhotoUseCase;

  UploadPhotoCubit(this._uploadPhotoUseCase) : super(UploadPhotoState());

  void doIntent(UploadPhotoIntent intent) {
    if (intent is SelectPhotoIntent) {
      _selectPhoto(intent);
    } else if (intent is UploadSelectedPhotoIntent) {
      _uploadPhoto(intent);
    }
  }

  void _selectPhoto(SelectPhotoIntent intent) {
    emit(state.copyWith(selectedPhoto: intent.photo));
  }

  void _uploadPhoto(UploadSelectedPhotoIntent intent) async {
    if (state.selectedPhoto == null) return;

    emit(state.copyWith(uploadPhotoResource: Resource.loading()));

    final result = await _uploadPhotoUseCase.call(
      token: intent.token,
      photo: state.selectedPhoto!,
    );

    if (isClosed) return;
    if (result is SuccessApiResult) {
      emit(
        state.copyWith(
          uploadPhotoResource: Resource.success(
            (result as SuccessApiResult).data,
          ),
        ),
      );
    } else if (result is ErrorApiResult) {
      emit(
        state.copyWith(
          uploadPhotoResource: Resource.error((result as ErrorApiResult).error),
        ),
      );
    }
  }
}
