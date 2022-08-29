clc;
clear all;
close all;
I=imread('ff.jpg');
Igray=rgb2gray(I);
I_resized= imresize(Igray,[512 512],'bicubic');
I_croped=I_resized(206:305,206:305); %Cropping
I_sum(:,1) = I_croped(:,1);   
I_merge=I_croped;
[r1,c1]=size(I_resized);

m='Shazia Iqbal';
s=size(m);
len=length(m)*8;
ascii_values = double(m);
ascii2binary=dec2bin(ascii_values,8);
%Append all binary equivalents of ascii values into one string 
binary_sequence=''; 
for i=1:length(m)
     binary_sequence=strcat(binary_sequence, ascii2binary(i,:));
end
Encrypt_message=binary_sequence;
% row=randperm(255,100);
% col=randperm(255,100);
for i=1:100
    for j=1:99
        I_diff(i,j)=abs(I_croped(i,j)- I_croped(i,j+1));
        I_check(i,j)=I_diff(i,j);
        All_bits= dec2bin(double(I_diff(i,j)),8)
        if j <= len/4;
        All_bits(1:4)=binary_sequence((j-1)*4+1:j*4);
        end
        pixel=bin2dec(All_bits);
        I_diff(i,j)=uint8(pixel);
        I_sum(i,j+1)=I_croped(i,j)-I_diff(i,j);
    end 
end
figure;
subplot(121)
imshow(I_croped);
title('Plane Image')
subplot(122)
imshow(I_sum);
title('Encrypted Image')

I_out=I_resized;
I_out(206:305,206:305)=I_sum;
figure;
subplot(121);
imshow(I_resized);
title('Input Image')
subplot(122);
imshow(I_out);
title('Output Image')
imwrite(I_out,'Encrypted Image.png')



