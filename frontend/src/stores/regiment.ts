import { type Ref, ref } from 'vue'
import { defineStore } from 'pinia'

export const useRegimentStore = defineStore('regiment', () => {
  const hasRegiment = ref(false)
  const userRegiment = ref()
  const showRegimentDialog = ref(false)
  const dialogRegiment = ref()
  const regiments = ref()
  const regimentsLoaded = ref(false)
  const upvotes: Ref<Map<string, number> | undefined> = ref()
  const upvotesLoaded = ref(false)
  const displayGrid = ref(true)

  const savePremium = async (regimentId: string, border: number, template: number) => {

  }

  const upvoteRegiment = async (regimentId: string) => {

  }

  const uploadImageAndGetUrl = async (file: string) => {

  }

  const uuidv4 = () => {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
      const r = (Math.random() * 16) | 0,
        v = c === 'x' ? r : (r & 0x3) | 0x8
      return v.toString(16)
    })
  }

  const getRegiments = async (force: boolean = false) => {

  }

  const fetchUpvotes = async () => {

  }

  const getUpvotes = async () => {

  }

  const getUserRegiment = async () => {

  }

  return {
    regiments,
    hasRegiment,
    userRegiment,
    showRegimentDialog,
    dialogRegiment,
    getRegiments,
    regimentsLoaded,
    uploadImageAndGetUrl,
    getUpvotes,
    upvotes,
    upvotesLoaded,
    upvoteRegiment,
    savePremium,
    getUserRegiment,
    displayGrid
  }
})
