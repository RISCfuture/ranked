export interface Card {
  name: string
}

export interface Stack {
  name: string
  created_at: string
  pairs_order: [number, number][]
  id: string
  cards: Card[]
}

export interface Error {
  name: string
}

export type Errors = {[field: string]: Error[]}
