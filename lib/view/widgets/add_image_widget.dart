import 'package:apos/lib_exp.dart';

class AddImageWidget extends StatefulWidget {
  final Function(AttachmentFile?) pickedImage;
  const AddImageWidget({
    super.key,
    required this.pickedImage,
  });

  @override
  State<AddImageWidget> createState() => _AddImageWidgetState();
}

class _AddImageWidgetState extends State<AddImageWidget> {
  late ProductBloc productBloc;

  @override
  void initState() {
    productBloc = context.read<ProductBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        myText("Product Image", fontWeight: FontWeight.w800),
        verticalHeight8,
        BlocConsumer<ProductBloc, ProductState>(
          listener: (_, ProductState state) {
            if (state is ProductStatePickedProductImage) {
              widget.pickedImage(state.file);
            }
          },
          builder: (_, ProductState state) {
            if (state is ProductStatePickedProductImage) {
              return Stack(
                alignment: Alignment.topRight,
                children: [
                  MyCard(
                    padding: EdgeInsets.zero,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.memory(
                        state.file.data,
                        fit: BoxFit.cover,
                        width: 64 + 16,
                        height: 80 + 16,
                        errorBuilder: (_, __, ___) => Image.asset(
                          "",
                          fit: BoxFit.contain,
                          width: 64 + 16,
                          height: 80 + 16,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: -8,
                    right: -8,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              );
            }

            return Clickable(
              onTap: () {
                productBloc.add(ProductEventPickProductImage());
              },
              radius: 12,
              child: MyCard(
                child: SizedBox(
                  width: 64,
                  height: 80,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.add_a_photo_outlined),
                      verticalHeight8,
                      myText("Image", textAlign: TextAlign.center),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
