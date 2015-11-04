function segmentedCellSequence = batchProcessFiles(fileNames,fcn)
%batchProcessFiles Process image files.
%   SEQUENCE = batchProcessFiles(FILENAMES,FCN) loops over all the files
%   listed in FILENAMES, calls the function FCN on each of them, and combines
%   the results in SEQUENCE. FCN is a function handle for a function with
%   signature: B = FCN(A).
%
%   Supports batch processing example, BatchProcessImageExample.

%   Copyright 2007-2013 The MathWorks, Inc.

I = imread(fileNames{1});

[mrows,ncols] = size(I);
nImages = length(fileNames);

segmentedCellSequence = zeros(mrows,ncols,nImages,class(I));

parfor (k = 1:nImages)    

    I = imread(fileNames{k});
    segmentedCellSequence(:,:,k) = fcn(I);     %#ok<PFBNS> % 'fcn' is not an array but a function handle. The Code Analyzer warning is not relevant here.  
    
end
