export interface Example {
  name: string,
  cardNames: string[]
}

const examples: Example[] = [
  {
    name: "Fruits",
    cardNames: ["apples", "oranges", "cherries", "kiwis", "limes", "strawberries", "blackberries", "avocado", "watermelon"]
  },
  {
    name: "Sports",
    cardNames: ["baseball", "basketball", "cricket", "soccer", "football", "water polo", "hockey", "quidditch"]
  },
  {
    name: "Friday Night Activities",
    cardNames: ["the bar", "the club", "house party", "working late", "Netflix", "hitting the gym", "a concert", "video games"]
  },
  {
    name: "Presidents",
    cardNames: ["Washington", "Jefferson", "Lincoln", "JFK", "Nixon", "FDR", "Teddy", "Coolidge", "William Henry Harrison"]
  },
  {
    name: "Movies",
    cardNames: ["Top Gun", "RENT", "Toy Story", "The Matrix", "Citizen Kane", "Star Trek: The Undiscovered Country", "Saving Private Ryan", "SAW"]
  },
  {
    name: "Metal Bands",
    cardNames: ["Marylin Manson", "Rob Zombie", "Metallica", "Guns ’n’ Roses", "Five Finger Death Punch", "BABYMETAL", "Korn", "Slipknot", "Rammstein"]
  },
  {
    name: "The Simpsons Supporting Cast",
    cardNames: ["Dr. Nick Riviera", "Bumblebee Man", "Sherry and/or Terry", "Lou", "Frank ‘Grimey’ Grimes", "Kodos", "Superintendent Chalmers", "Blinky"]
  }
]

export default examples
