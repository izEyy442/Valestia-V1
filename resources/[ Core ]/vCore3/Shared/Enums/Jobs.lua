---
--- @author Kadir#6666
--- Create at [19/05/2023] 10:09:26
--- Current project [Valestia-V1]
--- File name [Jobs]
---

Enums.Jobs = {

    Center = {

        Events = {

            Server = {

                Join = "vCore3:Valestia:jobs:center:join",
                Quit = "vCore3:Valestia:jobs:center:quit"

            }

        }

    },

    Farm = {

        Events = {

            Server = {

                TakeService = "vCore3:Valestia:jobs:farm:takeService",
                FinishMission = "vCore3:Valestia:jobs:farm:finishMission",

            },

            Client = {

                ServiceUpdate = "vCore3:Valestia:jobs:farm:serviceUpdate"

            }

        }

    }

}