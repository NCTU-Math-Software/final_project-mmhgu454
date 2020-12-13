function project18(N,k,which)
% 病毒擴散圖，教室裡有5*5共25個位置，其中有k個已經感染的人，求病毒擴散的圖
% rule:若一個健康的人周圍有三個感染者，則健康的人會被傳染，
% 角落的人則是周圍人都感染即感染。 
% 題目好像怪怪的，先改成旁邊只有一個健康的則感染看看
%
% input: N:座位有多少個(N*N正方形)  
%        k:若感染者隨機生成，要生成幾個(沒防呆)
%        which 輸入1=程式根據前項N、k生成座位表 or 
%                  2=只生成N*N大小，誰被感染自己點
% N=5;
% k=7;
    classroom=255*ones(N,N,3);
    orderset=zeros(N,N);
    % which
    if which==1
        infection(k,N);
        image(classroom)
    else
        image(classroom)
        disp('想要誰被感染就點左鍵，點其他鍵結束')
        BUTTON=1;
        while (BUTTON==1)
            [X,Y,BUTTON]=ginput(1);
            if (BUTTON==1)
                for ii=1:3
                    classroom(round(Y),round(X),ii)=0;
                end
            end
            image(classroom)
        end
    end

    change=1;
    counter=1;
    while(change>0)
        x_bar=[];
        y_bar=[];
        change=0;
        % 左邊
        for ii=2:N-1              
            if classroom(ii,1,1)
                times=0;
                if classroom(ii-1,1,1)
                    times=times+1;
                end
                if classroom(ii+1,1,1)
                    times=times+1;
                end
                if classroom(ii,2,1)
                    times=times+1;
                end
                refun(times,ii,1);
            end
        end
        % 右邊
        for ii=2:N-1              
            if classroom(ii,N,1)
                times=0;
                if classroom(ii-1,N,1)
                    times=times+1;
                end
                if classroom(ii+1,N,1)
                    times=times+1;
                end
                if classroom(ii,N-1,1)
                    times=times+1;
                end
                refun(times,ii,N);
            end
        end
        % 上邊
        for ii=2:N-1              
            if classroom(1,ii,1)
                times=0;
                if classroom(1,ii-1,1)
                    times=times+1;
                end
                if classroom(1,ii+1,1)
                    times=times+1;
                end
                if classroom(2,ii,1)
                    times=times+1;
                end
                refun(times,1,ii);
            end
        end
        % 下邊
        for ii=2:N-1              
            if classroom(N,ii,1)
                times=0;
                if classroom(N,ii-1,1)
                    times=times+1;
                end
                if classroom(N,ii+1,1)
                    times=times+1;
                end
                if classroom(N-1,ii,1)
                    times=times+1;
                end
                refun(times,N,ii);
            end
        end
        % 四個角落
        if classroom(1,1,1)
            times=0;
            if classroom(2,1,1)
                times=times+1;
            end
            if classroom(1,2,1)
                times=times+1;
            end
            refun(times,1,1);
        end
        if classroom(1,N,1)
            times=0;
            if classroom(1,N-1,1)
                times=times+1;
            end
            if classroom(2,N,1)
                times=times+1;
            end
            refun(times,1,N);
        end
        if classroom(N,1,1)
            times=0;
            if classroom(N,2,1)
                times=times+1;
            end
            if classroom(N-1,1,1)
                times=times+1;
            end
            refun(times,N,1);
        end
        if classroom(N,N,1)
            times=0;
            if classroom(N,N-1,1)
                times=times+1;
            end
            if classroom(N-1,N,1)
                times=times+1;
            end
            refun(times,N,N);
        end
        % 中間的
        for ii=2:N-1
            for jj=2:N-1
                if classroom(ii,jj,1)
                    times=0;
                    if classroom(ii,jj+1,1)
                        times=times+1;
                    end
                    if classroom(ii,jj-1,1)
                        times=times+1;
                    end
                    if classroom(ii+1,jj,1)
                        times=times+1;
                    end
                    if classroom(ii-1,jj,1)
                        times=times+1;
                    end
                    refun(times,ii,jj);
                end
            end
        end
        % output環節
        change=draw(x_bar,y_bar);
        pause(1);
        image(classroom);
        for ii=1:size(x_bar,2)
            orderset(x_bar(ii),y_bar(ii))=counter;
        end
        x_bar=[];        
        y_bar=[];
        counter=counter+1;
    end
    for ii=1:N
        for jj=1:N
            if (orderset(ii,jj))
                text(jj,ii,num2str(orderset(ii,jj)),'Color','w')
            end
        end
    end
    disp('沒了，數字是擴散順序')
    
    
    % 內函數*3
    function infection(ite,N)           % 用method 1的話，
        while (ite>0)                   % 隨機挑感染者的函數。
        row=randi(N); 
        column=randi(N); 
            if (classroom(row,column)==255)
                for ii=1:3
                    classroom(row,column,ii)=0;
                end
                ite=ite-1;
            end
        end
    end
    function change=draw(x_bar,y_bar)   % 把這一輪被感染的人都在這裡感染完
        change=0;                       % 如果有心的人被感染，change=1
        for ii=1:size(x_bar,2)          % 代表下一輪還有可能有人被感染
            for kk=1:3
                classroom(x_bar(ii),y_bar(ii),kk)=0;
            end
        end
        if size(x_bar,2)
            change=1;
        end
    end
    function refun(times,x,y)           % 把被感染的人的座位加入出事名單
        if times<=1
            x_bar=[x_bar x];
            y_bar=[y_bar y];
        end
    end
end