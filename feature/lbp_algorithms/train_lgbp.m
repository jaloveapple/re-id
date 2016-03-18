
trainWeights = [];

scale = str2num(vfpParamSplit{1});
orientation = str2num(vfpParamSplit{2});


trainCount = 1;
index = 0;
trainlength = size(vfpTrainImgs,2);
limit = 50;
for trainsamples=0:trainlength-1
    index = mod(trainsamples, limit)+1;
    train_imgs=reshape(vfpTrainImgs(:,trainsamples+1),size_y,size_x)';  
    hist = LGBP(train_imgs, scale, orientation, region_y, region_x);
    trainWeights(:,index)=hist;
    if index == limit
        save([vfpTempTrainWeights num2str(trainCount) '.mat'], 'trainWeights');
        trainCount = trainCount+1;
        if trainsamples ==  trainlength-1
            modeSize = length(trainWeights(:,1)) * 8;           
        end
        trainWeights = [];
    end
end
% 最后一个.mat：如果index不等于200，那么最后还差一个mat没有存。
if index>0 && index ~= limit
    save([vfpTempTrainWeights num2str(trainCount) '.mat'], 'trainWeights');
    modeSize = length(trainWeights(:,1)) * 8;
end
clear trainWeights;

% 原来的train_lgbp代码
% for trainsamples=1:size(vfpTrainImgs,2)
%     train_imgs=reshape(vfpTrainImgs(:,trainsamples),size_y,size_x)';       
%     hist = LGBP(train_imgs, scale, orientation);
%     trainWeights(:,trainsamples)=hist;
% end
% 
% vfpTrainMem = trainWeights;
