import 'package:flutter/material.dart';

import '../widgets/form_buton.dart';

class SectionCreateDialog extends StatefulWidget {
  const SectionCreateDialog({
    required this.createSection,
    Key? key,
  }) : super(key: key);

  final Function createSection;

  @override
  State<SectionCreateDialog> createState() => _SectionCreateDialogState();
}

class _SectionCreateDialogState extends State<SectionCreateDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var sectionTitle = "";
  var sectionDescription = "";

  void _createSection(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    widget.createSection(
      sectionTitle,
      sectionDescription,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                "Adicionar passo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Expanded(
                  child: Column(
                    children: [
                      const Text(
                        "Título do passo",
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: "Título do passo",
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Dê um nome ao passo da receita!";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.name,
                        onChanged: (newSectionTitle) {
                          if (newSectionTitle.isNotEmpty) {
                            // setState(() {
                            sectionTitle = newSectionTitle;
                            // });
                          }
                        },
                        textInputAction: TextInputAction.done,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Descrição do passo",
                      ),
                      TextFormField(
                        minLines: 4,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintText: "Descreva o que fazer neste passo",
                          hintMaxLines: 3,
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Descreva algo!";
                          }
                          return null;
                        },
                        onChanged: (newSectionDescription) {
                          setState(() {
                            sectionDescription = newSectionDescription;
                          });
                        },
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FormButton(
                        text: "Adicionar",
                        icon: Icons.add,
                        onPressed: () => _createSection(context),
                        option: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      FormButton(
                        text: "Cancelar",
                        icon: Icons.cancel,
                        onPressed: () => Navigator.of(context).pop(),
                        option: 2,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
