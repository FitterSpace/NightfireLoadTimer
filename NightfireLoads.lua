
----- GLOBAL VARIABLES -----
local LoadingDotsNTSC = 0x8030E40F --On-foot loading screen dots
local TrueLoadsNTSC = 0x8030F8F3 --True on-foot loading times (includes black screens)
local LoadingDotsPAL = 0x8030E46F
local TrueLoadsPAL = 0x8030F953
local DLoadingScreen = 0x803897E7 --Driving level loading screen

local OnFootLevelIDNTSC = 0x8029EB88	
local OnFootLevelIDPAL = 0x8029EBE8
local DrivingLevelName = 0x8036AFA4 --Works for both NTSC and PAL

local IsLoadingScreen = 0   --Is this a "character" loading screen?
local text = ""

function onScriptStart()
end

function onScriptCancel()
end

function onScriptUpdate()
			
  --Driving Levels
  if ReadValueString(DrivingLevelName,11) == "paris_mis01"	--Paris Prelude
  or ReadValueString(DrivingLevelName,11) == "snow1a_mis3"			--Alpine Escape
  or ReadValueString(DrivingLevelName,11) == "snow2a_mis4"			--Enemies Vanquished
  or ReadValueString(DrivingLevelName,8) == "uw_mis11"				  --Deep Descent
  or ReadValueString(DrivingLevelName,14) == "junglea_mis13a"	  --Island Infiltration 1
  or ReadValueString(DrivingLevelName,14) == "jungleb_mis13b"	  --Island Infiltration 2
  or ReadValueString(DrivingLevelName,14) == "jungleb_mis13c"	then --Island Infiltration 3

      if ReadValue8(DLoadingScreen) == 1 then 
        IsLoadingScreen = 1
      else
        IsLoadingScreen = 0
      end

  --On-foot levels (NTSC)
  elseif (ReadValue32(OnFootLevelIDNTSC) > 117440512 
      and ReadValue32(OnFootLevelIDNTSC) < 117440584)
    or (ReadValue32(OnFootLevelIDNTSC) > 117440584
      and ReadValue32(OnFootLevelIDNTSC) < 117440767) then

      --You are in a loading screen if both LoadingDots is true (for on-foot levels only)
        if ReadValue8(LoadingDotsNTSC) == 1 then
          IsLoadingScreen = 1
        end

        --A loading screen finishes when both LoadingDots and TrueLoads = 0
        if ReadValue8(LoadingDotsNTSC) == 0
        and ReadValue8(TrueLoadsNTSC) == 0 then
          IsLoadingScreen = 0
        end
  
  --On-foot levels (PAL)
  elseif (ReadValue32(OnFootLevelIDPAL) > 117440512 
    and ReadValue32(OnFootLevelIDPAL) < 117440584)
  or (ReadValue32(OnFootLevelIDPAL) > 117440584
    and ReadValue32(OnFootLevelIDPAL) < 117440767) then

    --You are in a loading screen if both LoadingDots is true (for on-foot levels only)
      if ReadValue8(LoadingDotsPAL) == 1 then
        IsLoadingScreen = 1
      end

      --A loading screen finishes when both LoadingDots and TrueLoads = 0
      if ReadValue8(LoadingDotsPAL) == 0
      and ReadValue8(TrueLoadsPAL) == 0 then
        IsLoadingScreen = 0
      end

    
  end

  if  IsLoadingScreen == 1 then text = "LOADING!!!!!"
  else text = "Not Loading"
  end
  
  SetScreenText(text)

end

function onStateLoaded()
end

function onStateSaved()
end