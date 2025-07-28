HOSTED_ITEMS = {
"regirock_hosted", "argenta_hosted", "dahlia_hosted", "thorton_hosted",
"darach_hosted"

}

function initialize_watch_items()
    for _, code in pairs(HOSTED_ITEMS) do
        ScriptHost:AddWatchForCode(code, code, toggle_item)
    end
end
