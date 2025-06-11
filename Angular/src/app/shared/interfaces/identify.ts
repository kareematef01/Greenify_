export interface Identify {
  identifiedName: string
  details: Details
}

export interface Details {
  name: string
  scientificName: string
  growingConditions: GrowingConditions
  flower: Flower
  vitamins: string[]
  healthBenefits: string[]
}

export interface GrowingConditions {
  sunlight: string
  water: string
  soilType: string
}

export interface Flower {
  color: string
  morphology: string
}

