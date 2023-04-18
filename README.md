<a name="readme-top"></a>

<h1 align="center">Verify - Gerencie suas transações de pix facilmente!</h1>

<!-- PROJECT LOGO -->
<br />

<div align="center">
  <a href="">
    <img src="images\App.png" alt="Logo" width="">
  </a>
  <p align="center">
 Este aplicativo oferece integração simples com o Api Pix, gerenciando suas transações de forma simples e segura

<br>
</div>
<br>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Indice</summary>
  <ol>
    <li><a href="#pre-requisitos">Pré Requisitos</a></li>
    <li><a href="#funcionalidades">Funcionalidades</a></li>
    <li><a href="#architecture">Architecture</a></li>
  </ol>
</details>

<br>

<!-- GETTING STARTED -->

# Pre Requisitos

1. ### Banco Sicoob:

- Chave pix cadastrada no Banco Sicoob
- Exclusivo para pessoas juridicas
- Certificado válido emitido por CAs externas em conformidade com o padrão internacional x.509
- Cadastro no portal: [Sicoob Developers Portal](https://developers.sicoob.com.br/portal)

2. ### Banco do Brasil:

- Chave Pix cadastrada no Banco do Brasil
- Exclusivo para pessoas juridicas
- Cadastro no portal: [Banco do Brasil Developers Portal](https://developers.bb.com.br/api-detalhes/5fa456cd751886001206b9f4/5fe317f6aa41dd0012009825/TRANSACOES_BANCARIAS)

<!-- ROADMAP -->

# 1.Funcionalidades

1. Autenticação o mais simples possivel.
2. Cadastrar varios bancos diferentes.
3. Reposicionar o banco preferido na pagina principal.
4. Visualizar transações recentes na pagina inicial.
5. Timeline para consultar todas as transações.
6. Sincronizar dados em nuvem.
7. Editar usuário autenticado.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## 1.1 Autenticação o mais simples possível

A autenticação é fundamental para as funcionalidades de armazenamento em nuvem do app e verificações de segurança.

Os seguintes metodos de autenticação devem ser suportados:

1. **Login com Google**
2. **Login com email e senha**

## 1.2 Cadastrar varios bancos diferentes.

O App deverá suportar cadastro de varios bancos diferentes porém apenas uma conta de cada banco deverá ser suportada.

Os Seguintes bancos devem ser suportados:

1. **Banco Sicoob**
2. **Banco do Brasil**

## 1.3 Reposicionar o banco preferido na pagina principal.

O App deverá suportar o reposicionamento do banco preferido do usuario na tela principal a fim de facilitar e agilizar consultas a pagamentos rapidamente.

## 1.4 Visualizar transações recentes na pagina inicial.

O App deverá oferecer uma pagina inicial com consultar as transações recentes.

## 1.5 Timeline para consultar todas as transações.

O App deverá oferecer a funcionalidade de uma **Timeline** aonde os usuarios poderam consultar suas transações em uma data especifica.

## 1.6 Sincronizar dados em nuvem.

O App deverá sincronizar os dados em nuvem do usuario utilizando metodos de criptografia para garantir a segurança.

O armazenamento em nuvem será utilizado para utilizar o app em multiplos dispositivos para que não seja nescessario recadastrar suas contas ao logar em outro dispositivo.

## 1.7 Editar usuário autenticado.

O app deverá ter opções de:

- Controle de tema
- Remoção de cache e dados locais.
- Exlusão de sua conta e dados armazenados em nuvem.
- Habilitar login com biometria

# 2. Experiência do Usuário

Toda interface será feita usando componentes pré-construidos do Material Design 3.

Mais informações sobre:

- Fonte
- Assets entre outros.

Estão disponiveis no
[Figma](https://www.figma.com/file/4v5Q4AqbZlCgT3JlsqQgzs/Verify---Material-3?node-id=53105%3A27714&t=Nm2JBfIy8vu0QKiG-1).

# 3. Arquitetura

[Geral](ARCHITECTURE.md)
