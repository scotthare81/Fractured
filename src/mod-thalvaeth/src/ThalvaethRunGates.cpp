/*
 * Thal'vaeth — run district gates (segment + extract)
 */

#include "ThalvaethCommon.h"
#include "ThalvaethDirector.h"
#include "GameObjectAI.h"
#include "GameObjectScript.h"
#include "Player.h"
#include "ScriptMgr.h"

namespace Thalvaeth::Gates
{
    struct go_thalvaeth_gate_segment : public GameObjectAI
    {
        go_thalvaeth_gate_segment(GameObject* go) : GameObjectAI(go) { }

        bool OnReportUse(Player* /*player*/) override
        {
            // Closed until Director opens — no player use
            return true;
        }
    };

    struct go_thalvaeth_gate_extract : public GameObjectAI
    {
        go_thalvaeth_gate_extract(GameObject* go) : GameObjectAI(go) { }

        bool OnReportUse(Player* player) override
        {
            if (!player)
                return true;

            // TODO: validate extract conditions (alive, loot flagged, etc.)
            player->TeleportTo(0, 2793.09f, -1621.40f, 129.33f, 1.987f);
            Director::ClearRunFog(player->GetMap(), player->GetZoneId());
            return true;
        }
    };
}

void AddSC_thalvaeth_run_gates()
{
    using namespace Thalvaeth::Gates;
    RegisterGameObjectAI(go_thalvaeth_gate_segment);
    RegisterGameObjectAI(go_thalvaeth_gate_extract);
}
