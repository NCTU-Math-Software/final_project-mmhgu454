function Life_Game()
    N=100;k=N*N/4;which=1;
    chessboard=255*ones(N,N,3);
    checkM=zeros(N,N);                  % 改成活的是1，改成死的是-1，沒變=0
    % which

    if which==1
        lives(k,N);
        image(chessboard);pause(2);
    else
        image(chessboard);pause(2);
        disp('黑是活的白是死的，點擊的地方會活，點其他鍵結束')
        BUTTON=1;
        while (BUTTON==1)
            [X,Y,BUTTON]=ginput(1);
            if (BUTTON==1)
                pick(round(Y),round(X));
            end
            image(chessboard)
        end
    end
    h1 = uicontrol('position',  [200 20 80 30]);				% 產生按鈕
    set(h1,'String','暫停');             % 在按鈕表面加入文字「請按我！」
    cmd1 = 'pause();';                  % 定義按鈕被按後的反應指令
    set(h1, 'Callback', cmd1);			% 設定按鈕的反應指令

    change=1;
    counter=1;
    while(change>0)                                 % 穩定態才停? 要調
        change=0;% 怎麼判斷?
        for ii=1:N                                  % ii、jj是每個人
            for jj=1:N                              % kk、ww是每個人周圍八格
                if chessboard(ii,jj,1)              % 死的，周圍剛好三個黑(0)活
                    times=0;                       
                    for kk=ii-1:ii+1
                        for ww=jj-1:jj+1
                            times=times+diffusion(kk,ww);
                        end
                    end
                    refun(times,ii,jj,false);       % 死的false
                else
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
        change=draw(checkM);
        pause(0.05);
        %[x,y,BUTTON]=ginput(1);    % debug 用，點了才會下一步 > <
        image(chessboard);drawnow
        checkM=zeros(N,N);
    end
    disp('沒了，大家都是不動的穩定態')
    
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