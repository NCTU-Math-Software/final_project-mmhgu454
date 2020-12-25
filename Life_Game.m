function Life_Game()
% 程式用途：模擬康威生命遊戲的運作模式
% 程式input:N、which、可能有k(這些是做什麼的在程式內有解釋)
% 程式output:生命遊戲的figure
%
    N=input('畫面範圍要多大(NxN？(建議在10~100之間，比較舒服)\n');
    which=input('希望隨機生成(下一步設定生成數)還是手動選取？(若N太大建議隨機生成)\n...
                    隨機生成輸入 1 ，手動選取輸入 2 ');
    chessboard=255*ones(N,N,3);                                         %
    checkM=zeros(N,N);                                                  % 最後判斷下一個階段的各位置細胞存活與否
    if which==1                                                         % 0為不變，-1則變死亡，1則是復活
        k=input(['要生成幾個點？(推薦範圍在' ...
            num2str((1/4)*N^2) '~' num2str((1/2)*N^2) '之間)\n']);    
        if k>=N^2;                                                      % 沒什麼用的防呆
            disp('出事了阿伯，再重來一次ㄅ')
            return
        end
        lives(k,N);                                                     % 隨機生成case的生成函數
        image(chessboard);pause(2);                                     % 把初始圖print出來並暫停兩秒看清楚
    elseif which==2 
        disp('黑是活的白是死的，點擊的地方狀態會變，點其他鍵(如右鍵)結束')
        BUTTON=1;                                                       
        while (BUTTON==1)
            image(chessboard);                                          % 固定一個空白圖的位置給你點
            [X,Y,BUTTON]=ginput(1);
            if (BUTTON==1)
                pick(round(Y),round(X));                                % pick函數:改變當前點的細胞的狀態的函數
            end         
        end
        image(chessboard);pause(2);                                     % 把初始圖print出來並暫停兩秒看清楚
    else
        disp('吃錯東西了，再重來一次ㄅ')                                  % 沒什麼用的which防呆
        return
    end
    change=1;
    counter=1;
    ite=0;                                          % 動態平衡時不會自動停，需要靠這個函數
    max_ite=2000;                                   % 最多只跑二千次(約2分鐘)
    while(change>0)                                 
        change=0;
        for ii=1:N                                  % ii、jj是每個細胞
            for jj=1:N                              % kk、ww是每個細胞周圍八格
                if chessboard(ii,jj,1)              % 死的，周圍剛好三個黑(0)活
                    times=0;                       
                    for kk=ii-1:ii+1
                        for ww=jj-1:jj+1
                            times=times+diffusion(kk,ww);
                        end
                    end
                    refun(times,ii,jj,false);       % 死的false
                else                                % 活的，周圍兩個黑或三個黑則活，否則死
                    times=-1;                       % 自己活的，先扣掉
                    for kk=ii-1:ii+1
                        for ww=jj-1:jj+1
                            times=times+diffusion(kk,ww);
                        end
                    end
                    refun(times,ii,jj,true);       % 活的true
                end
            end
        end
        % output環節
        change=draw(checkM);                        % draw會回傳1/0，若是0代表沒東西改變(靜態平衡，出迴圈)
        pause(0.05);                                % 世界越快，心則慢
        image(chessboard);drawnow
        checkM=zeros(N,N);                          % 歸零儲存改變的陣列
        if ite>=max_ite                             % 防爆
            disp('跑了很多次，我猜已經動態平衡了');
            return;
        end
        ite=ite+1;
    end
    disp('沒了，大家都是不動的穩定態');
    
    % 多個內函數
    function lives(ite,N)           % 隨機挑活人的函數
        while (ite>0)               
        row=randi(N); 
        column=randi(N); 
            if (chessboard(row,column)==255)
                for ii=1:3
                    chessboard(row,column,ii)=0;
                end
                ite=ite-1;
            end
        end
    end
    function pick(x,y)              % 點擊切換死活函數
        if (chessboard(x,y,1))
            for ii=1:3
                chessboard(x,y,ii)=0;
            end
        else
            for ii=1:3
                chessboard(x,y,ii)=255;
            end
        end
    end
    function deaths=diffusion(x,y)  % 判斷這格是不是黑的，白的是0，黑的是1
        if chessboard(module(x),module(y),1)
            deaths=0;
        else
            deaths=1;
        end
    end
    function after=module(x)      % 把0/N+1換成N/1
        if x==0
            after=N;
        elseif x==N+1
            after=1;
        else
            after=x;
        end
    end
    function refun(times,x,y,booling)            % 決定這個細胞的生死
        if booling
            if (times<=1) || (times>=4)
                checkM(x,y)=-1;                  % 可以死過去
            end
        else
            if times==3                          
                checkM(x,y)=1;                   % 可以活過來
            end
        end
    end
    function change=draw(checkM)   % 把這一輪被感染的人都在這裡感染完
        change=0;                       % 如果有新的人被感染，change=1
        for ii=1:N                      % 代表下一輪還有可能有人被感染
            for jj=1:N
                if checkM(ii,jj)==0
                    continue;
                elseif checkM(ii,jj)==-1
                    for kk=1:3
                        chessboard(ii,jj,kk)=255;
                    end
                    change=1;
                else
                    for kk=1:3
                        chessboard(ii,jj,kk)=0;
                    end
                    change=1;
                end
            end
        end
    end
end
