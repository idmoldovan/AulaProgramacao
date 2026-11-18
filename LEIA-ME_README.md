# Jogo da memória / Memory game

## Executar / Run

No MATLAB, coloque a pasta `JogoMemoria` como Current Folder e execute `Memoria('pt')` ou `Memoria('en')`. As 16 cartas escondem oito pares. Escolha duas cartas: um par permanece visível; cartas diferentes voltam a esconder-se. Cada segunda escolha válida conta uma tentativa. Encontre os oito pares. `Novo jogo` inicia outra partida.

In MATLAB, set `JogoMemoria` as the Current Folder and run `Memoria('pt')` or `Memoria('en')`. The 16 cards hide eight pairs. Choose two cards: a match remains visible; different cards are hidden again. Each valid second choice counts as one attempt. Find all eight pairs. `New game` starts again.

`Memoria.m` creates a working GUI in MATLAB code. It is not an App Designer `.mlapp` file. `novoJogo.m` and `jogarCarta.m` are the same engine to use in the App Designer design below.

## App Designer: desenho para construir / design to build

1. Execute `appdesigner`, escolha **Blank App** e guarde como `MemoriaApp.mlapp` na mesma pasta. / Run `appdesigner`, choose **Blank App**, save as `MemoriaApp.mlapp` in the same folder.
2. Em Design View crie 16 Button numa grelha 4×4, um Button de reinício, dois Label para contador e mensagem. Nomeie os componentes `Carta11`…`Carta44`, `NovoButton`, `ContadorLabel`, `MensagemLabel`. / In Design View add 16 Buttons in a 4×4 grid, a reset Button and two Labels. Name the components as shown.
3. Em Code View adicione uma propriedade privada `Jogo` e uma propriedade privada `Cartas`. Crie `startupFcn`: `app.Cartas = [app.Carta11 app.Carta12 app.Carta13 app.Carta14; app.Carta21 app.Carta22 app.Carta23 app.Carta24; app.Carta31 app.Carta32 app.Carta33 app.Carta34; app.Carta41 app.Carta42 app.Carta43 app.Carta44]; app.Jogo = novoJogo();` / Add private properties `Jogo` and `Cartas`; create `startupFcn` with the preceding assignments.
4. Associe cada carta a um callback `ButtonPushedFcn`. Num callback partilhado pode encontrar a posição com `[linha,coluna] = find(app.Cartas == event.Source);`. Guarde `anterior = app.Jogo.primeira;`, execute `[app.Jogo, resultado] = jogarCarta(app.Jogo,linha,coluna);` e atualize os textos. Para cartas diferentes, mostre também `anterior` e a carta escolhida durante 0,8 s, desative os botões durante a pausa, volte a ocultá-las e reative-os. / Assign each card a `ButtonPushedFcn`. In a shared callback find its position as shown, save the first position before calling the engine, then redraw. For a mismatch briefly show both, disable buttons during the 0.8 s pause, hide them and re-enable them.
5. `NovoButton` chama `novoJogo` e redesenha. Para desenhar cada carta, mostre o número se `app.Jogo.visivel(r,c)` ou `isequal(app.Jogo.primeira,[r c])`; caso contrário mostre `?`. Atualize o contador com `sprintf`. Consulte `Memoria.m` para a implementação completa da lógica de interface. / Reset calls `novoJogo` and redraws. Show the value for a matched or first selected card, otherwise `?`; update the count with `sprintf`. See `Memoria.m` for the complete interface logic.

O desenho acima é uma especificação para criar um `.mlapp`, não um ficheiro `.mlapp` já gerado. / This is a specification for creating an `.mlapp`, not a generated `.mlapp` file.

## Ficheiros / Files

- `novoJogo.m`: cria a estrutura e as matrizes / creates the struct and matrices.
- `jogarCarta.m`: recebe estado e coordenadas, devolve estado e resultado / accepts state and coordinates, returns state and result.
- `Memoria.m`: interface executável e callbacks / runnable interface and callbacks.
- `testarJogo.m`: testes determinísticos do motor / deterministic engine tests.
