#include "nwnx_events"
#include "nwnx_object"

void KI_FireCatapult(object oCatapult, location locTarget)
{
  AssignCommand(oCatapult, ActionCastSpellAtLocation(SPELL_FIREBALL, locTarget, METAMAGIC_ANY, TRUE, PROJECTILE_PATH_TYPE_BALLISTIC));

  ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SCREEN_BUMP), oCatapult);
  ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DUST_EXPLOSION), oCatapult);

  AssignCommand(oCatapult, PlaySound("sim_pulsnatr"));
}

string Events_GetEventData_NWNX_String(string sTag)
{
    return NWNX_Events_GetEventData(sTag);
}

int Events_GetEventData_NWNX_Int(string sTag)
{
    return StringToInt(Events_GetEventData_NWNX_String(sTag));
}

float Events_GetEventData_NWNX_Float(string sTag)
{
    return StringToFloat(Events_GetEventData_NWNX_String(sTag));
}

object Events_GetEventData_NWNX_Object(string sTag)
{
    return StringToObject(Events_GetEventData_NWNX_String(sTag));
}

vector Events_GetEventData_NWNX_Vector(string sTagX, string sTagY, string sTagZ)
{
    return Vector(Events_GetEventData_NWNX_Float(sTagX),
                  Events_GetEventData_NWNX_Float(sTagY),
                  Events_GetEventData_NWNX_Float(sTagZ));
}

location Events_GetEventData_NWNX_Location(string sTagArea, string sTagX, string sTagY, string sTagZ)
{
    return Location(Events_GetEventData_NWNX_Object(sTagArea),
                    Events_GetEventData_NWNX_Vector(sTagX, sTagY, sTagZ), 0.0f);
}

void main() {
  string sLauncherResref = "plc_catplt";
  object oPC = OBJECT_SELF;
  object oCatapult = GetFirstObjectInArea(GetArea(oPC), OBJECT_TYPE_PLACEABLE);
  location locTarget = Events_GetEventData_NWNX_Location("AREA", "POS_X", "POS_Y", "POS_Z");

  ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_PULSE_FIRE), locTarget);

  while(GetIsObjectValid(oCatapult) && GetResRef(oCatapult) != sLauncherResref) {
    oCatapult = GetNextObjectInArea(GetArea(oPC));
  }

  if(oCatapult == OBJECT_INVALID)
    oCatapult = CreateObject(OBJECT_TYPE_PLACEABLE, sLauncherResref, GetLocation(oPC));
  
  NWNX_Object_SetAILevel(oCatapult, 4);

  DelayCommand((Random(10) + 1) / 10.0f, KI_FireCatapult(oCatapult, locTarget));

  NWNX_Events_SkipEvent(); // stop walking
}
