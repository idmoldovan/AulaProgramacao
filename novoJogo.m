function jogo = novoJogo()
% NOVOJOGO Cria o estado de um jogo de memoria de 4 por 4.
% NEWGAME Creates the state of a 4 by 4 memory game.
% Cada numero aparece duas vezes; randperm baralha as 16 posicoes.
% Each number occurs twice; randperm shuffles the 16 positions.
valores = repmat(1:8, 1, 2);
jogo.tabuleiro = reshape(valores(randperm(16)), 4, 4);
jogo.visivel = false(4, 4); % Pares ja encontrados / matched pairs
jogo.primeira = [];         % [linha coluna] da primeira carta / first card
jogo.tentativas = 0;
jogo.pares = 0;
end
