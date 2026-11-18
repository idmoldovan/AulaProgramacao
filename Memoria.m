function Memoria(idioma)
% MEMORIA Interface executavel criada por codigo / runnable coded GUI.
% Memoria('pt') ou/or Memoria('en'). O motor e partilhado com App Designer.
if nargin == 0, idioma = 'pt'; end
if strcmpi(idioma,'en')
    titulo = 'Memory game'; novo = 'New game'; pronta = 'Choose two cards.';
    escolhido = 'Choose a second card.'; par = 'Match!'; falha = 'Different cards.';
    fim = 'All pairs found!'; formato = 'Attempts: %d    Pairs: %d / 8';
else
    titulo = 'Jogo da memoria'; novo = 'Novo jogo'; pronta = 'Encontra os oito pares. Escolhe duas cartas.';
    escolhido = 'Escolhe a segunda carta.'; par = 'Encontraste um par!';
    falha = 'Cartas diferentes.'; fim = 'Encontraste todos os pares!';
    formato = 'Tentativas: %d    Pares: %d / 8';
end
jogo = novoJogo();
janela = uifigure('Name',titulo,'Position',[100 100 500 530]);
grelha = uigridlayout(janela,[6 4]);
grelha.RowHeight = {55,'1x','1x','1x','1x',55};
grelha.ColumnWidth = {'1x','1x','1x','1x'};
botaoNovo = uibutton(grelha,'Text',novo,'ButtonPushedFcn',@reiniciar);
botaoNovo.Layout.Row = 1; botaoNovo.Layout.Column = [1 2];
contador = uilabel(grelha,'Text','');
contador.Layout.Row = 1; contador.Layout.Column = [3 4];
mensagem = uilabel(grelha,'Text',pronta,'HorizontalAlignment','center');
mensagem.Layout.Row = 6; mensagem.Layout.Column = [1 4];
cartas = gobjects(4,4);
for linha = 1:4
    for coluna = 1:4
        % A funcao anonima fixa as coordenadas desta carta no callback.
        % The anonymous function captures this card's coordinates.
        cartas(linha,coluna) = uibutton(grelha,'Text','?', ...
            'FontSize',24,'ButtonPushedFcn', ...
            @(origem,evento) escolher(linha,coluna)); %#ok<NASGU,INUSD>
        cartas(linha,coluna).Layout.Row = linha + 1;
        cartas(linha,coluna).Layout.Column = coluna;
    end
end
atualizar();

    function reiniciar(~,~)
        jogo = novoJogo();
        mensagem.Text = pronta;
        atualizar();
    end
    function escolher(linha,coluna)
        primeiraAnterior = jogo.primeira;
        [jogo, resultado] = jogarCarta(jogo,linha,coluna);
        if strcmp(resultado,'invalida'), return, end
        if strcmp(resultado,'primeira')
            mensagem.Text = escolhido;
            atualizar();
            return
        end
        if strcmp(resultado,'par')
            mensagem.Text = par;
            if jogo.pares == 8, mensagem.Text = fim; end
            atualizar();
        else
            % Mostrar ambas durante um instante; bloquear cliques entretanto.
            % Show both briefly; disable clicks while waiting.
            atualizar();
            cartas(primeiraAnterior(1),primeiraAnterior(2)).Text = ...
                num2str(jogo.tabuleiro(primeiraAnterior(1),primeiraAnterior(2)));
            cartas(linha,coluna).Text = num2str(jogo.tabuleiro(linha,coluna));
            mensagem.Text = falha;
            for k = 1:numel(cartas), cartas(k).Enable = 'off'; end
            botaoNovo.Enable = 'off'; drawnow; pause(0.8);
            if ~isvalid(janela), return, end
            for k = 1:numel(cartas), cartas(k).Enable = 'on'; end
            botaoNovo.Enable = 'on'; atualizar();
        end
    end
    function atualizar()
        for r = 1:4
            for c = 1:4
                aberta = jogo.visivel(r,c) || isequal(jogo.primeira,[r c]);
                if aberta
                    cartas(r,c).Text = num2str(jogo.tabuleiro(r,c));
                else
                    cartas(r,c).Text = '?';
                end
            end
        end
        contador.Text = sprintf(formato,jogo.tentativas,jogo.pares);
    end
end
