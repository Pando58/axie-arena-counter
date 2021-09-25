<template>
  <div class="container mx-auto h-screen p-4">
  
  <!-- Table -->
  <div class="h-full flex flex-col">
    <div class="mt-24"></div>
      <div class="flex-1">
        <div class="mx-auto h-full max-w-4xl rounded-lg overflow-hidden shadow bg-white border-b border-gray-200 text-sm sm:text-base text-center font-medium text-gray-500">
          <!-- Head -->
          <div class="py-3 flex divide-x divide-gray-200 bg-gray-50 border-b">
            <div class="flex-shrink w-16 sm:w-24">Round</div>
            <div class="flex-1">Energy</div>
            <div class="flex-1">Cards</div>
          </div>
          <div class="divide-y divide-gray-200">
            <!-- List -->
            <li
              class="py-3 flex divide-x divide-gray-200"
              v-for="round in rounds"
              :key="round.round"
            >
              <div class="flex-shrink w-16 sm:w-24 text-gray-300" v-if="round.round === 0">Start</div>
              <div class="flex-shrink w-16 sm:w-24" v-else>{{ round.round }}</div>
              <div class="flex-1">{{ round.energy }}</div>
              <div class="flex-1">{{ round.cards }}</div>
            </li>

            <!-- Current round -->
            <li class="py-3 flex divide-x divide-gray-200">
             <div class="flex-shrink w-16 sm:w-24 text-green-500">{{ rounds[rounds.length - 1].round + 1 }}</div>
              <div class="flex-1 px-3">
                <div class="flex justify-evenly">
                  <div class="flex">
                    <!-- List -->
                    <div class="relative">
                      <ul class="w-10 h-32 border rounded divide-y px-1 overflow-y-auto">
                        <li>-1</li>
                        <li>-2</li>
                        <li>-1</li>
                        <li>+1</li>
                      </ul>
                      <div class="absolute bottom-0 transform translate-x-12">
                        <i class="fas fa-backspace text-gray-400"></i>
                      </div>
                    </div>
                    <div class="w-7 h-7 ml-2 rounded-full border shadow flex items-center justify-center cursor-pointer">-2</div>
                    <div class="w-7 h-7 ml-2 rounded-full border shadow flex items-center justify-center cursor-pointer">-1</div>
                    <div class="w-7 h-7 ml-2 rounded-full border shadow flex items-center justify-center cursor-pointer">+1</div>
                  </div>

                  <!-- Numero total -->
                  <span>3</span>
                </div>
              </div>
              <div class="flex-1 px-3"></div>
            </li>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { reactive } from 'vue'

export default {
  setup() {
    const rounds = reactive([
      {
        round: 0,
        energy: 3,
        cards: 6
      },
      {
        round: 1,
        energy: 4,
        cards: 7
      },
    ]);

    return {
      rounds
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