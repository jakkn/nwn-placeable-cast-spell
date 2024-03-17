#include "nwnx_events"

void InitOther()
{
  NWNX_Events_SubscribeEvent("NWNX_ON_INPUT_WALK_TO_WAYPOINT_BEFORE", "fire_catapult");
}

void main()
{
  InitOther();
}
