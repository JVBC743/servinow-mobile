class UserModel {
  final int id;
  final String nome;
  final String email;
  final bool? isAdmin;
  final String? cpfCnpj;
  final String? dataNascimento;
  final String? telefone;
  final String? areaAtuacao;
  final String? cep;
  final String? logradouro;
  final String? numero;
  final String? complemento;
  final String? bairro;
  final String? cidade;
  final String? uf;
  final String? descricao;
  final String? caminhoImg;
  final String? redeSocial1;
  final String? redeSocial2;
  final String? redeSocial3;
  final String? redeSocial4;

  UserModel({
    required this.id,
    required this.nome,
    required this.email,
    this.isAdmin,
    this.cpfCnpj,
    this.dataNascimento,
    this.telefone,
    this.areaAtuacao,
    this.cep,
    this.logradouro,
    this.numero,
    this.complemento,
    this.bairro,
    this.cidade,
    this.uf,
    this.descricao,
    this.caminhoImg,
    this.redeSocial1,
    this.redeSocial2,
    this.redeSocial3,
    this.redeSocial4,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nome: json['nome'] ?? '',
      email: json['email'] ?? '',
      isAdmin: json['is_admin'],
      cpfCnpj: json['cpf_cnpj'],
      dataNascimento: json['data_nascimento'],
      telefone: json['telefone'],
      areaAtuacao: json['area_atuacao'],
      cep: json['cep'],
      logradouro: json['logradouro'],
      numero: json['numero'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      cidade: json['cidade'],
      uf: json['uf'],
      descricao: json['descricao'],
      caminhoImg: json['caminho_img'],
      redeSocial1: json['rede_social1'],
      redeSocial2: json['rede_social2'],
      redeSocial3: json['rede_social3'],
      redeSocial4: json['rede_social4'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'is_admin': isAdmin,
      'cpf_cnpj': cpfCnpj,
      'data_nascimento': dataNascimento,
      'telefone': telefone,
      'area_atuacao': areaAtuacao,
      'cep': cep,
      'logradouro': logradouro,
      'numero': numero,
      'complemento': complemento,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'descricao': descricao,
      'caminho_img': caminhoImg,
      'rede_social1': redeSocial1,
      'rede_social2': redeSocial2,
      'rede_social3': redeSocial3,
      'rede_social4': redeSocial4,
    };
  }
}
