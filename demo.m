

clear;
clc;

% Embed the robust watermark information into one image
!clrw_embed.exe 31 18 1000 .\watermark\watermark.txt .\standard_test_images\lena.bmp

% Extract the robust watermark information and recover the original image
!clrw_extract_and_recover.exe .\watermark\extracted_watermark.txt .\watermarked_images\embedded_lena.bmp

% Rotate the watermarked image
Iw2 = imread(['watermarked_images/embedded_','lena.bmp']);
Iw2 = imrotate(Iw2, 30, 'crop');
imwrite(Iw2, ['attacked_images/attacked_','lena.bmp'])

% Extract the robust watermark information after the watermarked image was attacked
!clrw_extract_after_attack 31 18 1000 128 .\watermark\extracted_watermark.txt .\attacked_images\attacked_lena.bmp

% read the original image
img_name='lena.bmp';
img = imread(['standard_test_images/',img_name]);

% read the final watermarked image
Iw2 = imread(['watermarked_images/embedded_',img_name]);
% read the recovered image
recovered_img = imread(['recovered_images/recovered_',img_name]);

watermark = load('./watermark/watermark.txt'); 
extracted_watermark = load('./watermark/extracted_watermark.txt'); 


psnr1 = psnr(uint8(img), uint8(Iw2));
psnr2 = psnr(uint8(img), uint8(recovered_img));


fprintf('The extracted error:\t\t\t\t\t%d\n',sum(sum(abs(watermark - extracted_watermark))));
fprintf('PSNR of the final watermarked image:\t%4.1f dB\n',psnr1);
fprintf('PSNR of the recovered image:\t\t\t%f\n',psnr2);










