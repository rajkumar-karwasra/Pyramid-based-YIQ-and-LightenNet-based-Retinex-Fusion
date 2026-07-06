function imgDec = pyramiddec(imgSrc, level)
% pyramiddec 对图像进行拉普拉斯金字塔分解 (支持RGB)
%   imgDec = pyramiddec(imgSrc, level)
%       返回值
%           imgDec: 分解得到的拉普拉斯金字塔 (RGB格式)
%       参数
%           imgSrc: 被分解的图像
%           level: 金字塔的分解层数

[imgHeight, imgWidth, imgThickness] = size(imgSrc);

% 检查函数参数是否合法
if(log2(imgHeight) ~= floor(log2(imgHeight)) || log2(imgWidth) ~= floor(log2(imgWidth)))
    error('图像大小必须是2的幂。');
end

dimMin = min([imgHeight, imgWidth]);
maxLevel = log2(dimMin);
if(level > maxLevel)
    error('超出了金字塔最大分解层数。');
end

% 确保图像是 double 格式
imgSrc = im2double(imgSrc);

% 拉普拉斯金字塔分解
imgReduce = cell(level, 1);
imgDec = cell(level, 1);
imgReduce{1} = imgSrc;

for iLevel = 2:level
    % Preallocate with correct size using pyramidreduce
    reduced = [];
    expanded = [];
    
    for c = 1:imgThickness
        reduced(:,:,c) = pyramidreduce(imgReduce{iLevel-1}(:,:,c));
        expanded(:,:,c) = pyramidexpand(reduced(:,:,c));
    end
    
    imgReduce{iLevel} = reduced;
    imgDec{iLevel-1} = imgReduce{iLevel-1} - expanded; % RGB Laplacian
end


imgDec{iLevel} = imgReduce{iLevel}; % 最底层

end

