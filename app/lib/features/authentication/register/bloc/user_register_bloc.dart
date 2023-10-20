import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../authentication/register/repositories/register_user_repo.dart';
import '../model/form_item.dart';

part 'user_register_event.dart';

part 'user_register_state.dart';

@injectable
@singleton
class UserRegisterBloc extends Bloc<UserRegisterEvent, RegisterFormState> {
  final RegisterUserRepository registerUserRepository;
  UserRegisterBloc(this.registerUserRepository) : super(const RegisterFormState()) {
    on<InitEvent>(_initState);
    on<EmailEvent>(_onEmailChanged);
    on<NameEvent>(_onNameChanged);
    on<BirthDateEvent>(_onBirthDateChanged);
    on<SchoolEvent>(_onSchoolChanged);
    on<ProvinceEvent>(_onProvinceChanged);
    on<BebrasBiroEvent>(_onBebrasBiroChanged);
    on<FormSubmitEvent>(_onFormSubmitted);
    on<FormResetEvent>(_onFormReset);
  }

  final formKey = GlobalKey<FormState>();

  Future<void> _initState(InitEvent event, Emitter<RegisterFormState> emit) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onNameChanged(
      NameEvent event, Emitter<RegisterFormState> emit) async {
    emit(
      state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value == '' ? 'Mohon mengisi nama terlebih dahulu.' : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onEmailChanged(
      EmailEvent event, Emitter<RegisterFormState> emit) async {
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value == '' ? 'Mohon mengisi e-mail terlebih dahulu.' : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onBirthDateChanged(
      BirthDateEvent event, Emitter<RegisterFormState> emit) async {
    emit(
      state.copyWith(
        birth_date: BlocFormItem(
          value: event.birthDate.value,
          error: event.birthDate.value == '' ? 'Mohon mengisi tanggal lahir terlebih dahulu.' : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onSchoolChanged(
      SchoolEvent event, Emitter<RegisterFormState> emit) async {
    emit(
      state.copyWith(
        school: BlocFormItem(
          value: event.school.value,
          error: event.school.value == '' ? 'Mohon mengisi nama sekolah terlebih dahulu.' : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onProvinceChanged(
      ProvinceEvent event, Emitter<RegisterFormState> emit) async {
    emit(
      state.copyWith(
        province: BlocFormItem(
          value: event.province.value,
          error: event.province.value == '' ? 'Mohon mengisi nama provinsi terlebih dahulu.' : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onBebrasBiroChanged(
      BebrasBiroEvent event, Emitter<RegisterFormState> emit) async {
    emit(
      state.copyWith(
        bebras_biro: BlocFormItem(
          value: event.bebras_biro.value,
          error: event.bebras_biro.value == '' ? 'Mohon mengisi biro bebras terlebih dahulu.' : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onFormReset(
      FormResetEvent event,
      Emitter<RegisterFormState> emit,
      ) async {
    state.formKey?.currentState?.reset();
  }

  Future<void> _onFormSubmitted(
      FormSubmitEvent event,
      Emitter<RegisterFormState> emit,
      ) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    String userId = auth.currentUser?.uid as String;

    if (state.formKey!.currentState!.validate()) {

    String email = state.email.value.toString();
    String name = state.name.value.toString();
    String birthDate = state.birth_date.value.toString();
    String school = state.school.value.toString();
    String province = state.province.value.toString();
    String bebrasBiro = state.bebras_biro.value.toString();

      emit(UserRegisterLoadingState());

    try {
      await registerUserRepository.create(
          userId: userId,
          email: email,
          name: name,
          birth_date: birthDate,
          school: school,
          province: province,
          bebras_biro: bebrasBiro,
      );
      emit(UserRegisterSuccessState());
    } catch (e) {
      // emit(Us)
    }
    }
  }
}
