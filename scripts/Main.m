clear all
close all
clc
	
sel_folder=pwd;								% identify current folder 
 
file_patt=fullfile(sel_folder,'*.tif'); 	% look for .tif files 
files=dir(file_patt);
 
num_files=length(files);                % number of .tif files 
 
stride=10;		% select stride
w=128;			% select window size
 
for n=1:num_files
     
    N=double(uint16(imread(files(n).name)));                % Load input noisy image

    Nd=gab_median_fn(N);
% 	  imwrite(mat2gray(Nd),strcat(files(n).name(1:end-4),'_median_filtered.tif')); 

    I_PID=PID_fn(Nd,25,40,files(n).name);
	
    [I_sharp,K_glob]=deblur_fn(double(uint16(I_PID)),mat2gray(double(uint16(Nd))),30,files(n).name);

    figure, imshowpair(I_PID,I_sharp,'montage')

%     imwrite(mat2gray(Isharp),strcat(files(n).name(1:end-4),'_sharp.tif'));
%     imwrite(mat2gray(K_glob),[files(n).name(1:end-4),'_global_kernel.tif']);

	[I_sharp_local,K_loc]=stride_fn(I_PID,Nd,stride,w)

	figure, imshowpair(I_sharp,I_sharp_local,'montage')
%	  imwrite(mat2gray(I_sharp_local),'Sharp_loc.tif');

end