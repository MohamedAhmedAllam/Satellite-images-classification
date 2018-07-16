%Histogram matching function
for cnt1 = 1:p
    I_03_hist = double(imhist(I_03(:,:,cnt1)));
    I_15_hist = double(imhist(I_15(:,:,cnt1)));
    I_03_cs = I_03_hist;
    I_15_cs = I_15_hist;
    L = length(I_03_hist);
    C = (L-1)/(m*n);
    for cnt2 = 1:L-1
       I_03_cs(cn2+1) = I_03_cs(cn2) + I_03_hist;
       I_15_cs(cn2+1) = I_15_cs(cn2) + I_15_hist;
    end
    I_03_match_hist = cum_sum_Idp;
    for cnt3 =  1:L
        for cnt4 = 2:L
            if (I_15_cs(cnt4) >= I_03_cs(cnt3))
                I_03_match_hist(cnt3) = cnt4-1;
                break;
            end    
        end
    end
    for cnt5 = 1:m
        for cnt6 = 1:n
            I_03(cnt5,cnt6,cnt1) = uint8(I_03_match_hist(I_03(cnt5,cnt6,cnt1)+1));
        end
    end
end