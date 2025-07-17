String? validateCPF(String? value) {
  if (value == null || value.isEmpty) return 'Informe o CPF';
  // Validação simples para CPF válido (você pode usar pacote mais completo)
  return value.length == 14 ? null : 'CPF inválido';
}

String? validateMaiorDeIdade(String? value) {
  if (value == null || value.isEmpty) {
    return 'Informe a data de nascimento';
  }

  try {
    // Converte a string para DateTime
    final partes = value.split('/');
    if (partes.length != 3) return 'Data inválida';

    final dia = int.tryParse(partes[0]);
    final mes = int.tryParse(partes[1]);
    final ano = int.tryParse(partes[2]);

    if (dia == null || mes == null || ano == null) return 'Data inválida';

    final nascimento = DateTime(ano, mes, dia);
    final hoje = DateTime.now();
    final idade =
        hoje.year -
        nascimento.year -
        ((hoje.month < nascimento.month ||
                (hoje.month == nascimento.month && hoje.day < nascimento.day))
            ? 1
            : 0);

    if (idade < 18) return 'É necessário ter 18 anos ou mais';

    return null;
  } catch (e) {
    return 'Data inválida';
  }
}

String? validateSenhaSegura(String? value) {
  if (value == null || value.isEmpty) return 'Informe uma senha';
  final regex = RegExp(r'^(?=.*[!@#\$&*~])(?=.*\d).{8,}$');
  return regex.hasMatch(value)
      ? null
      : 'Senha fraca. Mín. 8 caracteres, 1 número e 1 símbolo';
}
