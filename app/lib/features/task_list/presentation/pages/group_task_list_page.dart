part of '_pages.dart';

class GroupTaskListPage extends StatefulWidget {
  const GroupTaskListPage({super.key});

  @override
  State<GroupTaskListPage> createState() => _GroupTaskListPageState();
}


class _GroupTaskListPageState extends State<GroupTaskListPage> {
  
  @override
  Widget build(BuildContext context) {
    return BebrasScaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Image.asset(
                    Assets.bebrasPandaiText,
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  Button(
                    onTap: () {
                      context.push(
                        Uri(
                          path: '/task_list',
                          queryParameters: {
                            'challenge_group': 'sikecil',
                          },
                        ).toString(),
                      );
                    },
                    customButtonColor: Colors.blue.shade400,
                    customTextColor: Colors.white,
                    text: 'Daftar Latihan SiKecil',
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Button(
                      onTap: () {
                        context.push(
                          Uri(
                            path: '/task_list',
                            queryParameters: {
                              'challenge_group': 'siaga',
                            },
                          ).toString(),
                        );
                      },
                      customButtonColor: Colors.blue.shade400,
                      customTextColor: Colors.white,
                      text: 'Daftar Latihan Siaga',
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Button(
                      onTap: () {
                        context.push(
                          Uri(
                            path: '/task_list',
                            queryParameters: {
                              'challenge_group': 'penggalang',
                            },
                          ).toString(),
                        );
                      },
                      customButtonColor: Colors.blue.shade400,
                      customTextColor: Colors.white,
                      text: 'Daftar Latihan Penggalang',
                    ),
                  const SizedBox(
                    height: 15,
                  ),
                  Button(
                      onTap: () {
                        context.push(
                          Uri(
                            path: '/task_list',
                            queryParameters: {
                              'challenge_group': 'penegak',
                            },
                          ).toString(),
                        );
                      },
                      customButtonColor: Colors.blue.shade400,
                      customTextColor: Colors.white,
                      text: 'Daftar Latihan Penegak',
                    ),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
