// ignore_for_file: lines_longer_than_80_chars
part of '_pages.dart';

class TaskViewDetail extends StatefulWidget {
  final QuizExercise task;
  final BuildContext context;
  final Function onTap;
  const TaskViewDetail({
    required this.task,
    required this.context,
    required this.onTap,
    super.key,
  });

  @override
  State<TaskViewDetail> createState() => _TaskViewDetailState();
}
  
class _TaskViewDetailState extends State<TaskViewDetail> {
  String? selectedStatus;

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                '${Assets.flagDir}${widget.task.country}.png',
                width: 40,
                height: 20,
              ),
              Flexible(
                child: Text(
                  widget.task.title,
                  textAlign: TextAlign.center,
                  style: FontTheme.blackSubtitleBold(),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    widget.task.id,
                    style: const TextStyle(fontSize: 9),
                  ),
                  Text(
                    widget.task.source,
                    style: const TextStyle(fontSize: 7),
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 2,
            color: Colors.black,
          ),
          const SizedBox(
            height: 3,
          ),
          Container(
            height: MediaQuery.of(context).size.height - 440,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(border: Border.all()),
            child: SingleChildScrollView(
              child: HtmlWithCachedImages(
                data: widget.task.description.content.replaceAll(Assets.sourceImg, Assets.urlImg),
              ),
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Text(
            'Status Saat Ini',
            textAlign: TextAlign.left,
            style: FontTheme.blackTextBold(),
          ),

          // Dropdown button for selecting status
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButton<String>(
              value: selectedStatus ?? widget.task.status,
              items: dropdownItems.map((item) {
                return DropdownMenuItem<String>(
                  value: item['value'],
                  child: Text(item['text']!),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Implement your logic on change here
                setState(() {
                  selectedStatus = newValue;
                });
              },
              hint: const Text('Pilih Status'),
              isExpanded: true,
              underline: Container(),
            ),
          ),
          
          const SizedBox(
            height: 14,
          ),
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 150,
              child: Button(
                text: 'Lihat Jawaban',
                buttonType: ButtonType.primary,
                onTap: widget.onTap,
              ),
            ),
            SizedBox(
              width: 150,
              child: Button(
                text: 'Simpan Status',
                buttonType: ButtonType.primary,
                onTap: () async {
                  final success = await context.read<QuizExerciseCubit>().updateStatus('${widget.task.challengeGroup}_${widget.task.id}', selectedStatus ?? widget.task.status);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                      content: Text(
                        success ? 'Status updated successfully!' : 'Failed to update status!',
                      ),
                    ),
                  );
                  
                }
              ),
            ),
          ],
        ),
        ],
      );
  }
}
