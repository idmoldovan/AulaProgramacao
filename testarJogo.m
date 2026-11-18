% Testes determinísticos do motor / Deterministic engine tests
j = novoJogo();
assert(isequal(size(j.tabuleiro),[4 4]));
assert(isequal(sort(j.tabuleiro(:))',repelem(1:8,2)));
j.tabuleiro = reshape(repelem(1:8,2),4,4);
[j,r] = jogarCarta(j,1,1); assert(strcmp(r,'primeira'));
[j,r] = jogarCarta(j,1,1); assert(strcmp(r,'invalida') && j.tentativas==0);
[j,r] = jogarCarta(j,2,1); assert(strcmp(r,'par') && j.pares==1 && j.tentativas==1);
[j,r] = jogarCarta(j,1,1); assert(strcmp(r,'invalida'));
[j,r] = jogarCarta(j,3,1); assert(strcmp(r,'primeira'));
[j,r] = jogarCarta(j,1,2); assert(strcmp(r,'diferente') && j.tentativas==2);
assert(isempty(j.primeira) && ~j.visivel(3,1) && ~j.visivel(1,2));
[j,r] = jogarCarta(j,0,1); assert(strcmp(r,'invalida'));
disp('Testes do motor aprovados / Engine tests passed');
