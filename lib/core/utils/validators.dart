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

String? validateTelefone(String? value) {
  if (value == null || value.isEmpty) return 'Informe o telefone';
  if (value.length < 14) return 'Telefone incompleto'; // (##) #####-####
  return null;
}

String? validateObrigatorio(String? value, String nomeCampo) {
  if (value == null || value.trim().isEmpty) return 'Informe $nomeCampo';
  return null;
}

String? validateUF(String? value) {
  if (value == null || value.isEmpty) return 'Informe UF';
  if (!RegExp(r'^[A-Za-z]{2}$').hasMatch(value)) return 'UF inválida';
  return null;
}

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Informe o email';
  if (!value.contains('@') || !value.contains('.')) return 'Email inválido';
  return null;
}
