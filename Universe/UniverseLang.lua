


_U_langs={}
function run_lang(langs)
    if langs=='English' then
        require('Universe_Eng')
    elseif langs=='TH' then
        require('Universe_TH')
    elseif utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\langs\\"..langs..'.lua') then
        require(langs)
    else
        _U_langs={}
    end
end
if utils.file_exists(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Lang.cfg") then
    file=io.open(utils.get_appdata_path("PopstarDevs", "").."\\2Take1Menu\\scripts\\Universe\\cfg\\Universe_Lang.cfg",'r')
    lang=file:read('*a')
    file:close()
    run_lang(lang)
end

function is_bad(cc)
    local cc=tostring(cc)
    local banned_words={
        'Gigi',
        'oriental rug store',
        'Is that dude oriental',
        'Orientals are known to be bad drivers',
        'slanteyes',
        'Chinky',
        'Bed time',
        'ching chong',
        'Banana',
        'Yellow Monkey',
        'Bruce Lee',
        'Gook'
    }
    for i=1,#banned_words do
        if cc:find(banned_words[i]) or cc:find(string.upper(banned_words[i])) or cc:find(string.lower(banned_words[i])) then
            return "Please don't be racist"
        end
    end
    return cc
end

function lang(name)
    if _U_langs[name]~=nil and _U_langs[name]~=name then
        if is_bad(_U_langs[name]) then
            return _U_langs[name]
        end
    else
        return name
    end
end
