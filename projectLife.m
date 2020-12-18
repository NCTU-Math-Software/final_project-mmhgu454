function projectLife()
% �f�r�X���ϡA�ЫǸ̦�5*5�@25�Ӧ�m�A�䤤��k�Ӥw�g�P�V���H�A�D�f�r�X������
% rule:�Y�@�Ӱ��d���H�P�򦳤T�ӷP�V�̡A�h���d���H�|�Q�ǬV�A
% �������H�h�O�P��H���P�V�Y�P�V�C 
% �D�ئn���ǩǪ��A���令����u���@�Ӱ��d���h�P�V�ݬ�
%
% input: N:�y�즳�h�֭�(N*N�����)  
%        k:�Y�P�V���H���ͦ��A�n�ͦ��X��(�S���b)
%        which ��J1=�{���ھګe��N�Bk�ͦ��y��� or 
%                  2=�u�ͦ�N*N�j�p�A�ֳQ�P�V�ۤv�I
% N=7;
% k=7;
    N=20;k=4;which=2;
    classroom=255*ones(N,N,3);
    orderset=zeros(N,N);
    % which
    if which==1
        infection(k,N);
        image(classroom)
    else
        image(classroom)
        disp('�Q�n�ֳQ�P�V�N�I����A�I��L�䵲��')
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
        for ii=1:N                                  % ii�Bjj�O�C�ӤH
            for jj=1:N                              % kk�Bww�O�C�ӤH�P��K��
                if classroom(ii,jj,1)               % �o�ӤH���d�~�ˬd
                    times=-1;                       % �]���ۤv�@�w���d�Adiffusion(ii,jj)=1�A������
                    for kk=ii-1:ii+1
                        for ww=jj-1:jj+1
                            times=times+diffusion(kk,ww);
                        end
                    end
                    deadfun(times,ii,jj);
                else
                    times=0;                       % �]���ۤv�@�w���d�Adiffusion(ii,jj)=1�A������
                    for kk=ii-1:ii+1
                        for ww=jj-1:jj+1
                            times=times+diffusion(kk,ww);
                        end
                    end
                    refun(times,ii,jj);
                end
            end
        end
        % output���`
        classroom(:,:,:)=255;
        change=draw(x_bar,y_bar);
        %pause(1);
        [x,y,BUTTON]=ginput(1);    % debug �ΡA�I�F�~�|�U�@�B > <
        image(classroom);
        for ii=1:size(x_bar,2)
            orderset(x_bar(ii),y_bar(ii))=counter;
        end
        x_bar=[];        
        y_bar=[];
        counter=counter+1;
        %symbolnum();
    end
    disp('�S�F�A�Ʀr�O�X������')
    % �\��i�H�s�W�@�ӡG�p�G�Q�ݲĴX�����X���N�i�H�˰h�^�h�C
    
    
    % �����*5
    function infection(ite,N)           % ��method 1���ܡA
        while (ite>0)                   % �H���D�P�V�̪���ơC
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
    function change=draw(x_bar,y_bar)   % ��o�@���Q�P�V���H���b�o�̷P�V��
        change=0;                       % �p�G���s���H�Q�P�V�Achange=1
       % classroom(:,:,:)=255;
        for ii=1:size(x_bar,2)          % �N��U�@���٦��i�঳�H�Q�P�V
            for kk=1:3
                classroom(x_bar(ii),y_bar(ii),kk)=0;
            end
        end
        if size(x_bar,2)
            change=1;
        end
    end
    function healthy=diffusion(x,y)     % �P�_�o��O���O���d���H�A�O=1�A���O=0
        if (x==0) || (y==0) || (x==N+1) || (y==N+1)
            healthy=0;
        else
            if classroom(x,y,1)
                healthy=1;
            else
                healthy=0;
            end
        end
    end
    function deadfun(times,x,y)           % ��Q�P�V���H���y��[�J�X�ƦW��
        if times<=1 || times>=4
            x_bar=[x_bar x];
            y_bar=[y_bar y];
        end
    end
    function refun(times,x,y);
        if times<=3
            x_bar=[x_bar x];
            y_bar=[y_bar y];
        end
    end
    function symbolnum()
        for ii=1:N
            for jj=1:N
                if (orderset(ii,jj))
                    text(jj,ii,num2str(orderset(ii,jj)),'Color','w')
                end
            end
        end
    end
end