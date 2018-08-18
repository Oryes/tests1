tic
clear all
clc
close all

% 1. path=uigetdir; % choose the foleder with the images and program
path='/Users/ilsuleym/Documents/Sushil/quantification/*.%s';

% 2. change file format
FileFormat='tif';

% 3. manually operated input

unit=8;

k=3; % number of chanel 1-red, 2-reen, 3-blue
% trash22=140;
% trash21=12;
contrast2=2^unit-1;
tresholdOfPositiveArea=120;%contrast2;
const=2.0926e+05;

% Find images in the folder
list = dir(sprintf(path,FileFormat));

% Program body - counts intensity of positive staining
ik=1;
for ik=1:length(list)
    
    % Read an image
    IpS = imread(list(ik).name);
    
    % Convert an original image to gray scale
    I=rgb2gray(IpS(:,:,1:3));
    figure, imshow(IpS(:,:,1:3),'DisplayRange',[])
%     title(['Original image: ', list(index).name],'FontSize',12)
%           impixelregion
%       break
    
%     [rw2,cw2]=find(IpS(:,:,1)<160 & IpS(:,:,3)<155);
%     for i=1:length(rw2)
%         I(rw2(i),cw2(i))=contrast2;
%     end
    
    % Area of positive staining
    [rw3,cw3]=find(IpS(:,:,2)<100 & IpS(:,:,3)>190 | IpS(:,:,2)<10 & IpS(:,:,3)>150); %!!
    aa3=zeros(size(I,1),size(I,2));
    for i=1:length(rw3)
        aa3(rw3(i),cw3(i))=contrast2;
        OpticalDensity(i)=I(rw3(i),cw3(i));
    end
    figure, imshow(aa3)
    title(['+ staining: ', list(ik).name],'FontSize',12)
    
    % End results
    intensity(ik)=length(rw3)/(10*(255-mean(OpticalDensity))); %contrast2-sum(OpticalDensity)/const;
    sizeIn(ik)=length(rw3)-500;
    
    ik=ik+1;
    clear aa2 rw cw rw2 cw2 aa3 rw3 cw3 lengthboundaries2
end
% intensity=intensity';

filename = 'S';
% xlswrite('testdata.xlsx',intensity',2)

time=toc
