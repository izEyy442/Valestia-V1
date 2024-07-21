CREATE TABLE `casino_players` (
  `ID` int(11) NOT NULL,
  `identifier` varchar(128) NOT NULL,
  `properties` longtext NOT NULL
);

ALTER TABLE `casino_players`
  ADD PRIMARY KEY (`ID`);

ALTER TABLE `casino_players`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;
  