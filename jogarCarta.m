function [jogo, resultado] = jogarCarta(jogo, linha, coluna)
% JOGARCARTA Aplica uma escolha ao estado; nao desenha a interface.
% Applies one choice to the state; does not draw the interface.
% Resultado: invalida, primeira, par ou diferente.
% Result: invalid, first, match or different.
resultado = 'invalida';
if jogo.pares == 8 || linha < 1 || linha > 4 || coluna < 1 || coluna > 4 ...
        || linha ~= fix(linha) || coluna ~= fix(coluna)
    return
end
if jogo.visivel(linha,coluna) || (~isempty(jogo.primeira) && ...
        isequal(jogo.primeira, [linha coluna]))
    return
end
if isempty(jogo.primeira)
    jogo.primeira = [linha coluna];
    resultado = 'primeira';
    return
end
% A segunda escolha completa uma tentativa / Second choice completes a turn.
jogo.tentativas = jogo.tentativas + 1;
p = jogo.primeira;
if jogo.tabuleiro(p(1),p(2)) == jogo.tabuleiro(linha,coluna)
    jogo.visivel(p(1),p(2)) = true;
    jogo.visivel(linha,coluna) = true;
    jogo.pares = jogo.pares + 1;
    resultado = 'par';
else
    resultado = 'diferente';
end
jogo.primeira = [];
end
