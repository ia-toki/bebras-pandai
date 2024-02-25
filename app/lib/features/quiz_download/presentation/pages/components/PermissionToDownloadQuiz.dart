import 'package:bebras_pandai/models/quiz_participation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/bases/widgets/atoms/button.dart';

class PermissionToDownloadQuiz extends StatelessWidget {
  const PermissionToDownloadQuiz({required this.onClickDownload}) : super();

  // const PermissionToDownloadQuiz();

  final Function onClickDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: const Icon(
              Icons.download_outlined,
              color: Colors.white,
              size: 70,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Sudah Siap Mengunduh?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text:
                  'Apakah anda yakin sudah siap mengunduh? Proses akan berjalan secara background (tetap berjalan walaupun aplikasi tidak dibuka)',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Expanded(
            child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Column(
                  children: [
                    Button(
                      borderRadius: 4,
                      customTextColor: const Color(0xFF1BB8E1),
                      customButtonColor: Colors.white,
                      customBorderColor: const Color(0xFF1BB8E1),
                      fontSize: 14,
                      innerVerticalPadding: 10,
                      onTap: () async {
                        onClickDownload();
                      },
                      text: 'Mulai Mengunduh',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Button(
                      borderRadius: 4,
                      customTextColor: Colors.white,
                      customButtonColor: const Color(0xFF1BB8E1),
                      fontSize: 14,
                      innerVerticalPadding: 10,
                      onTap: () async {
                        Navigator.of(context).pop();
                      },
                      text: 'Batalkan',
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
