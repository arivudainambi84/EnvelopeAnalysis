function edi=edi_rect(stim1,stim2)
% programme to calculate envelope difference index
% Usage:-
%      edi=edi_rect('orig.wav','compressed.wav')
% 
format bank

[x1,sf]=audioread(stim1);
% x1=x1';
% rmsx1=sqrt(mean(x1.^2));  
% x1=0.15*x1/rmsx1;         % scaling the signal

[x2,sfn]=audioread(stim2);
% x2=x2';
% rmsx2=sqrt(mean(x2.^2));
% x2=0.15*x2/rmsx2;         % scaling the signal

if sf~=sfn
    disp('sampling frequencies are not same');
    return
end

if length(x2)>length(x1)                    %
    x2(length(x1)+1:length(x2))=[];         %
else                                        %
    x2=[x2;zeros(length(x1)-length(x2), 1)];% preferably to used for making small adjustment
end

% if length(x1)~=length(x2)
%     disp('duration of both the stimuli are not equal');
%     return
% end

x1env=abs(x1);
[b,a]=butter(4,80/sf);
env1=filtfilt(b,a,x1env);

d=(1/sf)*(1:length(x1));

subplot(211)
plot(d,x1,'g',d,env1,'r');
%     e1=abs(e1);
meene1=mean(env1);
x1sc=env1./meene1;

x2env=abs(x2);
env2=filtfilt(b,a,x2env);
subplot(212); 
plot(d,x2,'g',d,env2,'r')
%     e2=abs(e2);
meene2=mean(env2);
x2sc=env2./meene2;
% x2sc=-1*(x2sc);

edi=abs(x1sc-x2sc)/(2*length(x1));
edi=sum(edi);