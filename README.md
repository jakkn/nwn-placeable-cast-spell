# nwn-placeable-cast-spell

Template for nwnee projects with nwnx installed, running Docker.

This project is a quick repro of the catapult feature in https://github.com/Daztek/EquinoxFramework/, and most of the code was copied from [es_s_kobinv.nss](https://github.com/Daztek/EventSystem/blob/master/Components/Subsystems/es_s_kobinv.nss). All credit to Daz for the implementation.

## Use

Use [nasher](https://github.com/squattingmonk/nasher) to manage the sources.

A utility script named `./run-commands.sh` has been added to speed up running frequent commands, inlcuding a useful watch-utility to hot compile scripts on file save (option 2).

## Requirements

- `docker` (with `compose`)
- `nasher`
- `entr` (to hot compile)
