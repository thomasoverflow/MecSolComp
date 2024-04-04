% vetor contendo a rigidez de cada mola
k_n = [100;                % rigidez da mola 1 (N/mm)
       105;                % rigidez da mola 2 (N/mm)
       137;                % rigidez da mola 3 (N/mm)
       97;		   % rigidez da mola 4 (N/mm)
       106;		   % rigidez da mola 5 (N/mm)
       117;		   % rigidez da mola 6 (N/mm)
       115;		   % rigidez da mola 7 (N/mm)
       134;		   % rigidez da mola 8 (N/mm)
       92;		   % rigidez da mola 9 (N/mm)
       88];		   % rigidez da mola 10 (N/mm)
       
% cálculo do número de linhas do vetor k_n
e_total = rows(k_n);      % número total de elementos

% matriz de conectividade (graus de liberdade u_n)
dof_e = [1 2;   % elemento 1 conecta dof1 (u_1) e dof2 (u_2)
         2 3;   % elemento 2 conecta dof2 (u_2) e dof3 (u_3)
         2 3;
         3 4;
         4 5;
         5 6;
         1 3;
         2 4;
         3 5;
         1 5;
         4 6];
         
% criar matriz quadrada nula
K = zeros(6,6);           % total de dof do problema: 5

for e = 1:e_total         % loop para cada elemento
  k = k_n(e);             % rigidez do elemento (escalar)
  K_e = k*[1 -1;-1 1];    % matriz de rigidez do elemento
  % contribuição do elemento na matriz de rigidez global
  K(dof_e(e,:),dof_e(e,:)) = K(dof_e(e,:),dof_e(e,:)) + K_e;
end

display("matriz de rigidez global:"); K

% Aplicação de condições de contorno
P = 1e8;                  % fator de penalização
K(1,1) = K(1,1)*P;        % penalização aplicada no termo 1,1 de K


% Aplicação dos carregamentos
f = zeros(6,1);           % vetor com 3 linhas e 1 coluna
f(1) = 0;
f(2) = -64;
f(3) = 0;
f(4) = 0;
f(5) = 62;
f(6) = 96

display("vetor de carregamentos:"); f

% Solução do sistema de equações
u = (K^-1)*f;             % resultado de deslocamentos nodais
display("vetor de deslocamentos nodais:"); u

