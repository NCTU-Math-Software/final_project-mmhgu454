function Life_Game()
    N=10;k=N*N/4;which=1;
    chessboard=255*ones(N,N,3);
    checkM=zeros(N,N);                  % �令�����O1�A�令�����O-1�A�S��=0
    % which
    if which==1
        lives(k,N);
        image(chessboard);pause(2);
    else
        image(chessboard);pause(2);
        disp('�¬O�����լO�����A�I�����a��|���A�I��L�䵲��')
        BUTTON=1;
        while (BUTTON==1)
            [X,Y,BUTTON]=ginput(1);
            if (BUTTON==1)
                pick(round(Y),round(X));
            end
            image(chessboard)
        end
    end

    change=1;
    counter=1;
    while(change>0)                                 % í�w�A�~��? �n��
        change=0;% ���P�_?
        for ii=1:N                                  % ii�Bjj�O�C�ӤH
            for jj=1:N                              % kk�Bww�O�C�ӤH�P��K��
                if chessboard(ii,jj,1)              % �����A�P���n�T�Ӷ�(0)��
                    times=0;                       
                    for kk=ii-1:ii+1
                        for ww=jj-1:jj+1
                            times=times+diffusion(kk,ww);
                        end
                    end
                    refun(times,ii,jj,false);       % ����false
                else
                    times=-1;                       % �ۤv�����A������
                    for kk=ii-1:ii+1
                        for ww=jj-1:jj+1
                            times=times+diffusion(kk,ww);
                        end
                    end
                    refun(times,ii,jj,true);       % ����true
                end
            end
        end
        % output���`
        change=draw(checkM);
        pause(0.05);
        %[x,y,BUTTON]=ginput(1);    % debug �ΡA�I�F�~�|�U�@�B > <
        image(chessboard);drawnow
        checkM=zeros(N,N);
    end
    disp('�S�F�A�j�a���O���ʪ�í�w�A')
    
    % �h�Ӥ����
    function lives(ite,N)           % �H���D���H�����
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
    function pick(x,y)              % �I�������������
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
    function deaths=diffusion(x,y)  % �P�_�o��O���O�ª��A�ժ��O0�A�ª��O1
        if chessboard(module(x),module(y),1)
            deaths=0;
        else
            deaths=1;
        end
    end
    function after=module(x)      % ��0/N+1����N/1
        if x==0
            after=N;
        elseif x==N+1
            after=1;
        else
            after=x;
        end
    end
    function refun(times,x,y,booling)            % �M�w�o�ӲӭM���ͦ�
        if booling
            if (times<=1) || (times>=4)
                checkM(x,y)=-1;                  % �i�H���L�h
            end
        else
            if times==3                          
                checkM(x,y)=1;                   % �i�H���L��
            end
        end
    end
    function change=draw(checkM)   % ��o�@���Q�P�V���H���b�o�̷P�V��
        change=0;                       % �p�G���s���H�Q�P�V�Achange=1
        for ii=1:N                      % �N��U�@���٦��i�঳�H�Q�P�V
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