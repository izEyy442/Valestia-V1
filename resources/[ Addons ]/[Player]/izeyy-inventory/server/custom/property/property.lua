function dataFromProperty(source, idProperty)
    -- exemple data for property : 

    -- data = {
    --     weight = 50,
    --     maxWeight = 250,
    --     accounts = {
    --         {name = 'cash', count = 22},
    --         {name = 'dirtycash', count = 2000}
    --     },
    --     items = {
    --         {name = 'phone', label = 'Téléphone', count = 3},
    --         {name = 'bread', label = 'Pain', count = 2}
    --     },
    --     weapons = {
    --         {name = 'WEAPON_PISTOL', label = 'Pistolet', count = 3},
    --     },
    --     clothes = {
    --         {name = 'pants', label = 'Pantalons 33', id = 3},
    --     },
    -- }
    return data
end


action_Property = {
    ['item'] = {
        ['deposit'] = function(source, data)
            -- data.idProperty
            -- data.name
            -- data.label
            -- data.count
            -- data.weight
        end,
        ['remove'] = function(source, data)

        end
    },

    ['weapon'] = {
        ['deposit'] = function(source, data)
            -- data.idProperty
            -- data.name
            -- data.label
            -- data.weight
        end,
        ['remove'] = function(source, data)

        end
    },

    ['account'] = {
        ['deposit'] = function(source, data)
            -- data.idProperty
            -- data.name
            -- data.label
            -- data.count
        end,
        ['remove'] = function(source, data)

        end
    },

    ['clothe'] = {
        ['deposit'] = function(source, data)
            -- data.idProperty
            -- data.name = id of table 'izey_clothes'
            -- data.label
            -- data.weight
        end,
        ['remove'] = function(source, data)

        end
    },
}
