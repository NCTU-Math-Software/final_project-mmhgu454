function Life_Game()
% �{���γ~�G�����d�¥ͩR�C�����B�@�Ҧ�
% �{��input:N�Bwhich�B�i�঳k(�o�ǬO�����򪺦b�{����������)
% �{��output:�ͩR�C����figure
%
    N=input('�e���d��n�h�j(NxN�H(��ĳ�b10~100�����A����ΪA)\n');
    which=input(['�Ʊ��H���ͦ�(�U�@�B�]�w�ͦ���)�٬O��ʿ���H\n' ...
             '(�YN�Ӥj��ĳ�H���ͦ�)' '�H���ͦ���J 1' '�A��ʿ����J 2 ']);
    chessboard=255*ones(N,N,3);                                         %
    checkM=zeros(N,N);                                                  % �̫�P�_�U�@�Ӷ��q���U��m�ӭM�s���P�_
    if which==1                                                         % 0�����ܡA-1�h�ܦ��`�A1�h�O�_��
        k=input(['�n�ͦ��X���I�H(���˽d��b' ...
            num2str((1/4)*N^2) '~' num2str((1/2)*N^2) '����)\n']);    
        if k>=N^2;                                                      % �S����Ϊ����b
            disp('�X�ƤF���B�A�A���Ӥ@���t')
            return
        end
        lives(k,N);                                                     % �H���ͦ�case���ͦ����
        image(chessboard);pause(2);                                     % ���l��print�X�ӨüȰ����ݲM��
    elseif which==2 
        disp('�¬O�����լO�����A�I�����a�説�A�|�ܡA�I��L��(�p�k��)����')
        BUTTON=1;                                                       
        while (BUTTON==1)
            image(chessboard);                                          % �T�w�@�ӪťչϪ���m���A�I
            [X,Y,BUTTON]=ginput(1);
            if (BUTTON==1)
                pick(round(Y),round(X));                                % pick���:���ܷ�e�I���ӭM�����A�����
            end         
        end
        image(chessboard);pause(2);                                     % ���l��print�X�ӨüȰ����ݲM��
    else
        disp('�Y���F��F�A�A���Ӥ@���t')                                  % �S����Ϊ�which���b
        return
    end
    change=1;
    counter=1;
    ite=0;                                          % �ʺA���Ůɤ��|�۰ʰ��A�ݭn�a�o�Ө��
    max_ite=2000;                                   % �̦h�u�]�G�d��(��2����)
    while(change>0)                                 
        change=0;
        for ii=1:N                                  % ii�Bjj�O�C�ӲӭM
            for jj=1:N                              % kk�Bww�O�C�ӲӭM�P��K��
                if chessboard(ii,jj,1)              % �����A�P���n�T�Ӷ�(0)��
                    times=0;                       
                    for kk=ii-1:ii+1
                        for ww=jj-1:jj+1
                            times=times+diffusion(kk,ww);
                        end
                    end
                    refun(times,ii,jj,false);       % ����false
                else                                % �����A�P���Ӷ©ΤT�Ӷ«h���A�_�h��
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
        change=draw(checkM);                        % draw�|�^��1/0�A�Y�O0�N��S�F�����(�R�A���šA�X�j��)
        pause(0.05);                                % �@�ɶV�֡A�߫h�C
        image(chessboard);drawnow
        checkM=zeros(N,N);                          % �k�s�x�s���ܪ��}�C
        if ite>=max_ite                             % ���z
            disp('�]�F�ܦh���A�ڲq�w�g�ʺA���ŤF');
            return;
        end
        ite=ite+1;
    end
    disp('�S�F�A�j�a���O���ʪ�í�w�A');
    
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