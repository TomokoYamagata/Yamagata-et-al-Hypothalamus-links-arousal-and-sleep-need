# Yamagata-et-al-Hypothalamus-links-arousal-and-sleep-need
Code generated for Yamagata et al., 2020 titled 'The role of the hypothalamus in cortical arousal and sleep homeostasis'

Figures 1-5

Fig 1E-G
  PutativeExample_EEGs_EMG_stim_fromOutputSignals.m

Fig 1J, Demonstrat - Spectrogram (Fig 2I, 5F) - 10Hz 2min
  PlotChampion_Hypno_EMG_Spectrogram_Delta_10Hz.m



Fig 2A, Demonstrate - HSP, LSP
  PlotHypnogramEMGstimSD.m
  	- export_EMG_Variance.m (EMG variance)
  
Fig 2B Spectral power density - HSP, LSP (all 12 stimuli)
  PlotSpectra_NREM_LSPHSP.m

Fig 2C NREM Probability - HSP, LSP (all 12 stimuli)
  Plot_VSprobability_STIMalignedLSPHSP.m

Fig 2F Latency to Sleep after stimulation, LowSleepPressure, HighSleepPressure
  SleepLatency_LSPHSP.m

Fig 2H Dex Representative example
  PlotChampion_Hypno_EMG_Spectrogram_Delta_Temp_Dex_4h

Fig 2I Dex Stateprobability
  PlotVSstimavg_dex_LPOnonLPO.m



Fig 3A, 3C Time course of SWA and state probability – post stim (Fig. 3D, 3I, 8sec, non-LPO) normalized
  Plot_timecourseSWA_SleepProbability_10Hz_normalized_nLPO.m

Fig 3E SWA development, Representative example
  PlotHypnogramEMGstimBaseline10Hz24h_Fig.m



Fig 4C Demonstrate – Spectrogram 
  PlotHypnogramEMGstimWakeEnhancement.m
  
Fig 4D (WakeEnhancement_AnalysisOrder_readme.m) 
  PlotHypnogram.m
    Find latency to wake after 2 hour SD
      PlotHypnogramSleepOnset.m
    Confirm latency to wake after 2 hour SD
      MeanSpectraEffectSD_vsBaseline.m



Supplemental Figures

Fig S1A Initial state at stim on
  Plot_VSprobability_STIMalignedSham_InitialState.m



Fig S2A Latency to Sleep after stimulation & Wake latency (= Figure 1K)
  SleepLatency_ty.m
  
Fig S2B Demonstrate Dex
	PutativeExample_EEGs_EMG_stim_fromOutputSignals.m 
  
Fig S2C Power spectra
  matlab_A\PlotSWAdiff_dex.m
  
Fig S2D percentage decrease in SWA in GFO, LPO, nonLPO
  PlotSWAdiff_dex.m
  
Fig S2E Plot temp – Dex injection 3h, moving average
  PlotAvrTempDexMoveAvr.m
  
Fig S2F Dex calorimetry
  CaloRead_read.m
  CaloRead_plot.m
  
Fig S2G Dex Stateprobability
  PlotVSstimavg_dex_LPOnonLPO.m
  
Fig S2H Dex Wake Latency
  LatencyVSstimavg_dex.m 
	PlotVSstimavg_dex_LPOnonLPO.m



Fig S3B Spectra power relative to sham
  PlotSpectraNREMavg_1Hz2Hz5Hz.m


Fig S4A Demonstrate – Spectrogram, hypno, MovingAvrTemp (21 & 18)
      PlotChampion_Hypno_EMG_Spectrogram_Delta_Temp_2h10Hz.m     
      PlotChampion_Hypno_EMG_Spectrogram_Delta_Temp_2h10Hz_D.m
      
      
Fig S5B average temp
  PlotAvrTemp1h10HzMoveAvr.m
  PlotAvrTemp1h10HzMoveAvrDark.m
Δ∆
