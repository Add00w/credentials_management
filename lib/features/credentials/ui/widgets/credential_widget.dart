import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/credentials.dart';

class CredentialWidget extends StatelessWidget {
  final Credentials credential;

  const CredentialWidget({
    Key? key,
    required this.credential,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xff2b2d42),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            Image.network(
              credential.icon!,
              width: 20,
              height: 20,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.warning_amber_outlined);
              },
            ),
            const SizedBox(width: 4.0),
            Flexible(
              flex: 2,
              child: Text(
                '${credential.brand}.com',
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              flex: 2,
              child: Text(
                credential.userNameOrEmail,
                style: Theme.of(context).textTheme.bodyText2!.copyWith(
                      overflow: TextOverflow.ellipsis,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              flex: 3,
              child: BlocProvider(
                create: (context) => ObescureCubit(),
                child: PasswordWidget(
                  password: credential.password,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PasswordWidget extends StatelessWidget {
  const PasswordWidget({
    Key? key,
    required this.password,
  }) : super(key: key);

  final String password;

  @override
  Widget build(BuildContext context) {
    final obscure = context.watch<ObescureCubit>().state;
    return Row(
      children: [
        Flexible(
          child: TextField(
            controller: TextEditingController(text: password),
            readOnly: true,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  overflow: TextOverflow.ellipsis,
                ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12),
            ),
            obscureText: obscure,
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              context.read<ObescureCubit>().togleVisibility();
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(
                obscure ? Icons.visibility_off : Icons.visibility,
              ),
            ),
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(left: 12),
              child: Icon(Icons.copy),
            ),
          ),
        ),
      ],
    );
  }
}

class ObescureCubit extends Cubit<bool> {
  ObescureCubit() : super(true);
  void togleVisibility() {
    emit(!state);
  }
}
