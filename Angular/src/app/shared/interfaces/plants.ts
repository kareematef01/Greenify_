  export interface Plants {
    suggestions: string[]
    results: Result[]
  }
  
  export interface Result {
    plantName: string
    scientificName: string
    careLevel: string
    size: string
    edibility: string
    flowering: boolean
    medicinal: boolean
    isAirPurifying: boolean
    about: string
    details: Details
    images: Image[]
  }
  
  export interface Details {
    temperature: string
    sunlight: string
    water: string
    repotting: string
    fertilizing: string
    pests: string
  }
  
  export interface Image {
    imageUrl: string
  }
  
  