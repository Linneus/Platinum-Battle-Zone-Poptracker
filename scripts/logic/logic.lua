BADGES = {"ForestBadge", "CobbleBadge", "FenBadge", "MineBadge", "RelicBadge", "CoalBadge", "IcicleBadge", "BeaconBadge"}
PLATES = {"FistPlate", "SkyPlate", "ToxicPlate", "EarthPlate", "StonePlate", "InsectPlate", "SpookyPlate", "IronPlate", 
			"ZapPlate", "FlamePlate", "SplashPlate", "MeadowPlate", "MindPlate", "IciclePlate", "DracoPlate", "DreadPlate"}
PRINTS = {"HallPrint", "ArcadePrint", "FactoryPrint", "CastlePrint"}

function badges(AMOUNT)
	AMOUNT = tonumber(AMOUNT)
	local req = AMOUNT
	local count = 0
	for _, item in pairs(BADGES) do
		if has(item) then
			count = count + 1
		end
	end
	return count >= req
end

function plates(AMOUNT)
    AMOUNT = tonumber(AMOUNT)
    local req = AMOUNT
    local count = 0
    for _, item in pairs(PLATES) do
        if has(item) then
            count = count + 1
        end
    end
    return count >= req
end

function prints(AMOUNT)
    AMOUNT = tonumber(AMOUNT)
    local req = AMOUNT
    local count = 0
    for _, item in pairs(PRINTS) do
        if has(item) then
            count = count + 1
        end
    end
    return count >= req
end

-- Access Functions
-- HMs
function cut()
  return has("HM01Cut") and has("ForestBadge")
end

function fly()
  return has("HM02Fly") and has("CobbleBadge")
end

function surf()
  return has("HM03Surf") and has("FenBadge")
end

function strength()
  return has("HM04Strength") and has("MineBadge")
end

function defog()
  return has("HM05Defog") and has("RelicBadge")
end

function rocksmash()
  return has("HM06RockSmash") and has("CoalBadge")
end

function waterfall()
  return has("HM07WaterFall") and has("BeaconBadge") and surf()
end

function rockclimb()
  return has("HM08RockClimb") and has("IcicleBadge")
end

function coupons()
  return has("RentalCoupon1") and has("RentalCoupon2") and has("RentalCoupon3")
 end
 
function tokens()
  return has("GoldToken") and has("SilverToken")
end
 
function lakehunt()
	return has("event_saturn") and has("event_mars") and has("event_jupiter")
end

function warehouseopen()
	return has("StorageKey") or has("event_galactichq")
end

function r205river()
	return has("WorksKey") or surf()
end

-- YAML Options
 
function hidden()
  return (has("opt_dowsing_off") or (has("Poketch") and has("DowsingMachineApp")))
end

function hidden_on()
	return has("opt_hidden_on")
end

--Victorys

function tycoon()
  return prints(4) and has("MachinePart")
 end

function vict_arceus()
	return has("azureflute") and plates(16) and has("ProgDex3")
end

-- Beeg Access
function route226()
	return (
		rockclimb()
		or (
			surf()
			and cut()
			)
	)
end

function route228()
	return (
		cut()
		or (
			rockclimb()
			and surf()
		)
	)
end

function route227()
	return (
		has("Bicycle") and route228()
	)
end

function stark1()
	return (
		route227() and strength()
	)
end

function stark2()
	return (
		stark1() and rocksmash()
	)
end

function rockpeak1()
	return (
		route228() and (has("Bicycle") or fly()) and has("TM70-Flash")
	)
end

function rockpeak2()
	return (
		rockpeak1() and has("regirock") and surf()
	)
end

function central()
	if (rocksmash()
			and r205river()
			and strength()
			and has("SecretPotion"))then
		if defogcross() == AccessibilityLevel.SequenceBreak or early_fly() == AccessibilityLevel.SequenceBreak then
			return AccessibilityLevel.SequenceBreak
		else
			return 
				rocksmash()
				and r205river()
				and strength()
				and has("SecretPotion")
		end
	else
		return (has("Bicycle") and early_fly())
	end
end

function uppercoronet()
	return surf()
	and rockclimb()
	and strength()
	and has("event_guardians")
	and central()
end

function celestic()
	return ((
			strength()
			and rocksmash()
		) and eterna()
	or celesticviacentral()
	or uppercoronet())
end

function celesticviacentral()
	if has("SecretPotion") then
		if central() == AccessibilityLevel.SequenceBreak then
			return AccessibilityLevel.SequenceBreak
		else
			return central() and defogcross()
		end
	else
		return has("SecretPotion")
	end
end

function north()
	if strength() then
		if celestic() == AccessibilityLevel.SequenceBreak then
			return AccessibilityLevel.SequenceBreak
		else
			return celestic() and north_fly()
		end
	else
		return strength()
	end
end

function battlezone()
	return has("S.S.Ticket")
	and has("ProgDex3")
	and north()
end

function pastoria()
	return (
		surf()
		or has("opt_extra_blocks_off")
	) and central()
end

function sunnyshore()
	return (
		has("event_distortion")
		or has("opt_open_sshore_on")
	) and pastoria()
end

function vroad()
	return surf()
	and waterfall()
	and sunnyshore()
end

function vroadback()
	return rocksmash()
	and rockclimb()
	and strength()
	and vroad()
end

function vrbonus()
	if (defogcross() == AccessibilityLevel.SequenceBreak and vroadback()) or vroadback() == AccessibilityLevel.SequenceBreak then
		return AccessibilityLevel.SequenceBreak
	else
		return defogcross()
		and vroadback()
	end
end
