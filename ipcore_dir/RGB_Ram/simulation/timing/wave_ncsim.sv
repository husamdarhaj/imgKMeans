
 
 
 

 



window new WaveWindow  -name  "Waves for BMG Example Design"
waveform  using  "Waves for BMG Example Design"


      waveform add -signals /RGB_Ram_tb/status
      waveform add -signals /RGB_Ram_tb/RGB_Ram_synth_inst/bmg_port/CLKA
      waveform add -signals /RGB_Ram_tb/RGB_Ram_synth_inst/bmg_port/ADDRA
      waveform add -signals /RGB_Ram_tb/RGB_Ram_synth_inst/bmg_port/DINA
      waveform add -signals /RGB_Ram_tb/RGB_Ram_synth_inst/bmg_port/WEA
      waveform add -signals /RGB_Ram_tb/RGB_Ram_synth_inst/bmg_port/DOUTA
console submit -using simulator -wait no "run"
