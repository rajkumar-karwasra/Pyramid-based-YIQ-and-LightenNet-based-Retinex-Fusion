function final = LLIE(inputImage)
I = inputImage;

figure;imshow(I);title("Original Image");
enh_I = imlocalbrighten(I);
figure;imshow(enh_I);title(" After LLEH");
I_pyr = pyramiddec(enh_I,2);
figure;imshow(mat2gray(I_pyr{1}));title("Detail By Pyramid")
figure;imshow(I_pyr{2});title("Base By Pymarid");
yiq = (I_pyr{2});
figure;imshow(yiq);title("YIQ");
Y=yiq(:,:,1);
I=yiq(:,:,2);
Q=yiq(:,:,3);
figure;imshow(Y);title("Y");
figure;imshow(mat2gray(I));title("I");
figure;imshow(mat2gray(Q));title("Q");
r = 6;              % radius (controls smoothing)
eps = 0.0001;       % regularization (edge preservation)
enh_Y = guidedFilter(Y, Y, r, eps);
figure, imshow(enh_Y); title("Guided-base");

avg=mean(enh_Y(:));

spatial_gama=power(avg,enh_Y);
I_final=real(power((I),1.65-spatial_gama));
Q_final=real(power((Q),1.65-spatial_gama));

%I_final=imadjust(I,[],[],1.1);
%Q_final=imadjust(Q,[],[],1.1);
figure,imshow(I_final);title("I final");
figure,imshow(Q_final);title("Q final");
YIQ_enh = cat(3,enh_Y,I_final,Q_final);
enh_base =(YIQ_enh);
figure;imshow(enh_base);title("Enh base")
enh_detail =imbilatfilt(I_pyr{1});
figure;imshow(mat2gray(enh_detail));title("Enh Detail")
enh_pyr = {enh_detail,enh_base};
final = pyramidrec(enh_pyr);
figure;imshow(final);
end