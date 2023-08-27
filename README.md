# BIN-HEX-DEC-Calculadora-Assembly
Calculadora em assembly que realiza operações de AND, OR, XOR, NOT, Soma, Subtração, Multiplicação, Divisão,  Multiplicação sucessiva por 2 (Shift Left), Divisão sucessiva por 2 (Shift Right). É possivel realizar as operações com números Binários, Decimais e Hexadecimais.

Junto com o código você encontra um arquivo TASM e outro TLINK.

O TASM (Turbo Assembler) e o TLINK são ferramentas de desenvolvimento que eram amplamente utilizadas no ambiente MS-DOS para programação em linguagem Assembly e para a criação de executáveis a partir do código fonte. Essas ferramentas eram parte do ambiente de desenvolvimento Turbo Assembler e Turbo Linker da Borland.

1. **TASM (Turbo Assembler)**:
   O TASM é um montador (assembler) que traduz código Assembly em linguagem de máquina. Ele pega seu código Assembly, que é uma representação legível por humanos das instruções da arquitetura de processador, e o converte em código de máquina, que é o que o processador realmente executa.

   O TASM é usado para transformar o código Assembly em um arquivo de objeto, que contém o código de máquina gerado e informações sobre símbolos e endereços. Esse arquivo de objeto é então usado pelo linker para criar o executável final.

2. **TLINK (Turbo Linker)**:
   O TLINK é um linker que combina os arquivos de objeto gerados pelo TASM em um único arquivo executável. Além disso, o TLINK lida com a resolução de referências cruzadas entre diferentes partes do código e alocando endereços de memória para as instruções e dados no programa.


## Execução

Para executar código assembly do Intel 8086, que é uma arquitetura de processador antiga, você geralmente precisa de um ambiente de emulação ou simulação, já que os sistemas modernos não são compatíveis com essa arquitetura diretamente. Existem várias opções que você pode considerar, mas no meu caso usei o DosBox que é um emulador que permite executar programas DOS, incluindo código assembly para o Intel 8086. Ele emula um ambiente DOS completo, incluindo o processador e o sistema de arquivos.

1. Com o DosBox aberto, rode o seguinte comando. Obs: Local é o diretório onde se encontra o código, tasm e tlink.
   ```
   mount C <Local>
   ```
2. Montado o local, caminhe até ele colocando o diretório na linha de comando. Exemplo: C:\Projeto\Calculadora

3. Use o TASM para montar o código Assembly em um arquivo de objeto com extensão `.OBJ`.
   ```
   TASM seu_programa.asm
   ```
3. Use o TLINK para criar o executável a partir do arquivo de objeto.
   ```
   TLINK seu_programa.obj
   ```
4. Agora você pode executar o executável resultante com o DOSBox.
   ```
   seu_programa.exe
   ```

Essas ferramentas eram amplamente usadas no passado para desenvolver programas para o MS-DOS e plataformas compatíveis com o Intel 8086. Lembre-se de que essas informações se aplicam ao ambiente de desenvolvimento do MS-DOS e que as práticas modernas de programação podem ser diferentes.
