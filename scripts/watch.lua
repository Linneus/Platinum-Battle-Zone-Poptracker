HOSTED_ITEMS = {
"regirock", "HallPrint", "ArcadePrint", "FactoryPrint",
"CastlePrint"

}

function initialize_watch_items()
    for _, code in pairs(HOSTED_ITEMS) do
        ScriptHost:AddWatchForCode(code, code, toggle_item)
    end
end
