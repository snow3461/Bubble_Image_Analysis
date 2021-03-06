function bw=adaptivethreshold(IM,ws,tm)
%ADAPTIVETHRESHOLD An adaptive thresholding algorithm that seperates the
%foreground from the background with nonuniform illumination.
%  bw=adaptivethreshold(IM,ws,C) outputs a binary image bw with the local 
%   threshold mean-C or median-C to the image IM.
%  ws is the local window size.
%  tm is 0 or 1, a switch between mean and median. tm=0 mean(default); tm=1 median.
%
%  Contributed by Guanglei Xiong (xgl99@mails.tsinghua.edu.cn)
%  at Tsinghua University, Beijing, China.
%
%  For more information, please see
%  http://homepages.inf.ed.ac.uk/rbf/HIPR2/adpthrsh.htm

if (nargin<2)
    error('You must provide the image IM, and the window size ws');
elseif (nargin==2)
    tm=0;
elseif (tm~=0 && tm~=1)
    error('tm must be 0 or 1.');
end

IM=mat2gray(IM);

if tm==0
    mIM=imfilter(IM,fspecial('average',ws),'replicate');
else
    mIM=medfilt2(IM,[ws ws]);%carefull with windows size otherwise, stuck matlab
end
sIM=mIM-IM;
thresh=graythresh(sIM);
bw=im2bw(sIM,thresh);
bw=imcomplement(bw);

%% other possible implementation
% im = rgb2gray(im);
% im = im2double(im);
% f_makebw = @(I) im2bw(I.data, double(median(I.data(:)))/1.45);
% bw = ~blockproc(im, [128 128], f_makebw);