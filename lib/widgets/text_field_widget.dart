import 'package:flutter/material.dart';

class Textfield extends StatefulWidget {
  final Color textcolor;
  final double textsize;
  final String hinttext;
  final Color hintcolor;
  final double hintsize;
  final Color textfieldcolor;
  final bool obscure;
  final double textfieldradius;
  final double blurRadius;
  final double? imagesize;
  final double fieldheight;
  final double fieldwidth;
  final Color boxshadowcolor;
  final Offset shadowoffset;
  final int? maxlenght;
  final double borderwidth;
  final Color bordercolor;
  final String? prefixImage;
  final String? suffixImage;
  final TextEditingController controllername;

  final Color? focusedBorderColor;
  final double? focusedBorderWidth;

  const Textfield({
    super.key,
    required this.textcolor,
    required this.textsize,
    required this.hinttext,
    required this.hintcolor,
    required this.hintsize,
    required this.textfieldcolor,
    required this.obscure,
    required this.textfieldradius,
    required this.blurRadius,
    this.imagesize,
    required this.fieldheight,
    required this.fieldwidth,
    required this.boxshadowcolor,
    required this.shadowoffset,
    this.maxlenght,
    required this.borderwidth,
    required this.bordercolor,
    this.prefixImage,
    this.suffixImage,
    this.focusedBorderColor,
    this.focusedBorderWidth,
     required this.controllername,
  });

  @override
  State<Textfield> createState() => _TextfieldState();
}

class _TextfieldState extends State<Textfield> {
  late bool isObscure;

  final FocusNode focusNode = FocusNode();

  bool isFocused = false;

  @override
  void initState() {
    super.initState();

    isObscure = widget.obscure;

    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.fieldheight,
      width: widget.fieldwidth,
      decoration: BoxDecoration(
        color: widget.textfieldcolor,
        borderRadius: BorderRadius.circular(widget.textfieldradius),

       border: Border.all(
  width: isFocused
      ? (widget.focusedBorderWidth ?? widget.borderwidth)
      : widget.borderwidth,
  color: isFocused
      ? (widget.focusedBorderColor ?? widget.bordercolor)
      : widget.bordercolor,
),

        boxShadow: [
          BoxShadow(
            color: widget.boxshadowcolor,
            blurRadius: widget.blurRadius,
            offset: widget.shadowoffset,
          ),
        ],
      ),

      child: TextField(
        controller: widget.controllername,
        focusNode: focusNode,

        maxLength: widget.maxlenght,
        obscureText: isObscure,

        style: TextStyle(
          fontSize: widget.textsize,
          color: widget.textcolor,
        ),

        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),

          counterText: '',

          hintText: widget.hinttext,

          hintStyle: TextStyle(
            color: widget.hintcolor,
            fontSize: widget.hintsize,
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),

        

          suffixIcon: widget.suffixImage == null
              ? null
              : GestureDetector(
                  onTap: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Image.asset(
                      isObscure
                          ? "lib/assets/images/eyeclosed.png"
                          : "lib/assets/images/eyesopen.png",
                      height: widget.imagesize,
                      width: widget.imagesize,
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}