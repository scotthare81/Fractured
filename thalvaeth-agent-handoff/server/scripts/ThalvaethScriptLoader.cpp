/*
 * Thal'vaeth — Custom script loader (wire into AC Custom/CMakeLists + script loader)
 */

void AddSC_thalvaeth_creatures();
void AddSC_thalvaeth_creature_journal();
void AddSC_thalvaeth_run_gates();

void AddSC_thalvaeth_all()
{
    AddSC_thalvaeth_creatures();
    AddSC_thalvaeth_creature_journal();
    AddSC_thalvaeth_run_gates();
}
