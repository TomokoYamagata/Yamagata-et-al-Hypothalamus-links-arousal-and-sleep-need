
clear all
close all

path='I:\optogenetics\'; % the working directory with the data folders

%Data from 24h stimulation of 2min every 20min with 10Hz blue light
%%%%%%%% GFP
% mousenames1=[1 2 3 4 5 6 7 8]; % names of GFP ctrl mice indicated in the file name 
% days1=['120518';'050518';'180718';'180718';'111018';'221018';'221018';'150119'];

% %%%%%%% GDCh 
mousenames2=[5 15 16 17 18 19 20 21];
days2=['300318 310318';'201218 211218';'201218 211218';'201218 211218';...
    '040919 060919';'040919 060919';'040919 060919';'040919 060919'];

geno=2; %states which animal group (genotype) I want to look at 

der=2; 

tfstim=1;
tnstim=4; %%%% stim per 225, jitter 22.5, stimlength=30, - 4times: 675+jitter=730, 5times: 900+jitter=955; 6times: 1125+jitter=1180, 8times: 1800+jitter=1630, 16times: 1800+jitter=3430

ne=15; %there are 15 epochs in 1min 
before=2;  %we want to analyze the 2min before stimulus onset and 2min after
after=2;   %gives me 2min before, 2min of stim, and the 2min after 



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%defining all the derivations
ders=strvcat('fro','occ');
deri=ders(der,:);

freqband=0:0.25:30;
maxep=10800; %the total no of 4s epochs in 24h period 
epochs=1:maxep; %creates an array with 1 row and columns from 1 to 21600(maxep)
epochs=epochs./900; %edits x such that each value is divided by 900 to convert the values to hours 
            %15 epochs per 1min and 60min per 1h so 900 epochs per 1h
            %%% ./ = right-array division by dividing each element of A by the corresponding element of B
fs=256; 
epochl=4; %states how long the epoch is
zermat=zeros(1,maxep); %creates an array of zeros with 1 row and as long as the total number of epoch

x=-before*ne:1:after*ne; %creates an array of epoch indices in the 2min before to after period
x=x*epochl; %converts the epoch indices to seconds 



pathvs1=[path,'outputVSgfp\']; %(GFP ctrl)
pathvs2=[path,'outputVSchr\']; %(ChR2 exp)
pathstim=[path,'STIMs\'];

if geno==1 %geno=1 ctrl group
    mousenames=mousenames1;days=days1; pathvs=pathvs1; gn='GFP'; %firststims=firststims1;
elseif geno==2
    mousenames=mousenames2; days=days2; pathvs=pathvs2; gn='GDCh';  %firststims=firststims2;
end
      

vsname=strvcat('Wake','NREM','REM'); %makes a char array with rows of the passed strings of vigilance states

numanim=length(mousenames); %how many animals were recorded

WallMice=[];NallMice=[];RallMice=[];TallMice=[];MallMice=[];DallMice=[];
%wake/NREM/REM/Sleep/Dex state of all mice 
      
Msp1s=[]; Msp2s=[];Msp3s=[]; Msp4s=[];
for anim=1:numanim %go through this loop as many times as there are animals
    mousename=[gn,num2str(mousenames(anim))]; mousename(isspace(mousename))=[];
    daysi=days(anim,:); is=find(isspace(daysi));

    for dd=1:2
        if dd==1 day=daysi(1:is(1)-1); elseif dd==2 day=daysi(is(1)+1:end);  end
        day(isspace(day))=[];

        fn0=[mousename,'_',day,'_stim']; 
        eval(['load ',pathstim,fn0,'.mat startend ']);

        stimep1=round(startend(:,1)./(fs*epochl)); % stim start (stim episode 1)
        stimep2=round(startend(:,2)./(fs*epochl)); % stim end (episode 2) 

        outs=find((stimep2-stimep1)<25);stimep1(outs)=[];stimep2(outs)=[];

        fn=[mousename,'-',day,'-',deri]; %makes the full file name for the vigilance state and derivation output desired

        eval(['load ',pathvs,fn,'.mat spectr w nr r w1 nr2 r3 mt ma bastend -mat']);%

        VS=zeros(9,maxep); 
        VS(1,w)=1; VS(2,w1)=1; VS(3,nr)=1; VS(4,nr2)=1; VS(5,r)=1; VS(6,r3)=1; VS(7,mt)=1; %VS(8,s)=1; VS(9,s4)=1;
        wake=sum(VS(1:2,:)); 
        nrem=sum(VS(3:4,:));
        rems=sum(VS(5:6,:));
        move=VS(7,:);
    %     dex=sum(VS(8:9,:));


        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Plot noiseless Delta and EMG
        nremSp=spectr;
        nremSp([w; r; w1; nr2; r3; mt; ma],:)=NaN;
        wakeSp=spectr;
        wakeSp([nr; r; w1; nr2; r3; mt; ma],:)=NaN;
        clear w nr r w1 nr2 r3 mt ma bastend ;

    %     Delta=nanmean(nremSp(:,3:17),2);
        x1=1:maxep;x1=x1./900;
        %%%%%%%%%%%%%%%%%%%%%%%%%

        if size(stimep1,1)<tnstim
        stimep=stimep1;     
        else
        stimep=stimep1(tfstim:tfstim+tnstim-1); %start of stimulation episodes
        end

        numstim=size(stimep,1) %how many stimulation episodes there are 

        meanSps1=[]; meanSps2=[]; meanSps3=[]; meanSps4=[];
        Sps1=zeros(30,121,numstim);Sps2=zeros(30,121,numstim);%creates empty arrays to be filled 
        for s=1:numstim %iterating over all the stimulations

            step=stimep(s); 

            eps1=step-before*ne:step-1; %returns the desired period
            eps2=step+1:step+2*ne; %returns the desired period
            eps3=step+1:step+4*ne; %returns the desired period

            sp1=nremSp(eps1,:); sp2=nremSp(eps2,:); sp3=wakeSp(eps2,:); sp4=wakeSp(eps3,:); 
            Sps1(:,:,s)=sp1; Sps2(:,:,s)=sp2; Sps3(:,:,s)=sp3; Sps4(:,:,s)=sp4;
            meansp1=nanmean(sp1,1); meansp2=nanmean(sp2,1); meansp3=nanmean(sp3,1); meansp4=nanmean(sp4,1);
            meanSps1=[meanSps1;meansp1]; meanSps2=[meanSps2;meansp2]; meanSps3=[meanSps3;meansp3]; meanSps4=[meanSps4;meansp4];

        end
        Msp1=nanmean(meanSps1,1); Msp2=nanmean(meanSps2,1); Msp3=nanmean(meanSps3,1); Msp4=nanmean(meanSps4,1);
        Msp1s=[Msp1s; Msp1]; Msp2s=[Msp2s; Msp2]; Msp3s=[Msp3s; Msp3]; Msp4s=[Msp4s; Msp4];

        mousename
        aPrism_meanSps1=[meanSps1'];
        aPrism_meanSps2=[meanSps2'];
        aPrism_meanSps3=[meanSps3'];
        aPrism_meanSps4=[meanSps4'];   
    end
   
end
    


aPrism_pre2minNREM=[Msp1s'];
aPrism_mid2minNREM=[Msp2s'];
aPrism_mid2minWake=[Msp3s'];
aPrism_midpost4minWake=[Msp4s'];       