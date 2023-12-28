const content: string[] = ['text', 'image', 'equation', 'video']

export interface IEssay {
  _id?: string
  essay: {
    type: (typeof content)[number]
    value: string
  }[]
  createdAt?: Date
  updatedAt?: Date
}

export default function Essay({ _id, essay, createdAt, updatedAt }: IEssay) {
  return Object.freeze({
    getId: () => _id,
    getEssay: () => essay,
    getCreatedAt: () => createdAt,
    getUpdatedAt: () => updatedAt,
  })
}
