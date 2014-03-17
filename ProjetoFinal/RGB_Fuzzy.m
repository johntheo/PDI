clc;	% Limpa janela de comando.
clear;	% Deleta todas as vari�veis.
close all;	% Fecha todas as figuras abertas.
workspace;	% Garante que o painel do workspace est� aberto.

%fullImageFileName = 'peppers.png';
fullImageFileName = 'onion.png';
    
% Carrega a imgem em um array
[rgbImage, storedColorMap] = imread(fullImageFileName); 
[rows, columns, numberOfColorBands] = size(rgbImage); 

%Copia a imagem para usar como resultado final
fuzzyImage = rgbImage;

% Extriando R, G e B separadamente
rImage = rgbImage(:,:,1);
gImage = rgbImage(:,:,2);
bImage = rgbImage(:,:,3);

% Lendo o modelo fuzzy criado no toolbox

fis = readfis('fuzzy_cor4');

for i = 1:rows
    for j = 1:columns
        % Passando os valores de R, G e B de cada pixel para a m�quina
        % de infer�ncia Fuzzy
        v1 = double(rImage(i,j)); 
        v2 = double(gImage(i,j)); 
        v3 = double(bImage(i,j));
        valor = evalfis([v1 v2 v3],fis);
        
        if valor >= 0 && valor <= 1
            rImage(i,j) = 1;
        else
            rImage(i,j) = 0;
        end
        
        if valor > 1 && valor <= 2
            gImage(i,j) = 1;
        else
            gImage(i,j) = 0;
        end
        
        if valor > 2 && valor <= 3
            bImage(i,j) = 1;
        else
            bImage(i,j) = 0;    
        end
    end
end

figure
subplot(1,4,1), imshow(rgbImage), title('Original');
subplot(1,4,2), imshow(rgbImage.*repmat(rImage,[1,1,3])), title('Vermelho');
subplot(1,4,3), imshow(rgbImage.*repmat(gImage,[1,1,3])), title('Verde');
subplot(1,4,4), imshow(rgbImage.*repmat(bImage,[1,1,3])), title('Azul');