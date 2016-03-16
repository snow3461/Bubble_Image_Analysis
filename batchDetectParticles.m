function data = batchDetectParticles(fileNames,fcn)
%batchProcessFiles Process image files.
%   SEQUENCE = batchProcessFiles(FILENAMES,FCN) loops over all the files
%   listed in FILENAMES, calls the function FCN on each of them, and combines
%   the results in SEQUENCE. FCN is a function handle for a function with
%   signature: B = FCN(A).
%
%   Supports batch processing example, BatchProcessImageExample.

%   Copyright 2007-2013 The MathWorks, Inc.
nImages=length(fileNames)
data={};
parfor (k = 1:nImages)    

   data{k} = fcn(fileNames{k});     %#ok<PFBNS> % 'fcn' is not an array but a function handle. The Code Analyzer warning is not relevant here.  

end
