function final = CNN(inputImage)
addpath(genpath('.'));
r=1.7;
%% read image
im=inputImage;
figure,imshow(im),title('input');
IM=im2double(im);
[height,width,channel]=size(IM);

IMM = imlocalbrighten(IM)

figure,imshow(IMM);

LB=IMM;
%% deep enhancement
model= 'lowlight4layersfinal.mat';
im_b=LB;
load(model);
%% conv1
f1=convolution(im_b, weights_conv1, biases_conv1);
%% conv2
f2=convolution(f1, weights_conv2, biases_conv2);
%% conv3
f3=convolution(f2, weights_conv3, biases_conv3);
%% conv4
f4=convolution1(f3, weights_conv4, biases_conv4);
figure,imshow(f4);title("f4");
map=f4.^r;% gammar correction, ajust the brightness by paramter r 
figure,imshow(map);title("map1");

%% %% guided filtering
p = map;
batch_size = 33;
eps = 10^-3; 
map = guidedfilter(IM(:,:,1), p, batch_size, eps); 
figure,imshow(map);title("Guided Filter");

%% Retinex model
new(:,:,1)=LB(:,:,1)./(map);
new(:,:,2)=LB(:,:,2)./(map);
new(:,:,3)=LB(:,:,3)./(map);
figure,imshow(abs(new),[]),title('enhanced');
final=abs(new);
figure,imshow(final);
end