<template>
  <div class="container mx-auto h-screen p-4">
  
  <!-- Table -->
  <div class="h-full flex flex-col">
    <div class="mt-24"></div>
      <div class="flex-1">
        <div class="mx-auto h-full max-w-4xl rounded-lg overflow-hidden shadow bg-white border-b border-gray-200 text-sm sm:text-base text-center font-medium text-gray-500">
          <div class="py-3 flex divide-x divide-gray-200 bg-gray-50 border-b">
            <div class="flex-shrink w-16 sm:w-24">Round</div>
            <div class="flex-1">Energy</div>
            <div class="flex-1">Cards</div>
          </div>
          <div class="divide-y divide-gray-200">
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