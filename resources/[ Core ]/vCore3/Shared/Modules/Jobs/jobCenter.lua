---
--- @author Kadir#6666
--- Create at [21/05/2023] 14:54:37
--- Current project [Valestia-V1]
--- File name [jobCenter]
---

local job_center = Config["Jobs"]["Center"];
local job_list = Config["Jobs"]["List"];

if (type(job_center) ~= "table" or type(job_list) ~= "table") then
    return
end

JobCenter = {}

---@return table
function JobCenter.getAllFarm()

    if (type(job_list) == "table") then

        local jobs = {}

        for i = 1, #job_list do

            local job_list_selected = job_list[i]

            if (type(job_list_selected) == "table" and type(job_list_selected["farm"]) == "table") then
                jobs[i] = job_list_selected;
            end

        end

        return jobs;

    end

    return false;


end

---@param job_id number
---@return table
function JobCenter.getFromId(job_id)

    if (type(job_id) ~= "number") then
        return
    end

    return type(job_list) == "table" and job_list[job_id]

end

---@param job_name number
---@return table
function JobCenter.getFromName(job_name)

    if (type(job_name) ~= "string") then
        return
    end

    if (type(job_list) == "table") then

        for i = 1, #job_list do

            local job_list_selected = job_list[i]

            if ((type(job_list_selected) == "table" and type(job_list_selected["data"]) == "table") and job_list_selected["data"].name == job_name) then
                return job_list_selected, i;
            end

        end

    end

    return false;

end