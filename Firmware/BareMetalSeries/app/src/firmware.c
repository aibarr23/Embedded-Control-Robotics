#include <libopencm3/stm32/rcc.h>
#include <libopencm3/stm32/gpio.h>

#include "core/system.h"

#define LED_PORT (GPIOA)
#define LED_PIN  (GPIO5)

#define CPU_FREQ      (84000000)
#define SYSTICK_FREQ  (1000)

static void gpio_setup(void){
  rcc_periph_clock_enable(RCC_GPIOA);
  gpio_mode_setup(LED_PORT, GPIO_MODE_OUTPUT, GPIO_PUPD_NONE, LED_PIN);
}

int main(void) {
  system_setup();
  gpio_setup();

  uint64_t start_time = system_get_ticks();

  while(1){
    if(get_ticks() - start_time >= 1000){
      gpio_toggle(LED_PORT, LED_PIN);
      start_time = system_get_ticks();
    }

  }

  // Never return
  return 0;
}
