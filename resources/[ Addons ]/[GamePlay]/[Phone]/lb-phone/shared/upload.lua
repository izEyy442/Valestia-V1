-----------------------------------------------------------------------------------------------------------------------------------
--                                       ONLY EDIT THIS FILE IF YOU KNOW WHAT YOU ARE DOING                                      --
--                                         WE WILL NOT HELP YOU, OR ANSWER ANY QUESTIONS                                         --
--                                  ASKING FOR HELP WITH THIS WILL RESULT IN AN INSTANT TIMEOUT                                  --
-----------------------------------------------------------------------------------------------------------------------------------































































UploadMethods = {
    Custom = {
        Video = {
            url = "https://api.fivemanage.com/api/video",
            field = "video",
            headers = {
                ["Authorization"] = "ZSLKOM7fFnXGCuRmFoWGRil6paXVRHlp"
            },
            success = {
                path = "url"
            },
            error = {
                path = "success",
                value = false
            },
        },
        Image = {
            url = "https://api.fivemanage.com/api/image",
            field = "image",
            headers = {
                ["Authorization"] = "ZSLKOM7fFnXGCuRmFoWGRil6paXVRHlp"
            },
            success = {
                path = "url"
            },
            error = {
                path = "success",
                value = false
            },
        },
        Audio = {
            url = "https://api.fivemanage.com/api/audio",
            field = "recording",
            headers = {
                ["Authorization"] = "ZSLKOM7fFnXGCuRmFoWGRil6paXVRHlp"
            },
            success = {
                path = "url"
            },
            error = {
                path = "success",
                value = false
            },
        },
    },
    Discord = {
        Video = {
            url = "https://discord.com/api/webhooks/1229905564054585465/NP5gOPiFCh-FDF3kFZtBvt1CpXjoa--J_CejYGxNc_SwxfkruuHFhBF-aYYAI9nMoceh",
            field = "files[]",
            error = {
                path = "code",
                value = 0
            },
            success = {
                path = "attachments.0.url"
            },
        },
        Image = {
            url = "https://discord.com/api/webhooks/1229905605821595658/zSQ4e5_kjWyXHHAld7Ik4bv88XZkm9xTpU66Q1Vznqr3a2KE0nebGpV8XV1JeGJIYg2c",
            field = "files[]",
            error = {
                path = "code",
                value = 0
            },
            success = {
                path = "attachments.0.url"
            }
        },
        Audio = {
            url = "https://discord.com/api/webhooks/1229905479405404202/KxeL29Xn11UAAe44EB3AO8qNDLM_0XLjuFOCfiWOBtHwQCCtMs-FQjN-WdMGQ7aaTQBU",
            field = "files[]",
            error = {
                path = "code",
                value = 0
            },
            success = {
                path = "attachments.0.url"
            }
        },
    },
    Imgur = {
        Video = {
            url = "https://api.imgur.com/3/upload",
            field = "image",
            headers = {
                ["Authorization"] = "Client-ID API_KEY"
            },
            error = {
                path = "success",
                value = false
            },
            success = {
                path = "data.link"
            },
            suffix = "mp4",
        },
        Image = {
            url = "https://api.imgur.com/3/upload",
            field = "image",
            headers = {
                ["Authorization"] = "Client-ID API_KEY"
            },
            error = {
                path = "success",
                value = false
            },
            success = {
                path = "data.link"
            },
        },
    },
}
