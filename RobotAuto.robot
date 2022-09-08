*** Settings ***
Documentation    Automação de testes RobotFramework de exemplo utilizando cálculadora e bloco de notas com as libraries do Sikuli, Faker e ImageHorizonLibrary 
Library         SikuliLibrary        mode=NEW
Library         FakerLibrary    locale=pt_BR
Library         ImageHorizonLibrary
Library         String
Suite Setup     Run Keywords   Start Sikuli Process    AND    Ler imagens iniciais       
Suite Teardown     Stop Remote Server


*** Variables ***
${IMAGE}         ${CURDIR}${/}img
${CALCULATOR}    "C:/Windows/System32/calc.exe"
${NOTEPAD}        "C:/Windows/System32/notepad.exe"


*** Test Cases ***
Cenário 01: Operações na Calculadora
    Dado estou no desktop do Windows
    E abro o aplicativo da cálculadora
    Quando realizo operações matemáticas
    Então finalizo o aplicativo

Cenário 02: Textos no bloco de notas
   Dado estou no desktop do Windows
   E abro o bloco de notas
   Quando realizo edições de textos
   Então finalizo o aplicativo

*** Keywords ***
Ler imagens iniciais
   Add Image Path    ${IMAGE}

Dado estou no desktop do Windows
   Set Library Search Order    SikuliLibrary
   Press Combination    KEY.WIN     Key.D    #atalho área de trabalho

E abro o aplicativo da cálculadora
   Set Library Search Order    SikuliLibrary
   Open Application    ${CALCULATOR}
   Click    btn_maxBlack.png
   Wait Until Screen Contain    calc.png    5

Quando realizo operações matemáticas
   ${NUMERO1}   Random Number     digits=1
   ${NUMERO2}   Random Number     digits=2
   Input Text    ${EMPTY}    ${NUMERO1}
   Input Text    ${EMPTY}    +
   Input Text    ${EMPTY}    ${NUMERO2}
   Input Text    ${EMPTY}    =
   Input Text    ${EMPTY}    ${NUMERO1}
   Input Text    ${EMPTY}    -
   Input Text    ${EMPTY}    ${NUMERO2}
   Input Text    ${EMPTY}    =
   Input Text    ${EMPTY}    ${NUMERO1}
   Input Text    ${EMPTY}    *
   Input Text    ${EMPTY}    ${NUMERO2}
   Input Text    ${EMPTY}    =
   Input Text    ${EMPTY}    ${NUMERO1}
   Input Text    ${EMPTY}    /
   Input Text    ${EMPTY}    ${NUMERO2}
   Input Text    ${EMPTY}    =
   Sleep    1
   Capture Screen
   
Então finalizo o aplicativo
   Set Library Search Order    SikuliLibrary
   Press Combination    KEY.ALT     Key.F4 
   #Click    btn_fechar.png

E abro o bloco de notas
   Set Library Search Order    SikuliLibrary
   Open Application    ${NOTEPAD}
   Click    btn_maxBlue.png
   #Wait Until Screen Contain    notepad.png     5

Quando realizo edições de textos
   Set Library Search Order    SikuliLibrary
   ${NOME}      FakerLibrary.name
   ${CPF}       FakerLibrary.CPF
   ${CNPJ}      FakerLibrary.CNPJ   
   ${RUA}       Street Name    
   ${BAIRRO}    FakerLibrary.bairro 
   ${TEL}       Phone Number   
   ${EMAIL}     Safe Email
   ${PLACA}     License Plate
   ${COR}       Safe Color Name
   ${FRASE}     Catch Phrase
   ${JOB}       Job
   Press Combination    KEY.ALT     Key.F
   Press Special Key    DOWN
   Press Special Key    ENTER
   FOR    ${I}    IN RANGE    2
       Press Special Key    TAB
   END
   FOR    ${I}    IN RANGE    5
       Press Special Key    DOWN
   END
   Press Special Key    ENTER
   Press Special Key    TAB
   Input Text     ${EMPTY}    GERANDO DADOS
   Press Special Key    ENTER
   ${NOME_PURO}        FakerLibrary.name
   ${NOME}=       Replace String       ${NOME_PURO}       á       ${EMPTY}    count=+1
   ${NOME}=       Replace String       ${NOME_PURO}       á       ${EMPTY}    count=+1
   ${NOME}=       Replace String       ${NOME_PURO}       ú       ${EMPTY}    count=+1
   ${NOME}=       Replace String       ${NOME_PURO}       ã       ${EMPTY}    count=+1
   ${RUA_PURO}       Street Name   
   ${RUA}=       Replace String       ${RUA_PURO}       á       ${EMPTY}    count=+1
   ${RUA}=       Replace String       ${RUA_PURO}       Á       ${EMPTY}    count=+1
   Paste Text    ${EMPTY}    Nome: ${NOME} CPF: ${CPF} CPNJ: ${CNPJ} 
   Press Special Key    ENTER
   Paste Text    ${EMPTY}    Rua: ${RUA} BAIRRO: ${BAIRRO} Telefone: ${TEL}
   Press Special Key    ENTER
   Paste Text    ${EMPTY}    Email: ${EMAIL} Placa: ${PLACA} Cor: ${COR}
   Press Special Key    ENTER
   Paste Text    ${EMPTY}    Trabalho: ${JOB} Uma frase: ${FRASE}
   Capture Screen



