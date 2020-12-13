function project18(N,k,which)
% �f�r�X���ϡA�ЫǸ̦�5*5�@25�Ӧ�m�A�䤤��k�Ӥw�g�P�V���H�A�D�f�r�X������
% rule:�Y�@�Ӱ��d���H�P�򦳤T�ӷP�V�̡A�h���d���H�|�Q�ǬV�A
% �������H�h�O�P��H���P�V�Y�P�V�C 
% �D�ئn���ǩǪ��A���令����u���@�Ӱ��d���h�P�V�ݬ�
%
% input: N:�y�즳�h�֭�(N*N�����)  
%        k:�Y�P�V���H���ͦ��A�n�ͦ��X��(�S���b)
%        which ��J1=�{���ھګe��N�Bk�ͦ��y��� or 
%                  2=�u�ͦ�N*N�j�p�A�ֳQ�P�V�ۤv�I
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
        % ����
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
        % �k��
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
        % �W��
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
        % �U��
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
        % �|�Ө���
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
        % ������
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
        % output���`
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
    disp('�S�F�A�Ʀr�O�X������')
    
    
    % �����*3
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
        change=0;                       % �p�G���ߪ��H�Q�P�V�Achange=1
        for ii=1:size(x_bar,2)          % �N��U�@���٦��i�঳�H�Q�P�V
            for kk=1:3
                classroom(x_bar(ii),y_bar(ii),kk)=0;
            end
        end
        if size(x_bar,2)
            change=1;
        end
    end
    function refun(times,x,y)           % ��Q�P�V���H���y��[�J�X�ƦW��
        if times<=1
            x_bar=[x_bar x];
            y_bar=[y_bar y];
        end
    end
end