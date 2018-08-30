# MANUAL DE INSTALAÇÃO, CONFIGURAÇÃO E UTILIZAÇÃO

- INSTALAÇÃO RUBY:
    - versão 2.4.4
        - link para baixar: https://github.com/oneclick/rubyinstaller2/releases/download/rubyinstaller-2.4.4-2/rubyinstaller-2.4.4-2-x64.exe
    - Instalar no diretório C:\Ruby24-x64
    - Antes de finalizar a instalação, selecione estas 3 opções:
        - Install Td/Tk support;
        - Add Ruby executables to your PATH;
        - Associate .rb and .rbw files with this Ruby installation; (caso tenha)
    - Na linha de comando, digite:
        - ruby -v (para verificar se foi instalada com sucesso)

- INSTALAÇÃO DEVKIT 64BITS:
    - Baixar o devkit neste link: http://dl.bintray.com/oneclick/rubyinstaller/DevKit-mingw64-64-4.7.2-20130224-1432-sfx.exe
    - Criar uma pasta "devkit", no diretório C:\Ruby24-x64
    - Na linha de comando, acesse o diretório criado anteriormente;
    - Ainda na linha de comando, digite:
        - ruby dk.rb init
    - O comando irá gerar o arquivo config.yml
    - Abra o arquivo config.yml e verifique se na ultima linha deve conter:
        - C:/Ruby24-x64 (Caso não tenha gerado, digite manualmente)
    - Na linha de comando, digite:
        - ruby dk.rb install
    
- CONFIGURAÇÃO:
    - crie um diretório, no local de sua escolha, com o nome "testeAutomacao";
    - crie um clone do projeto neste diretório que foi criado, digitando:
        - git clone https://github.com/caiosimomura/testeAutomacao.git
    - Abra o visual studio code ou IDE de sua escolha e abra o projeto;
    - Na linha de comando, acesse a pasta "tests", do projeto;
    - Digite o seguinte comando:
        - gem install bundler (instalação do gerenciador de dependencias do Ruby)
        - bundle install (Obter as gems mapeadas no arquivo GemFile)

- UTILIZAÇÃO:
    - Para executar o arquivo .feature criado na pasta "specs", digite:
        - cucumber --tag @compra

