export interface Diagnoses {
  plantName: string
  status: string
  details: Details
}

export interface Details {
  plantName: string
  status: string
  description: string
  treatment: string
}
