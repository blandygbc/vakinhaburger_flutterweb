import 'package:flutter/material.dart';
import 'package:validatorless/validatorless.dart';

import '../../../../core/ui/helpers/size_extensions.dart';
import '../../../../core/ui/styles/text_styles.dart';
import '../../../../models/payment_type_model.dart';
import '../../payment_type_controller.dart';

class PaymentTypeFormModal extends StatefulWidget {
  final PaymentTypeController controller;
  final PaymentTypeModel? model;

  const PaymentTypeFormModal({
    super.key,
    required this.model,
    required this.controller,
  });

  @override
  State<PaymentTypeFormModal> createState() => _PaymentTypeFormModalState();
}

class _PaymentTypeFormModalState extends State<PaymentTypeFormModal> {
  final formKey = GlobalKey<FormState>();
  final nameEC = TextEditingController();
  final acronymEC = TextEditingController();
  var enabled = false;

  void closeModal() => Navigator.of(context).pop();

  @override
  void initState() {
    final paymentModel = widget.model;
    if (paymentModel != null) {
      nameEC.text = paymentModel.name;
      acronymEC.text = paymentModel.acronym;
      enabled = paymentModel.enabled;
    }
    super.initState();
  }

  @override
  void dispose() {
    nameEC.dispose();
    acronymEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = context.screenWidth;
    return SingleChildScrollView(
      child: Container(
        width: screenWidth * (screenWidth > 1200 ? .5 : .7),
        padding: const EdgeInsets.all(30),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      '${widget.model == null ? 'Adicionar' : 'Editar'} forma de pagamento'
                          .toUpperCase(),
                      textAlign: TextAlign.center,
                      style: context.textStyles.title,
                    ),
                  ),
                  InkWell(
                    onTap: () => closeModal(),
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameEC,
                decoration: const InputDecoration(
                  label: Text('Nome'),
                ),
                validator: Validatorless.required('Nome é obrigatório'),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: acronymEC,
                decoration: const InputDecoration(
                  label: Text('Sigla'),
                ),
                validator: Validatorless.required('Sigla é obrigatória'),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text('Ativo', style: context.textStyles.regular),
                  Switch(
                    value: enabled,
                    onChanged: (value) {
                      setState(() {
                        enabled = value;
                      });
                    },
                  ),
                ],
              ),
              Divider(
                color: Colors.grey.shade400,
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: OutlinedButton(
                      onPressed: () => closeModal(),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      child: Text(
                        'Cancelar',
                        style: context.textStyles.extraBold
                            .copyWith(color: Colors.red),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    padding: const EdgeInsets.all(8),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        final valid = formKey.currentState?.validate() ?? false;

                        if (valid) {
                          final name = nameEC.text;
                          final acronym = acronymEC.text;
                          widget.controller.savePayment(
                            id: widget.model?.id,
                            name: name,
                            acronym: acronym,
                            enabled: enabled,
                          );
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Salvar'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
