---@type Table
Table = Class.new(function(class) 

    ---@class Table: BaseObject
    local self = class;

    ---@param table table
    ---@return number
    function self:SizeOf(table)
        local size = 0;
        for _, data in pairs(table) do
            if (data ~= nil) then
                size = size + 1
            end
        end
        return size;
    end

    ---@param full_object table
    function self:Dump(full_object)
        -- Table used to store already visited tables (avoid recursion)
        local visited = {}
    
        -- Table used to store the final output, which will be concatted in the end
        local buffer = {}
    
        -- Cache table.insert as local because it's faster
        local table_insert = table.insert
    
        -- Internal recursive function
        local function DumpRecursive(object, indentation)
            local object_type = type(object)
    
            -- If it's a table and was not outputted yet
            if (object_type == 'table' and not visited[object]) then
                local object_metatable = getmetatable(object);

                if (object_metatable) then
                    DumpRecursive(object_metatable, 0);
                end
                -- Marks as visited
                visited[object] = true
    
                -- Stores all keys in another table, sorting it
                local keys = {}
    
                for key, v in pairs(object) do
                    table_insert(keys, key)
                end
    
                table.sort(keys, function(a, b)
                    if type(a) == "number" and type(b) == "number" then
                        return a < b
                    else
                        return tostring(a) < tostring(b)
                    end
                end)
    
                -- Increases one indentation, as we will start outputting table elements
                indentation = indentation + 1
    
                -- Main table displays '{' in a separated line, subsequent ones will be in the same line
                table_insert(buffer, indentation == 1 and "\n{" or "{")
    
                -- For each member of the table, recursively outputs it
                for k, key in ipairs(keys) do
                    local formatted_key = type(key) == "number" and tostring(key) or '"' .. tostring(key) .. '"'
    
                    -- Appends the Key with indentation
                    table_insert(buffer, "\n" .. string.rep(" ", indentation * 4) .. formatted_key .. " = ")
    
                    -- Appends the Element
                    DumpRecursive(object[key], indentation)
    
                    -- Appends a last comma
                    table_insert(buffer, ",")
                end
    
                -- After outputted the whole table, backs one indentation
                indentation = indentation - 1
    
                -- Adds the closing bracket
                table_insert(buffer, "\n" .. string.rep(" ", indentation * 4) .. "}")
            elseif (object_type == "string") then
                -- Outputs string with quotes
                table_insert(buffer, '"' .. tostring(object) .. '"')
            else
                -- Anything else just stringify it
                table_insert(buffer, tostring(object))
            end
        end
    
        -- Main call
        DumpRecursive(full_object, 0)
    
        -- After all, concats the results
        return table.concat(buffer)
    end    

    return self;
end);