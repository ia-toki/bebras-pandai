import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/bases/widgets/atoms/button.dart';
import '../../../../../models/quiz_participation.dart';

class QuizCard extends StatelessWidget {
  const QuizCard(this.weeklyQuizParticipant, this.date, this.score, this.level,
      this.maxAttempts, this.countAttempts,
      {super.key});

  final WeeklyQuizParticipation weeklyQuizParticipant;
  final String date;
  final String score;
  final String level;
  final int maxAttempts;
  final int countAttempts;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
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
        child: Row(
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    weeklyQuizParticipant.quiz_title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Nilai: $score',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.clock,
                        size: 12,
                        color: Colors.blueGrey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Dikerjakan: $date',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sisa coba lagi: ${maxAttempts - countAttempts}/$maxAttempts',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF1BB8E1),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Visibility(
                visible: countAttempts < maxAttempts,
                child: Button(
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
                  customButtonColor: const Color(0xFF1BB8E1),
                  customTextColor: Colors.white,
                  text: 'Mulai lagi',
                  fontSize: 12,
                  innerVerticalPadding: 8,
                  innerHorizontalPadding: 8,
                  borderRadius: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
