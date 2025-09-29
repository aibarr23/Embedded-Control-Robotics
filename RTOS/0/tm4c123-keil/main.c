#include <stdint.h> // C99 standard integers
#include "bsp.h"



/* background code: sequential with blocking version */
int main(void) {
    BSP_init();
    while (1) {
        BSP_ledGreenOn();
        BSP_delay(BSP_TICKS_PER_SEC / 4U);
        BSP_ledGreenOff();
        BSP_delay(BSP_TICKS_PER_SEC * 3U / 4U);
    }

    //return 0;
}
