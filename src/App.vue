<template>
  <div class="container mx-auto h-screen p-4">
  
  <!-- Table -->
  <div class="h-full flex flex-col">
    <div class="pt-24 h-full flex-1">
      <div class="mx-auto h-full flex-col max-w-4xl rounded-lg overflow-hidden shadow bg-white border-b border-gray-200 text-sm sm:text-base text-center font-medium text-gray-500">
        <!-- Head -->
        <div class="py-3 flex divide-x divide-gray-200 bg-gray-50 border-b">
          <div class="flex-shrink w-16 sm:w-24">Round</div>
          <div class="flex-1">Energy</div>
          <div class="flex-1">Cards</div>
        </div>

        <!-- Content -->
        <ul class="h-full divide-y divide-gray-200 overflow-y-auto pb-16">
          <!-- List -->
          <li
            class="py-3 flex divide-x divide-gray-200"
            v-for="round in rounds"
            :key="round.round"
          >
          <div class="flex-shrink w-16 sm:w-24">{{ round.round }}</div>
            <div class="flex-1">{{ round.finalEnergy }}</div>
            <div class="flex-1">{{ round.finalCards }}</div>
          </li>

          <!-- Current round -->
          <li class="py-3 flex divide-x divide-gray-200">
            <div class="flex-shrink w-16 sm:w-24 text-green-500">
              <div>{{ currentRound.round }}</div>
              <i
                class="fas fa-plus-circle text-2xl mt-1"
                @click="addRound"
              ></i>
            </div>

            <!-- Energy -->
            <div class="flex-1 px-3">
              <div class="flex justify-evenly">
                <div class="flex">

                  <!-- List -->
                  <div class="relative">
                    <ul class="w-10 h-32 border rounded divide-y px-1 overflow-y-auto">
                      <li v-for="i in currentRound.energyMath" :key="i">{{ i }}</li>
                    </ul>
                    <div class="absolute bottom-0 transform translate-x-12">
                      <i
                        class="fas fa-backspace text-gray-400"
                        @click="currentRound.energyMath.pop()"
                      ></i>
                    </div>
                  </div>

                  <!-- Buttons -->
                  <div
                    class="w-7 h-7 ml-2 rounded-full border shadow flex items-center justify-center cursor-pointer"
                    @click="currentRound.energyMath.push('-2')"
                  >
                    -2
                  </div>
                  <div
                    class="w-7 h-7 ml-2 rounded-full border shadow flex items-center justify-center cursor-pointer"
                    @click="currentRound.energyMath.push('-1')"
                  >
                    -1
                  </div>
                  <div
                    class="w-7 h-7 ml-2 rounded-full border shadow flex items-center justify-center cursor-pointer"
                    @click="currentRound.energyMath.push('+1')"
                  >
                    +1
                  </div>
                </div>

                <!-- Total -->
                <span>{{ energyTotal }}</span>
              </div>
            </div>

            <!-- Cards -->
            <div class="flex-1 px-3">
              <div class="flex justify-evenly">
                <div class="flex">

                  <!-- List -->
                  <div class="relative">
                    <ul class="w-10 h-32 border rounded divide-y px-1 overflow-y-auto">
                      <li v-for="i in currentRound.cardsMath" :key="i">{{ i }}</li>
                    </ul>
                    <div class="absolute bottom-0 transform translate-x-12">
                      <i
                        class="fas fa-backspace text-gray-400"
                        @click="currentRound.cardsMath.pop()"
                      ></i>
                    </div>
                  </div>

                  <!-- Buttons -->
                  <div
                    class="w-7 h-7 ml-2 rounded-full border shadow flex items-center justify-center cursor-pointer"
                    @click="currentRound.cardsMath.push('-1')"
                  >
                    -1
                  </div>
                  <div
                    class="w-7 h-7 ml-2 rounded-full border shadow flex items-center justify-center cursor-pointer"
                    @click="currentRound.cardsMath.push('+1')"
                  >
                    +1
                  </div>
                </div>

                <!-- Total -->
                <span>{{ cardsTotal }}</span>
              </div>
            </div>

          </li>
        </ul>
      </div>
    </div>
    </div>
  </div>
</template>

<script>
import { ref, reactive, computed, onBeforeMount } from 'vue'

export default {
  setup() {
    const rounds = reactive([]);
    const currentRound = ref(null);

    const energyTotal = computed(() => {
      let total = currentRound.value.energy;
      
      currentRound.value.energyMath.forEach(i => {
        if (i === '-2') total -= 2;
        if (i === '-1') total--;
        if (i === '+1') total++;
      });

      return Math.max(Math.min(total, 10), 0);
    });

    const cardsTotal = computed(() => {
      let total = currentRound.value.cards;
      
      currentRound.value.cardsMath.forEach(i => {
        if (i === '-1') total--;
        if (i === '+1') total++;
      });

      return Math.max(Math.min(total, 12), 0);
    });

    const restartRounds = () => {
      rounds.splice(0, rounds.length);
    };

    const createRound = () => {
      if (rounds.length == 0) {
        currentRound.value = {
          round: 1,
          energy: 3,
          cards: 6,
          energyMath: [],
          cardsMath: [],
          finalEnergy: null,
          finalCards: null
        }
        return;
      }
      
      const lastRound = rounds[rounds.length - 1];

      currentRound.value = {
        round: lastRound.round + 1,
        energy: lastRound.finalEnergy + 2,
        cards: lastRound.finalCards + 3,
        energyMath: [],
        cardsMath: [],
        finalEnergy: null,
        finalCards: null
      };
    };

    const addRound = () => {
      currentRound.value.finalEnergy = energyTotal.value;
      currentRound.value.finalCards = cardsTotal.value;
      rounds.push(currentRound.value);
      createRound();
    };

    onBeforeMount(() => {
      restartRounds();
      createRound();
    });

    return {
      rounds,
      currentRound,
      energyTotal,
      cardsTotal,
      restartRounds,
      createRound,
      addRound,
    };
  }
}
</script>

<style>
/* width */
::-webkit-scrollbar {
  width: 8px;
}

/* Track */
::-webkit-scrollbar-track {
  @apply bg-gray-200;
}
 
/* Handle */
::-webkit-scrollbar-thumb {
  @apply bg-gray-400 rounded;
}

/* Handle on hover */
::-webkit-scrollbar-thumb:hover {
  @apply bg-gray-500;
}
</style>