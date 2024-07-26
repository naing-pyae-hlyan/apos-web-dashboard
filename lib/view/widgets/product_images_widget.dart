import 'dart:convert';

import 'package:apos/lib_exp.dart';

class ProductImagesWidget extends StatefulWidget {
  final double contentWidth;
  const ProductImagesWidget({
    super.key,
    required this.contentWidth,
  });

  @override
  State<ProductImagesWidget> createState() => _ProductImagesWidgetState();
}

class _ProductImagesWidgetState extends State<ProductImagesWidget> {
  late AttachmentsBloc attachmentsBloc;

  @override
  void initState() {
    attachmentsBloc = context.read<AttachmentsBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.contentWidth,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          myText("Product Media (optional)", fontWeight: FontWeight.w800),
          verticalHeight8,
          BlocBuilder<AttachmentsBloc, AttachmentsState>(
            builder: (_, state) {
              final images = state.base64Images;

              return SizedBox(
                height: 108,
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length + 1,
                  itemBuilder: (_, index) {
                    if (index == images.length && index < 3) {
                      return addImageCard;
                    }

                    if (index == 3) {
                      return emptyUI;
                    }

                    return imageCard(images[index], index);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget get addImageCard => Clickable(
        onTap: () async {
          final file = await ImagePickerUtils.pickImage();
          if (file != null) {
            attachmentsBloc.add(
              AttachmentsEventPickImage(base64Image: base64Encode(file.data)),
            );
          }
        },
        radius: 12,
        child: const MyCard(
          child: Icon(
            Icons.add_a_photo_outlined,
            size: 64,
          ),
        ),
      );

  Widget imageCard(String image, int index) => MyCard(
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Container(
                margin: const EdgeInsets.all(16),
                child: Image.memory(
                  base64Decode(image),
                  fit: BoxFit.cover,
                  width: 64,
                  height: 64,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.add_a_photo_outlined),
                ),
              ),
              Positioned(
                top: -8,
                right: -8,
                child: IconButton(
                  onPressed: () {
                    attachmentsBloc
                        .add(AttachmentEventRemoveImage(index: index));
                  },
                  icon: const Icon(
                    Icons.remove_circle,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
