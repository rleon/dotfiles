screens = {
	['default'] = {
		['connected'] = function (xrandrOutput)
			return '--output ' .. xrandrOutput .. ' --auto --same-as eDP1'
		end,
		['disconnected'] = function (xrandrOutput)
			return '--output ' .. xrandrOutput .. ' --off --output eDP1 --auto'
		end
	},
	['86671360010'] = {
		['connected'] = function (xrandrOutput)
			return '--output ' .. xrandrOutput .. ' --auto --left-of eDP1'
		end,
		['disconnected'] = nil
	},
	['96411099050'] = {
		['connected'] = function (xrandrOutput)
			return '--output ' .. xrandrOutput .. ' --auto --left-of eDP1'
		end,
		['disconnected'] = nil
	},
--	['48111111'] = {
--		['connected'] = function (xrandrOutput)
--			return '--output ' .. xrandrOutput .. ' --auto --left-of DP2-3'
--		end,
--		['disconnected'] = nil
--	},
}
