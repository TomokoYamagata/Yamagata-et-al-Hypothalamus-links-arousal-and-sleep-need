
clear all
close all

path1='I:\optogenetics\';
path2='I:\OptoMod\';
pathin=[path2,'outputVS1\Baseline_10Hz\']; %
pathEMG=[path2,'OutputSIGvar\'];%mkdir(pathEMG)
pathEMG2=[path2,'outputEMGs\'];
pathF=[path1,'Figures_Hypnograms\'];mkdir(pathF)

tl = 'Baseline-10Hz'
ders=strvcat('fro','occ');
mousenames=[5 6 8 12 15 16 17 18 19 20 21];
% days=['020418 030418';'290418 120418';'100618 050618';'100618 090618';...
%     '181218 191218';'181218 191218';'181218 191218';...
%     '100819 160819';'100819 160819';'070819 160819';'100819 160819'];	
% ya=[6000 4000 7000 5000 8000 7000 7000 7000 6000 4000 5000];
% yaemg=[7000 4000 2*10^5 5000 2500 2000 10^5 7000 7000 10000 10000];

days=['020418 030418';'290418 120418';'130518 140518';'100618 090618';...
    '181218 191218';'181218 191218';'181218 191218';...
    '100819 160819';'100819 160819';'070819 160819';'100819 160819'];	
ya=[6000 4000 5600 5000 8000 8000 7000 7000 6000 4000 5000];
yaemg=[7000 4000 4*10^6 5000 2000 5000 10^5 7000 7000 10000 10000];

f=0:0.25:30;
maxep=21600;
zermat=zeros(1,maxep);
x=1:1:maxep; x=x./900;

numanim=length(mousenames);

OOO=[];
dr=1; %1%2
deri=ders(dr,:)

for ii=[6] %1:numanim
    mousename=['GDCh',num2str(mousenames(ii))];
    daysi=days(ii,:); is=find(isspace(daysi));

    for dd=2:2
    figure
    
    fig = figure;
    
    if dd==1 day=daysi(1:is(1)-1); else day=daysi(is(1):end); end
    day(isspace(day))=[];

    fn=[mousename,'-',day,'-',deri];%fn=[mouse,'-',day,'-',der,'-VSspec'];
    eval(['load ',pathin,fn,'.mat spectr w nr r w1 nr2 r3 mt ma bastend -mat']);

    swa=mean(spectr(:,3:17),2);
    W=zermat; W(w)=1;
    N=zermat; N(nr)=1;
    R=zermat; R(r)=1;

    swaW=swa; swaW(W==0)=NaN;
    swaN=swa; swaN(N==0)=NaN;
    swaR=swa; swaR(R==0)=NaN;

    swa=[swaW swaN swaR];
    swa=swa(1:maxep,:);

%%%%%%%%% EMG absolute value    
    fin1=[mousename,'-EMGv-optstim-',day];
    eval(['load ',pathEMG,fin1,'.mat EMGv optstim -mat']); %EEGv mousename 
%     EMG=EMGv(1:maxep);

%%%%%%%%% EMG variance
    fin1 = [mousename,'-',day,'-EMGVar'];
    eval(['load ',pathEMG2,fin1,'.mat EMGVar EMGVarSec -mat']); %EEGv mousename %,'EMGVar','EMGVarSec'   
%     EMGmat=EMGVarSec(1:maxep*4);
%     EMGmat=reshape(EMGmat,4,[]);
%     mEMG=sum(EMGmat);
    EMGmat=zeros(maxep*16,1);
    if maxep==21600; EMGmat(1:length(EMGVar))=EMGVar; else; EMGmat=EMGVar(1:maxep*16,1); end
    EMGmat=reshape(EMGmat,16,[]);
    mEMG=nanmean(EMGmat);    
    EMG=mEMG(1:maxep);    
    
    stim=optstim(1:maxep);
  

%     co = [0 .27 .8;    
%       .2 .6 0;
%       .86 .1 0;
%     0.4940    0.1840    0.5560
%     0.4660    0.6740    0.1880
%     0.3010    0.7450    0.9330
%     0.6350    0.0780    0.1840];
%     set(groot,'defaultAxesColorOrder',co)
    
    co = [0 114/255 178/255;    %blue
      0 158/255 115/255; %230/255 159/255 0; % green
      230/255 159/255 0; %213/255 94/255 0; % orange
    204/255 121/255 167/255]; %pink
    set(groot,'defaultAxesColorOrder',co)
    
%%%%%%%%%% SWA  
    subplot ('position',[0.1 1-0.5*dd+0.18 0.8 0.24])
    plot(x,swa) %plot(x1,swa,'LineWidth',1,'color',[0 0.4 0])
    hold on
    axis([0 maxep/900 0 ya(ii)])
    set(gca, 'YTick',[0:5000:10000],'YTicklabels',[],'TickDir','out'); 
    set(gca, 'XTick', [], 'TickDir','out'); 
%     ylabel('SWA (uV/0.25 Hz)')
%     xticklabels({})
%     title ([tl,' ',fn]); 
%     grid on
    hold on
    plot([24.0 24.0],[0 5000],'-k','LineWidth',2)
     
%%%%%%%%%% optstim       
figure
    subplot ('position',[0.1 1-0.5*dd+0.16 0.8 0.02])
    bar(x,stim,'FaceColor',[180/255  200/255  1])
    xticklabels({});yticklabels({});
    axis([0 maxep/900 0 1])
    set(gca, 'visible', 'off');
%     ylabel('optostim')
%     grid on
 
%%%%%%%%%% EMG 
figure
    options.color_line2 = [80 80 80]./255; % EMG
    subplot ('position',[0.1 1-0.5*dd+0.11 0.8 0.05])
    plot(x,EMG,'color',options.color_line2)
    hold on
    axis([0 maxep/900 0 yaemg(ii)])
%     ylabel('EMG')
    set(gca,'XTick',[0:2:24],'XTicklabels',[],'TickDir','out')
    set(gca, 'YTick', [], 'TickDir','out');
%     grid on
    plot([24.0 24.0],[0 5000],'-k','LineWidth',2)
    
    fig.PaperPositionMode = 'manual';
    orient(fig,'portrait')
 
    if dd==1;
    saveas(fig,[pathF,['Hypnogram_',tl,'_',mousename,'_1']],'svg') 
 
    end
    
    end
    
    fig.PaperPositionMode = 'manual';
    orient(fig,'portrait')
 
    saveas(fig,[pathF,['Hypnogram_',tl,'_',mousename,'_2']],'svg')
        
end

% mousenames=[6 8];
% days=['140418 150418';'060618 070618'];



% pathin=[path,'outputVSchr\']; 

% mousenames=strvcat('GDCh1','GDCh1','GDCh4','GDCh4','GDCh5','GDCh5','GDCh6','GDCh6','GFP1','GFP1','GFP2','GFP2');
% days=strvcat('040518','060518','140518','160518','040518','060518','020518','300418','140518','160518','020518','300418');
% ders=['fro';'occ']

%%%% Left:SD+stim Rigth:SD only
%%%%%%% Wake Enhancement ChR2
% mousenames=strvcat('GDCh1','GDCh1','GDCh4','GDCh4','GDCh5','GDCh5','GDCh6','GDCh6','GDCh7','GDCh7','GDCh8','GDCh8','GDCh9','GDCh9','GDCh12','GDCh12','GDCh16','GDCh16')
% days=strvcat('040518','060518','160518','140518','040518','060518','300418','020518','030718','010718','130618','110618','130618','110618','130618','110618','090119','110119')
% ders=['fro';'occ']

%%%%%% occ only %%%%%
% mousenames=strvcat('GDCh17','GDCh17') %%occ
% days=strvcat('090119','110119') %%occ
% der=strvcat('occ'); 
% ders=strvcat('occ')
% dr=2; %1%2
