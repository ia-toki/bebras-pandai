import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../services/firebase_service.dart';
import '../../../authentication/register/repositories/register_user_repo.dart';
import '../model/form_item.dart';

part 'user_register_event.dart';
part 'user_register_state.dart';

@injectable
@singleton
class UserRegisterBloc extends Bloc<UserRegisterEvent, RegisterFormState> {
  final RegisterUserRepository registerUserRepository;

  UserRegisterBloc(this.registerUserRepository)
      : super(const RegisterFormState()) {
    on<InitialValueEvent>(initValueState);
    on<InitEvent>(_initState);
    on<EmailEvent>(_onEmailChanged);
    on<NameEvent>(_onNameChanged);
    on<BirthDateEvent>(_onBirthDateChanged);
    on<SchoolEvent>(_onSchoolChanged);
    on<ProvinceEvent>(_onProvinceChanged);
    on<BebrasBiroEvent>(_onBebrasBiroChanged);
    on<FormSubmitEvent>(_onFormSubmitted);
    on<FormSubmitUpdateEvent>(_onFormUpdateSubmitted);
    on<FormResetEvent>(_onFormReset);
  }

  final formKey = GlobalKey<FormState>();

  FutureOr<void> initValueState(
    InitialValueEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    await FirebaseFirestore.instance
        .collection('registered_user')
        .doc(FirebaseService.auth().currentUser?.uid)
        .get()
        .then(
          (value) => {
            emit(
              state.copyWith(
                formKey: formKey,
                name: BlocFormItem(
                  value: value['name'].toString(),
                ),
                email: BlocFormItem(
                  value: value['email'].toString(),
                ),
                birthDate: BlocFormItem(
                  value: value['birth_date'].toString(),
                ),
                school: BlocFormItem(
                  value: value['school'].toString(),
                ),
                province: BlocFormItem(
                  value: value['province'].toString(),
                ),
                bebrasBiro: BlocFormItem(
                  value: value['bebras_biro'].toString(),
                ),
              ),
            ),
          },
        );
  }

  Future<void> _initState(
    InitEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    emit(state.copyWith(formKey: formKey));
  }

  Future<void> _onNameChanged(
    NameEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    emit(
      state.copyWith(
        name: BlocFormItem(
          value: event.name.value,
          error: event.name.value == ''
              ? 'Mohon mengisi nama terlebih dahulu.'
              : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onEmailChanged(
    EmailEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    emit(
      state.copyWith(
        email: BlocFormItem(
          value: event.email.value,
          error: event.email.value == ''
              ? 'Mohon mengisi e-mail terlebih dahulu.'
              : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onBirthDateChanged(
    BirthDateEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    emit(
      state.copyWith(
        birthDate: BlocFormItem(
          value: event.birthDate.value,
          error: event.birthDate.value == ''
              ? 'Mohon mengisi tanggal lahir terlebih dahulu.'
              : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onSchoolChanged(
    SchoolEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    emit(
      state.copyWith(
        school: BlocFormItem(
          value: event.school.value,
          error: event.school.value == ''
              ? 'Mohon mengisi nama sekolah terlebih dahulu.'
              : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onProvinceChanged(
    ProvinceEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    emit(
      state.copyWith(
        province: BlocFormItem(
          value: event.province.value,
          error: event.province.value == ''
              ? 'Mohon mengisi nama provinsi terlebih dahulu.'
              : null,
        ),
        formKey: formKey,
      ),
    );
  }

  Future<void> _onBebrasBiroChanged(
    BebrasBiroEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    emit(
      state.copyWith(
        bebrasBiro: BlocFormItem(
          value: event.bebrasBiro.value,
          error: event.bebrasBiro.value == ''
              ? 'Mohon mengisi biro bebras terlebih dahulu.'
              : null,
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
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;

    if (state.formKey!.currentState!.validate()) {
      final email = state.email.value;
      final name = state.name.value;
      final birthDate = state.birthDate.value;
      final school = state.school.value;
      final province = state.province.value;
      final bebrasBiro = state.bebrasBiro.value;

      emit(UserRegisterLoadingState());

      try {
        await registerUserRepository.create(
          userId: userId,
          email: email,
          name: name,
          birthDate: birthDate,
          school: school,
          province: province,
          bebrasBiro: bebrasBiro,
        );
        emit(UserRegisterSuccessState());
      } catch (e) {
        // emit(Us)
      }
    }
  }

  Future<void> _onFormUpdateSubmitted(
    FormSubmitUpdateEvent event,
    Emitter<RegisterFormState> emit,
  ) async {
    final auth = FirebaseAuth.instance;
    final userId = auth.currentUser!.uid;

    if (state.formKey!.currentState!.validate()) {
      final email = state.email.value;
      final name = state.name.value;
      final birthDate = state.birthDate.value;
      final school = state.school.value;
      final province = state.province.value;
      final bebrasBiro = state.bebrasBiro.value;

      emit(UserRegisterLoadingState());

      try {
        await registerUserRepository.update(
          userId: userId,
          email: email,
          name: name,
          birthDate: birthDate,
          school: school,
          province: province,
          bebrasBiro: bebrasBiro,
        );
        emit(UserRegisterSuccessState());
      } catch (e) {
        // emit(Us)
      }
    }
  }
}
