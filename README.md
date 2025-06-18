# English Words App

Aplicativo desenvolvido para Android e IOS utilizado para explorar, visualizar e gerenciar palavras em inglês de forma offline, com suporte a histórico, favoritos, fonética e áudio de pronúncia.

---

## Tecnologias Utilizadas

Utilizei a linguagem **Dart** com framework **Flutter**, gerenciei os estados utilizando **Provider**, utilizei o banco de dados offline **SQLite (sqflite), para a listagem utilizei um **JSON local pré-carregado (words_dictionary.json)**, já para os detalhes da palavra (significado, fonética, áudio) utilizei a **Free Dictionary API**, para reproduzir os áudios da API utilizei o pacote **just_audio**.

---

## Como instalar e rodar o projeto

### Instruções

```bash
# Clone o repositório
git clone https://github.com/seu-usuario/english-words-app.git
cd english-words-app

# Instale as dependências
flutter pub get

# Rode o app
flutter run
