# English Words App

Aplicativo desenvolvido para Android e IOS utilizado para explorar, visualizar e gerenciar palavras em inglês de forma offline, com suporte a histórico, favoritos, fonética e áudio de pronúncia.

---

## Tecnologias Utilizadas

Utilizei a linguagem **Dart** com framework **Flutter**, gerenciei os estados utilizando **Provider**, utilizei o banco de dados offline **SQLite (sqflite)**, para a listagem utilizei um **JSON local pré-carregado (words_dictionary.json)**, já para os detalhes da palavra (significado, fonética, áudio) utilizei a **Free Dictionary API**, para reproduzir os áudios da API utilizei o pacote **just_audio**.

---

## 📂 Organização do Projeto

- `lib/features/`  
  Telas e componentes principais (Word List, History, Favorites, Word Detail)

- `lib/state/`  
  Gerenciamento de estado com Provider

- `lib/repositories/`  
  Acesso à API e banco de dados SQLite

- `lib/router/`  
  Configuração de rotas com go_router

- `assets/words_dictionary.json`  
  Dicionário local carregado na inicialização

  ---

  ## ⚙️ Funcionalidades

- [x] Listagem infinita de palavras com rolagem contínua (lazy loading)
- [x] Tela de detalhes com:
  - Palavra
  - Fonética
  - Lista de significados
- [x] Pronúncia em áudio (com botão de play)
- [x] Histórico de palavras visualizadas
- [x] Sistema de favoritos (com ícone de estrela)
- [x] Navegação por abas:
  - Word List
  - History
  - Favorites
- [x] Armazenamento local com SQLite
- [x] Integração com Free Dictionary API para definição das palavras
- [x] UX amigável com tratamento de erros e carregamentos

---

## 🛡️ Observações

- Todas as palavras são carregadas localmente no primeiro uso a partir de um arquivo `.json`.
- O Firebase foi removido por não ser necessário para os requisitos do projeto.
- A API externa (Free Dictionary API) é utilizada apenas na tela de detalhes para buscar definições, fonética e áudio.
- O projeto foi otimizado para funcionar de forma offline após o carregamento inicial.
- Os dados são armazenados em banco de dados local (SQLite), garantindo performance mesmo com listas grandes.

---

## ✅ Requisitos atendidos do desafio

- [x] Listagem infinita com base em um arquivo local
- [x] Tela de detalhes com palavra, fonética e significados
- [x] Histórico de palavras visualizadas
- [x] Sistema de favoritos com persistência
- [x] Tocador de áudio funcional
- [x] Organização por abas (Word List, History, Favorites)
- [x] Clean Code e separação de responsabilidades
- [x] Cache local usando SQLite
- [x] Boa experiência de uso mesmo em dispositivos mais simples

---

## Como instalar e rodar o projeto

### Instruções

```bash
# Clone o repositório
git clone https://github.com/nicolasvitorino/english-words-app.git
cd english-words-app

# Instale as dependências
flutter pub get

# Rode o app
flutter run
```

>  This is a challenge by [Coodesh](https://coodesh.com/)

