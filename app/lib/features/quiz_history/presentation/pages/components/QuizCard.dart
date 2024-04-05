import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../models/quiz_participation.dart';

class QuizCard extends StatelessWidget {
  const QuizCard(this.weeklyQuizParticipant, this.date, this.score, this.level,
      {super.key});
  // this.context);

  final WeeklyQuizParticipation weeklyQuizParticipant;
  final String date;
  final String score;
  final String level;
  // final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await context.push(
          Uri(
            path: '/quiz_start',
            queryParameters: {
              'quiz_participant_id': weeklyQuizParticipant.id,
            },
          ).toString(),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 24),
        margin: const EdgeInsets.only(bottom: 16),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    weeklyQuizParticipant.quiz_title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Text(
                'Nilai: $score',
                style:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'Kategori: $level',
                style: const TextStyle(fontSize: 12),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'Dikerjakan: $date',
                style: const TextStyle(fontSize: 12),
              )
            ],
          )
        ]),
      ),
    );
  }
}
