clc;	% Limpa janela de comando.
clear;	% Deleta todas as variáveis.
close all;	% Fecha todas as figuras abertas.
workspace;	% Garante que o painel do workspace está aberto.

% fullImageFileName = 'peppers.png';
% fullImageFileName = 'onion.png';
% fullImageFileName = 'rgb-colors.jpg';
% fullImageFileName = 'img_testes/img1.jpg';
% fullImageFileName = 'img_testes/img2.jpg';
% fullImageFileName = 'img_testes/img3.png';
% fullImageFileName = 'img_testes/img4.jpg';
% fullImageFileName = 'img_testes/img5.jpg';
fullImageFileName = 'img_testes/img6.jpg';
% fullImageFileName = 'img_testes/img7.jpg';
    
% Carrega a imgem em um array
[rgbImage, storedColorMap] = imread(fullImageFileName); 
[rows, columns, numberOfColorBands] = size(rgbImage); 

%Copia a imagem para usar como resultado final
fuzzyImage = rgbImage;

% Extriando R, G e B separadamente
rImage = rgbImage(:,:,1);
gImage = rgbImage(:,:,2);
bImage = rgbImage(:,:,3);

% Mascaras para as outras cores usando banda vermelha só para ter o mesmo
% padrao de imagem, pois toda a matriz será subistituida depois
maImage = rgbImage(:,:,1);
amImage = rgbImage(:,:,1);
ciImage = rgbImage(:,:,1);
brImage = rgbImage(:,:,1);
prImage = rgbImage(:,:,1);

% Lendo o modelo fuzzy criado no toolbox

% fis = readfis('fuzzy_cor3');
fis = readfis('fuzzy_cor4');

for i = 1:rows
    for j = 1:columns
        % Passando os valores de R, G e B de cada pixel para a máquina
        % de inferência Fuzzy
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
        
        if valor > 3 && valor <= 4
            maImage(i,j) = 1;
        else
            maImage(i,j) = 0;    
        end
        
        if valor > 4 && valor <= 5
            amImage(i,j) = 1;
        else
            amImage(i,j) = 0;    
        end
        
        if valor > 5 && valor <= 6
            ciImage(i,j) = 1;
        else
            ciImage(i,j) = 0;    
        end
        
        if valor > 6 && valor <= 7
            brImage(i,j) = 1;
        else
            brImage(i,j) = 0;    
        end
        
        if valor > 7 && valor <= 8
            prImage(i,j) = 1;
        else
            prImage(i,j) = 0;    
        end
    end
end

figure
subplot(4,3,2), imshow(rgbImage), title('Original');
subplot(4,3,4), imshow(rgbImage.*repmat(rImage,[1,1,3])), title('Vermelho');
subplot(4,3,5), imshow(rgbImage.*repmat(gImage,[1,1,3])), title('Verde');
subplot(4,3,6), imshow(rgbImage.*repmat(bImage,[1,1,3])), title('Azul');
subplot(4,3,7), imshow(rgbImage.*repmat(maImage,[1,1,3])), title('Magenta');
subplot(4,3,8), imshow(rgbImage.*repmat(amImage,[1,1,3])), title('Amarelo');
subplot(4,3,9), imshow(rgbImage.*repmat(ciImage,[1,1,3])), title('Ciano');
subplot(4,3,10), imshow(rgbImage.*repmat(brImage,[1,1,3])), title('Branco');
subplot(4,3,11), imshow(rgbImage.*repmat(prImage,[1,1,3])), title('Preto');