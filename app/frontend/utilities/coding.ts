import * as _ from 'lodash'
import * as bigInt from 'big-integer'

export function encode(results: number[]): string {
  let resultsStr = _.map(results, r => r.toString()).join('')
  let resultsNum = bigInt(resultsStr, 4)
  return resultsNum.toString(36)
}

export function decode(param: string): number[] {
  let resultsNum = bigInt(param, 36)
  let resultsStr = resultsNum.toString(4)
  let resultsArray = resultsStr.split('')
  return _.map(resultsArray, r => Number.parseInt(r))
}
