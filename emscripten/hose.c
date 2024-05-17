#include <stdio.h>
#include <libPlasma/c/slaw.h>
#include <libPlasma/c/protein.h>
#include <libPlasma/c/pool.h>

int main()
{
    slaw descrips = slaw_list_inline_f(slaw_string("hello darkness my old friend"), NULL);
    slaw ingests = slaw_map_empty();
    protein p = protein_from(descrips, ingests);
    pool_hose h = NULL;
    ob_retort ok = pool_participate("tcp://beehive/test", &h, NULL);
    pool_deposit(h, p, NULL);
    return 0;
}