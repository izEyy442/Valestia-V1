if Config.EnableGuidebookIntegration then

    local pokerContent = [[
        <h1>How to play Poker</h1> <p style="margin-bottom:15px">GTA Poker is played the same was as the classic Three Card Poker.</p>  <iframe src="https://www.youtube.com/embed/tcHOkqCgJnY"     style="border:0px;width:100%;min-height: 400px;margin-bottom:15px"> </iframe>  <h1>Bet Limits</h1> <p style="margin-bottom:15px">Each table has it's own bet limits, find the one that best suits your playing style.</p>  <style>     .dot {         height: 15px;         width: 15px;         background-color: #bbb;         border-radius: 50%;         display: inline-block;         margin-top: -3px;         vertical-align: middle;     } </style>  <table class="tb" style="width:100%;">     <tr style="height: 40px">         <th></th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(86, 113, 88)"></span> POKERNORMAL</th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(100, 86, 113)"></span> POKERHIGH</th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(78, 92, 113)"></span> POKERJUNIOR</th>     </tr>     <tr>         <td>ANTENAME</td>         <td>ANTENORMAL</td>         <td>ANTEHIGH</td>         <td>ANTEJUNIOR</td>     </tr>     <tr>         <td>PPNAME</td>         <td>PPNORMAL</td>         <td>PPHIGH</td>         <td>PPJUNIOR</td>     </tr> </table> <br /> <h1>Poker Rules</h1>  <h2>The Pack</h2> <p>A single standard 52-card pack is used. This is shuffled at the start of every hand.</p>  <h2>Dealer Hand</h2> <p>The Dealer must have a Queen high or better to play. If the Dealer does not play, Ante wagers are paid 1 to 1 and Play wagers are returned.</p>  <h2>Player Hand</h2> <p>Players can choose to bet on the Ante, Pair Plus, or both. After being dealt their cards, players that have bet the Ante must place an equal Play bet to compare their hand with the Dealer. Play and Ante bets pay out 1 to 1 if the player's hand beats the Dealer. The player needs a Straight or better to receive the Ante Bonus. For Pair Plus, the player must have a Pair or better to receive a payout. This is paid independently of what hand the Dealer has.</p>   <h2>Dealer Hand</h2> <p>The Dealer must have a Queen high or better to play. If the Dealer does not play, Ante wagers are paid 1 to 1 and Play wagers are returned.</p>  <h2>Pair Plus Payouts</h2>  <p><b>Straight Flush:</b> 40 to 1</p> <p><b>Three of a Kind:</b> 30 to 1</p> <p><b>Straight:</b> 6 to 1</p> <p><b>Flush:</b> 4 to 1</p> <p><b>Pair:</b> 1 to 1</p> <h2>Ante Bonus Payouts</h2> <p><b>Straight Flush:</b> 5 to 1</p> <p><b>Three of a Kind:</b> 4 to 1</p> <p><b>Straight: 1 to 1</b></p> <br/>
    ]]
    local rouletteContent = [[
        <h1>How to play Roulette</h1> <p style="margin-bottom:15px">GTA Roulette is played the same was as the classic Double Zero Roulette.</p> <iframe     src="https://www.youtube.com/embed/wRciBlaiCMU" style="border:0px;width:100%;min-height: 400px;margin-bottom:15px"> </iframe> <h1>Bet Limits</h1> <p style="margin-bottom:15px">Each table has it's own bet limits, find the one that best suits your playing style.</p> <style>     .dot {         height: 15px;         width: 15px;         background-color: #bbb;         border-radius: 50%;         display: inline-block;         margin-top: -3px;         vertical-align: middle;     } </style> <table class="tb" style="width:100%;">     <tr style="height: 40px">         <th></th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(86, 113, 88)"></span> RNORMAL         </th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(100, 86, 113)"></span> RHIGH</th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(78, 92, 113)"></span> RJUNIOR         </th>     </tr>     <tr>         <td>INSIDE</td>         <td>INSIDENORMAL</td>         <td>INSIDEHIGH</td>         <td>INSIDEJUNIOR</td>     </tr>     <tr>         <td>OUTSIDE</td>         <td>OUTSIDENORMAL</td>         <td>OUTSIDEHIGH</td>         <td>OUTSIDEJUNIOR</td>     </tr> </table> <br /> <h1>Roulette Rules</h1>  <h2>Inside Bets</h2>  <p><b>Straight-up:</b> A bet on an individual number. This pays 35 to 1.</p> <p><b>Split:</b> A two-number bet that's placed on the line connecting two numbers. This pays 17 to 1.</p> <p><b>Trio:</b> A three-number bet that includes zero, double zero, or both. This pays 11 to 1.</p> <p><b>Corner:</b> A four-number bet that's placed at the corner of four numbers. This pays 8 to 1.</p>  <h2>Outside Bets</h2>  <p><b>Red:</b> An eighteen-number bet that covers all of the red numbers. This pays 1 to 1.</p> <p><b>Black:</b> An eighteen-number bet that covers all of the black numbers. This pays 1 to 1.</p> <p><b>Even:</b> An eighteen-number bet that covers all of the even numbers. This pays 1 to 1.</p> <p><b>Odd:</b> An eighteen-number bet that covers all of the odd numbers. This pays 1 to 1.</p>  <h2>Halves</h2> <p><b>Halves:</b> An eighteen-number bet that covers the 1st half (1-18) or the 2nd half (19-36). This pays 1 to 1.</p> <p><b>Column:</b> A twelve-number bet that covers all of the numbers in the corresponding column. This pays 2 to 1.</p> <p><b>Dozen:</b> A twelve-number bet that covers 1-12, 13-24, or 25-36. This pays 2 to 1.</p><br/>
    ]]
    local blackjackContent = [[
        <h1>How to play Blackjack</h1> <p style="margin-bottom:15px">GTA Blackjack is played the same was as the classic Blackjack.</p> <iframe     src="https://www.youtube.com/embed/wRciBlaiCMU" style="border:0px;width:100%;min-height: 400px;margin-bottom:15px"> </iframe> <h1>Bet Limits</h1> <p style="margin-bottom:15px">Each table has it's own bet limits, find the one that best suits your playing style.</p> <style>     .dot {         height: 15px;         width: 15px;         background-color: #bbb;         border-radius: 50%;         display: inline-block;         margin-top: -3px;         vertical-align: middle;     } </style> <table class="tb" style="width:100%;">     <tr style="height: 40px">         <th></th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(86, 113, 88)"></span> BNORMAL         </th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(100, 86, 113)"></span> BHIGH</th>         <th style="text-align: center;"><span class="dot" style="background-color: rgb(78, 92, 113)"></span> BJUNIOR         </th>     </tr>     <tr>         <td>BETDATA</td>         <td>BETDATANORMAL</td>         <td>BETDATAHIGH</td>         <td>BETDATAJUNIOR</td>     </tr> </table><br /> <h1>Blackjack Rules</h1>  <h2>The Pack</h2> <p>This game uses four standard 52-card decks, which are shuffled at the start of every hand.</p>  <h2>Seven-Card Charlie</h2> <p>A player will automatically win if they manage to draw seven cards without going bust.</p>  <h2>Double Down</h2> <p>After a player has been dealt their two initial cards, they can double their bet in return for one additional card. This is also avaiable on both hands after splitting.</p>  <h2>Split</h2> <p>You can split your hand once if the first two cards have the same value. The same bet amount must be bet for the split hand.</p>  <h2>Card Values</h2> <p>Ace is worth 1 ot 11 points. Face cards are all worth 10 points and 2 to 10 are worth their pip value.</p>  <h2>Payout</h2> <p>Blackjack pays 3 to 2 of the bet value. Other winning bets pay even money.</p>  <h2>Dealer Hand</h2> <p>The Dealer will continue taking cards until they hit at least soft 17 or go bust. If the Dealer and player both have Blackjack, this will result in a push.</p>  <h2>Soft Hand</h2> <p>The combination of an ace with a card other than a ten-card is know as a 'soft hand' because the player can count the ace as a 1 or 11. A soft hand cannot go bust by taking another card.</p> <br/>
    ]]
    local aboutContent = [[
        <h1>Welcome to Diamond Casino!</h1> <p style="margin-bottom:15px">The perfect place to let loose and have some fun. From slots and blackjack to poker and roulette, we have it all. Diamond Casino is a high-end casino that offers a wide variety of gambling games and activities for players to take part in. There are plenty of casino games to choose from, including blackjack, poker, roulette, slot machines, and horse races.</p>  <img src="https://robinko.eu/rcore_casino/store_page.png" style="width:100%"> <button class="btn btn--icon-q" style="width: 200px;cursor: pointer;" type="gps" data-label="Diamond Casino"  data-x="928.574463" data-y="47.377232"> <span contenteditable="false"><svg><use xlink:href="img/teleport.svg#teleport"></use></svg>Diamond Casino</span> </button><br/>
    ]]

    pokerContent = pokerContent:gsub( "POKERNORMAL", PokerTableDatas[0].Title)
    pokerContent = pokerContent:gsub( "POKERHIGH", PokerTableDatas[3].Title)
    pokerContent = pokerContent:gsub( "POKERJUNIOR", PokerTableDatas[2].Title)
    pokerContent = pokerContent:gsub( "ANTENAME", Translation.Get("POKER_ANTE_BET"))
    pokerContent = pokerContent:gsub( "PPNAME", Translation.Get("POKER_PAIR_PLUS_BET"))
    pokerContent = pokerContent:gsub( "ANTENORMAL", PokerTableDatas[0].MinBetValueAntePlay .. " - " .. PokerTableDatas[0].MaxBetValueAntePlay)
    pokerContent = pokerContent:gsub( "ANTEHIGH", PokerTableDatas[3].MinBetValueAntePlay .. " - " .. PokerTableDatas[3].MaxBetValueAntePlay)
    pokerContent = pokerContent:gsub( "ANTEJUNIOR", PokerTableDatas[2].MinBetValueAntePlay .. " - " .. PokerTableDatas[2].MaxBetValueAntePlay)
    pokerContent = pokerContent:gsub( "PPNORMAL", PokerTableDatas[0].MinBetValuePairPlus .. " - " .. PokerTableDatas[0].MaxBetValuePairPlus)
    pokerContent = pokerContent:gsub( "PPHIGH", PokerTableDatas[3].MinBetValuePairPlus .. " - " .. PokerTableDatas[3].MaxBetValuePairPlus)
    pokerContent = pokerContent:gsub( "PPJUNIOR", PokerTableDatas[2].MinBetValuePairPlus .. " - " .. PokerTableDatas[2].MaxBetValuePairPlus)

    rouletteContent = rouletteContent:gsub( "RNORMAL", RouletteTableDatas[0].Title)
    rouletteContent = rouletteContent:gsub( "RHIGH", RouletteTableDatas[3].Title)
    rouletteContent = rouletteContent:gsub( "RJUNIOR", RouletteTableDatas[2].Title)
    rouletteContent = rouletteContent:gsub( "INSIDENORMAL", RouletteTableDatas[0].MinBetValue .. " - " .. RouletteTableDatas[0].MaxBetValueInside)
    rouletteContent = rouletteContent:gsub( "INSIDEHIGH", RouletteTableDatas[3].MinBetValue .. " - " .. RouletteTableDatas[3].MaxBetValueInside)
    rouletteContent = rouletteContent:gsub( "INSIDEJUNIOR", RouletteTableDatas[2].MinBetValue .. " - " .. RouletteTableDatas[2].MaxBetValueInside)
    rouletteContent = rouletteContent:gsub( "OUTSIDENORMAL", RouletteTableDatas[0].MinBetValue .. " - " .. RouletteTableDatas[0].MaxBetValueOutside)
    rouletteContent = rouletteContent:gsub( "OUTSIDEHIGH", RouletteTableDatas[3].MinBetValue .. " - " .. RouletteTableDatas[3].MaxBetValueOutside)
    rouletteContent = rouletteContent:gsub( "OUTSIDEJUNIOR", RouletteTableDatas[2].MinBetValue .. " - " .. RouletteTableDatas[2].MaxBetValueOutside)
    rouletteContent = rouletteContent:gsub( "INSIDE", Translation.Get("ROULETTE_RULES_INSIDE_BETS"))
    rouletteContent = rouletteContent:gsub( "OUTSIDE", Translation.Get("ROULETTE_RULES_OUTSIDE_BETS"))


    blackjackContent = blackjackContent:gsub( "BNORMAL", BlackjackTableDatas[0].Title)
    blackjackContent = blackjackContent:gsub( "BHIGH", BlackjackTableDatas[3].Title)
    blackjackContent = blackjackContent:gsub( "BJUNIOR", BlackjackTableDatas[2].Title)


    blackjackContent = blackjackContent:gsub( "BETDATANORMAL",  BlackjackTableDatas[0].MinimumBet .. " - " .. BlackjackTableDatas[0].MaximumBet)
    blackjackContent = blackjackContent:gsub( "BETDATAHIGH",  BlackjackTableDatas[2].MinimumBet .. " - " .. BlackjackTableDatas[2].MaximumBet)
    blackjackContent = blackjackContent:gsub( "BETDATAJUNIOR",  BlackjackTableDatas[3].MinimumBet .. " - " .. BlackjackTableDatas[3].MaximumBet)
    blackjackContent = blackjackContent:gsub( "BETDATA", Translation.Get("ROULETTE_RULES_BET_LIMITS"))



    local function AddPage(id, title, key, content)
        TriggerEvent("rcore_guidebook:saveInternal", "PAGE", {
            order_number = id,
            key = key,
            label = title,
            is_enabled = true,
            content = content,
            category_key = "casino"
        })
    end

    local function AddCategory(id, title, key)
        TriggerEvent("rcore_guidebook:saveInternal", "CATEGORY", {
            order_number = id,
            key = key,
            label = title,
            default_expand = false,
            is_enabled = true
        })
    end

    Citizen.CreateThread(function()

        local guidebookFound = false

        if LoadResourceFile(GetCurrentResourceName(), "guidebook_added") then
            return
        end

        TriggerEvent("rcore_guidebook:supportDynamicSave", function()
            guidebookFound = true
            SaveResourceFile(GetCurrentResourceName(), "guidebook_added", "1", 0)
            AddCategory(10, "Diamond Casino", "casino")
            Wait(100)
            AddPage(1, "About Diamond Casino", "casinoabout", aboutContent)
            Wait(100)
            AddPage(2, "How to Play Poker", "casinopoker", pokerContent)
            Wait(100)
            AddPage(3, "How to Play Roulette", "casinoroulette", rouletteContent)
            Wait(100)
            AddPage(4, "How to Play Blackjack", "casinoblackjack", blackjackContent)
            Wait(100)

            TriggerEvent("rcore_guidebook:saveInternal", "POINT", {
                is_enabled = true,
                can_navigate = true,
                draw_distance = 20.0,
                position = {
                    x = 923.010498,
                    y = 46.384212,
                    z = 72.073570
                },
                color = {
                    r = 255,
                    g = 255,
                    b = 255
                },
                size = 0.5,
                key = "casinoabouthelp",
                label = "Casino",
                -- Content
                content = nil,
                help_key = "casinoabout", -- if null its used content as custom or specific page is loaded.
                -- Blip
                blip_enabled = true,
                blip_size = 0.6,
                blip_display_type = 2,
                blip_sprite = 1,

                -- Marker
                marker_enabled = true,
                marker_draw_distance = 20.0,
                marker_size = {
                    x = 1.0,
                    y = 1.0,
                    z = 0.5
                },
                marker_color = {
                    r = 0,
                    g = 118,
                    b = 155
                },
                marker_type = 1
            })
        end)

        Wait(1000)

        if not guidebookFound then
            if GetResourceState("rcore_guidebook") == "started" then
                print("^1WARNING:^0 Please update your rcore_guidebook to have a help point added automatically")
            else
                print("^1WARNING:^0 Guidebook not found")
                print(
                    "^1WARNING:^0 This resource includes Guidebook point that shows info and rules of Diamond Casino.")
                print("^1WARNING:^0 You can purchase the guidebook at https://store.rcore.cz/package/5041989")
                print("^1WARNING:^0 Or disable this warning by setting EnableGuidebookIntegration to False")
            end
        end
    end)
end
